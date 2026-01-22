//
//  PaywallView.swift
//  PromptCraftAcademy
//
//  Purchase prompt for locked content
//

import SwiftUI

struct PaywallView: View {
    @EnvironmentObject var storeKitManager: StoreKitManager
    @EnvironmentObject var progressManager: ProgressManager
    @Environment(\.dismiss) private var dismiss

    @State private var isPurchasing = false
    @State private var showPurchaseSuccess = false
    @State private var showPurchaseError = false
    @State private var errorMessage = ""

    private let unlockBenefits = [
        "Access to all 6 premium lessons",
        "Advanced prompting techniques",
        "Real-world production patterns",
        "Certificate of completion",
        "Lifetime access to content",
        "Future course updates included"
    ]

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 30) {
                    // Header
                    headerSection

                    // Benefits
                    benefitsSection

                    // What's included
                    includedLessonsSection

                    // Purchase button
                    purchaseSection

                    // Restore purchases
                    restoreButton
                }
                .padding()
            }
            .background(Color(UIColor.systemGroupedBackground))
            .navigationTitle("Unlock Full Course")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Close") {
                        dismiss()
                    }
                }
            }
            .alert("Purchase Successful!", isPresented: $showPurchaseSuccess) {
                Button("Start Learning") {
                    dismiss()
                }
            } message: {
                Text("You now have access to all premium lessons and can earn your certificate!")
            }
            .alert("Purchase Failed", isPresented: $showPurchaseError) {
                Button("OK", role: .cancel) { }
            } message: {
                Text(errorMessage)
            }
        }
    }

    // MARK: - Header

    private var headerSection: some View {
        VStack(spacing: 16) {
            ZStack {
                Circle()
                    .fill(
                        LinearGradient(
                            colors: [.blue, .purple],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(width: 100, height: 100)

                Image(systemName: "lock.open.fill")
                    .font(.system(size: 50))
                    .foregroundColor(.white)
            }

            Text("Unlock Your Potential")
                .font(.title)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)

            Text("Get lifetime access to all premium content and master AI-assisted coding")
                .font(.subheadline)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
        }
    }

    // MARK: - Benefits

    private var benefitsSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("What's Included")
                .font(.title2)
                .fontWeight(.bold)

            VStack(spacing: 12) {
                ForEach(unlockBenefits, id: \.self) { benefit in
                    HStack(alignment: .top, spacing: 12) {
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundColor(.green)
                            .font(.title3)

                        Text(benefit)
                            .font(.body)
                            .foregroundColor(.primary)

                        Spacer()
                    }
                }
            }
        }
        .padding()
        .background(Color(UIColor.secondarySystemGroupedBackground))
        .cornerRadius(12)
    }

    // MARK: - Included Lessons

    private var includedLessonsSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Premium Lessons")
                .font(.headline)

            VStack(spacing: 8) {
                lessonItem(number: 3, title: "Advanced Prompt Engineering", duration: "25 min")
                lessonItem(number: 4, title: "Debugging with AI", duration: "20 min")
                lessonItem(number: 5, title: "Refactoring & Code Review", duration: "25 min")
                lessonItem(number: 6, title: "Documentation & Comments", duration: "20 min")
                lessonItem(number: 7, title: "Test Generation", duration: "25 min")
                lessonItem(number: 8, title: "Production-Ready Patterns", duration: "30 min")
            }

            HStack {
                Spacer()
                Text("Total: 145 minutes of premium content")
                    .font(.caption)
                    .foregroundColor(.secondary)
                Spacer()
            }
            .padding(.top, 8)
        }
        .padding()
        .background(Color(UIColor.secondarySystemGroupedBackground))
        .cornerRadius(12)
    }

    private func lessonItem(number: Int, title: String, duration: String) -> some View {
        HStack {
            ZStack {
                Circle()
                    .fill(Color.purple.opacity(0.2))
                    .frame(width: 32, height: 32)

                Text("\(number)")
                    .font(.caption)
                    .fontWeight(.bold)
                    .foregroundColor(.purple)
            }

            Text(title)
                .font(.subheadline)

            Spacer()

            Text(duration)
                .font(.caption)
                .foregroundColor(.secondary)
        }
    }

    // MARK: - Purchase Section

    private var purchaseSection: some View {
        VStack(spacing: 16) {
            Button {
                Task {
                    await purchaseFullCourse()
                }
            } label: {
                HStack {
                    if isPurchasing {
                        ProgressView()
                            .tint(.white)
                    } else {
                        Text("Unlock Full Course")
                        Text("•")
                        Text(storeKitManager.formattedPrice)
                    }
                }
                .font(.headline)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding()
                .background(
                    LinearGradient(
                        colors: [.blue, .purple],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
                .cornerRadius(12)
            }
            .disabled(isPurchasing)

            VStack(spacing: 4) {
                Text("One-time purchase • Lifetime access")
                    .font(.caption)
                    .foregroundColor(.secondary)

                Text("All future updates included")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
    }

    // MARK: - Restore Button

    private var restoreButton: some View {
        Button {
            Task {
                await restorePurchases()
            }
        } label: {
            Text("Restore Purchases")
                .font(.subheadline)
                .foregroundColor(.blue)
        }
        .disabled(isPurchasing)
    }

    // MARK: - Purchase Actions

    private func purchaseFullCourse() async {
        guard let product = storeKitManager.fullCourseProduct else {
            errorMessage = "Product not available"
            showPurchaseError = true
            return
        }

        isPurchasing = true
        await storeKitManager.purchase(product)
        isPurchasing = false

        switch storeKitManager.purchaseState {
        case .success:
            progressManager.unlockFullAccess()
            showPurchaseSuccess = true
        case .failed(let error):
            errorMessage = error.localizedDescription
            showPurchaseError = true
        case .cancelled:
            break
        default:
            break
        }
    }

    private func restorePurchases() async {
        isPurchasing = true
        await storeKitManager.restorePurchases()

        if storeKitManager.hasUnlockedFullCourse {
            progressManager.unlockFullAccess()
            showPurchaseSuccess = true
        }

        isPurchasing = false
    }
}

// MARK: - Preview

#Preview {
    PaywallView()
}
