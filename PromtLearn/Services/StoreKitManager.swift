//
//  StoreKitManager.swift
//  PromptCraftAcademy
//
//  Handles in-app purchase logic using StoreKit 2
//

import Foundation
import StoreKit

@MainActor
class StoreKitManager: ObservableObject {
    static let shared = StoreKitManager()

    // Product ID for full course unlock
    private let fullCourseProductID = "com.promptcraft.fullcourse"

    @Published private(set) var products: [Product] = []
    @Published private(set) var purchasedProductIDs = Set<String>()
    @Published private(set) var purchaseState: PurchaseState = .idle

    enum PurchaseState {
        case idle
        case purchasing
        case success
        case failed(Error)
        case cancelled
    }

    private var updateListenerTask: Task<Void, Error>?

    init() {
        updateListenerTask = listenForTransactions()
        Task {
            await loadProducts()
            await updateCustomerProductStatus()
        }
    }

    deinit {
        updateListenerTask?.cancel()
    }

    // MARK: - Product Loading

    func loadProducts() async {
        do {
            let loadedProducts = try await Product.products(for: [fullCourseProductID])
            self.products = loadedProducts
        } catch {
            print("Failed to load products: \(error)")
        }
    }

    // MARK: - Purchase Flow

    func purchase(_ product: Product) async {
        purchaseState = .purchasing

        do {
            let result = try await product.purchase()

            switch result {
            case .success(let verification):
                let transaction = try checkVerified(verification)
                await transaction.finish()
                await updateCustomerProductStatus()
                purchaseState = .success

            case .userCancelled:
                purchaseState = .cancelled

            case .pending:
                purchaseState = .idle

            @unknown default:
                purchaseState = .idle
            }
        } catch {
            purchaseState = .failed(error)
            print("Purchase failed: \(error)")
        }
    }

    // MARK: - Restore Purchases

    func restorePurchases() async {
        do {
            try await AppStore.sync()
            await updateCustomerProductStatus()
        } catch {
            print("Failed to restore purchases: \(error)")
        }
    }

    // MARK: - Transaction Verification

    nonisolated func checkVerified<T>(_ result: VerificationResult<T>) throws -> T {
        switch result {
        case .unverified:
            throw StoreError.failedVerification
        case .verified(let safe):
            return safe
        }
    }

    // MARK: - Update Purchase Status

    @MainActor
    func updateCustomerProductStatus() async {
        var purchasedProducts: Set<String> = []

        for await result in Transaction.currentEntitlements {
            do {
                let transaction = try checkVerified(result)

                if transaction.productID == fullCourseProductID {
                    purchasedProducts.insert(transaction.productID)
                }
            } catch {
                print("Transaction verification failed: \(error)")
            }
        }

        self.purchasedProductIDs = purchasedProducts
    }

    // MARK: - Transaction Listener

    func listenForTransactions() -> Task<Void, Error> {
        return Task.detached {
            for await result in Transaction.updates {
                do {
                    let transaction = try self.checkVerified(result)
                    await transaction.finish()
                    await self.updateCustomerProductStatus()
                } catch {
                    print("Transaction failed verification: \(error)")
                }
            }
        }
    }

    // MARK: - Convenience Properties

    var hasUnlockedFullCourse: Bool {
        !purchasedProductIDs.isEmpty
    }

    var fullCourseProduct: Product? {
        products.first { $0.id == fullCourseProductID }
    }

    var formattedPrice: String {
        fullCourseProduct?.displayPrice ?? "$9.99"
    }
}

// MARK: - Store Errors

enum StoreError: Error {
    case failedVerification
}
