//
//  PurchaseViewModel.swift
//  PromptCraftAcademy
//
//  Manages in-app purchase flow and state
//

import Foundation
import StoreKit
import SwiftUI

@MainActor
class PurchaseViewModel: ObservableObject {
    @Published var isPurchasing = false
    @Published var showPurchaseSuccess = false
    @Published var showPurchaseError = false
    @Published var errorMessage = ""

    private let storeManager = StoreKitManager.shared
    private let progressManager = ProgressManager.shared

    var hasUnlockedFullCourse: Bool {
        storeManager.hasUnlockedFullCourse || progressManager.hasFullAccess
    }

    var fullCourseProduct: Product? {
        storeManager.fullCourseProduct
    }

    var formattedPrice: String {
        storeManager.formattedPrice
    }

    var purchaseState: StoreKitManager.PurchaseState {
        storeManager.purchaseState
    }

    // MARK: - Purchase Actions

    func purchaseFullCourse() async {
        guard let product = fullCourseProduct else {
            errorMessage = "Product not available"
            showPurchaseError = true
            return
        }

        isPurchasing = true

        await storeManager.purchase(product)

        isPurchasing = false

        switch storeManager.purchaseState {
        case .success:
            progressManager.unlockFullAccess()
            showPurchaseSuccess = true

        case .failed(let error):
            errorMessage = error.localizedDescription
            showPurchaseError = true

        case .cancelled:
            // User cancelled, no action needed
            break

        default:
            break
        }
    }

    func restorePurchases() async {
        isPurchasing = true
        await storeManager.restorePurchases()

        if storeManager.hasUnlockedFullCourse {
            progressManager.unlockFullAccess()
            showPurchaseSuccess = true
        }

        isPurchasing = false
    }

    // MARK: - Unlock Benefits

    var unlockBenefits: [String] {
        [
            "Access to all 6 premium lessons",
            "Advanced prompting techniques",
            "Real-world production patterns",
            "Certificate of completion",
            "Lifetime access to content",
            "Future course updates included"
        ]
    }

    var totalLessonCount: Int {
        8
    }

    var premiumLessonCount: Int {
        6
    }
}
