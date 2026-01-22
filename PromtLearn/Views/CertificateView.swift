//
//  CertificateView.swift
//  PromptCraftAcademy
//
//  Certification display view
//

import SwiftUI

struct CertificateView: View {
    @EnvironmentObject var progressManager: ProgressManager
    @EnvironmentObject var authManager: AuthenticationManager
    @State private var showShareSheet = false

    var body: some View {
        ScrollView {
            VStack(spacing: 30) {
                if progressManager.hasCertificate {
                    certificateContent
                } else {
                    notEligibleContent
                }
            }
            .padding()
        }
        .background(Color(UIColor.systemGroupedBackground))
        .navigationTitle("Certificate")
        .navigationBarTitleDisplayMode(.large)
    }

    // MARK: - Certificate Content

    private var certificateContent: some View {
        VStack(spacing: 24) {
            // Celebration header
            VStack(spacing: 12) {
                Image(systemName: "seal.fill")
                    .font(.system(size: 80))
                    .foregroundStyle(
                        LinearGradient(
                            colors: [.yellow, .orange],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )

                Text("Congratulations!")
                    .font(.title)
                    .fontWeight(.bold)

                Text("You've completed the AI Prompting Masterclass")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
            }

            // Certificate card
            certificateCard

            // Stats
            statsSection

            // Share button
            shareButton
        }
    }

    // MARK: - Certificate Card

    private var certificateCard: some View {
        let status = progressManager.getCertificationStatus()

        return VStack(spacing: 20) {
            // Certificate border decoration
            VStack(spacing: 16) {
                Image(systemName: "seal.fill")
                    .font(.system(size: 40))
                    .foregroundColor(.yellow)

                Text("Certificate of Completion")
                    .font(.title3)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)

                Divider()
                    .background(Color.blue)

                VStack(spacing: 12) {
                    Text("AI Prompting Masterclass")
                        .font(.headline)
                        .multilineTextAlignment(.center)

                    Text("for Coders")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }

                Divider()
                    .background(Color.blue)

                VStack(spacing: 8) {
                    Text("This certifies that")
                        .font(.caption)
                        .foregroundColor(.secondary)

                    if authManager.userName.isEmpty {
                        Button {
                            // Show name input
                        } label: {
                            Text("Add Your Name")
                                .font(.title3)
                                .fontWeight(.semibold)
                                .foregroundColor(.blue)
                        }
                    } else {
                        Text(authManager.userName)
                            .font(.title2)
                            .fontWeight(.semibold)
                    }

                    Text("has successfully completed all 8 lessons")
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                }

                Divider()
                    .background(Color.blue)

                VStack(spacing: 4) {
                    Text("Completed")
                        .font(.caption)
                        .foregroundColor(.secondary)

                    Text(status.formattedDate)
                        .font(.subheadline)
                        .fontWeight(.medium)
                }

                // PromptCraft Academy logo/signature
                VStack(spacing: 4) {
                    Image(systemName: "brain.head.profile")
                        .font(.title2)
                        .foregroundStyle(
                            LinearGradient(
                                colors: [.blue, .purple],
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )

                    Text("PromptCraft Academy")
                        .font(.caption)
                        .fontWeight(.semibold)
                }
            }
            .padding(30)
            .background(Color.white)
            .cornerRadius(16)
            .shadow(color: Color.black.opacity(0.15), radius: 10, x: 0, y: 5)
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(
                        LinearGradient(
                            colors: [.blue, .purple, .yellow],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ),
                        lineWidth: 3
                    )
            )
        }
    }

    // MARK: - Stats Section

    private var statsSection: some View {
        VStack(spacing: 12) {
            Text("Your Achievement")
                .font(.headline)

            HStack(spacing: 20) {
                statCard(icon: "checkmark.circle.fill", value: "8", label: "Lessons", color: .green)
                statCard(icon: "clock.fill", value: "180", label: "Minutes", color: .blue)
                statCard(icon: "star.fill", value: "100%", label: "Complete", color: .yellow)
            }
        }
        .padding()
        .background(Color(UIColor.secondarySystemGroupedBackground))
        .cornerRadius(12)
    }

    private func statCard(icon: String, value: String, label: String, color: Color) -> some View {
        VStack(spacing: 8) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundColor(color)

            Text(value)
                .font(.title3)
                .fontWeight(.bold)

            Text(label)
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color(UIColor.tertiarySystemGroupedBackground))
        .cornerRadius(10)
    }

    // MARK: - Share Button

    private var shareButton: some View {
        Button {
            showShareSheet = true
        } label: {
            HStack {
                Image(systemName: "square.and.arrow.up")
                Text("Share Certificate")
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
    }

    // MARK: - Not Eligible Content

    private var notEligibleContent: some View {
        VStack(spacing: 20) {
            Image(systemName: "seal")
                .font(.system(size: 80))
                .foregroundColor(.secondary)

            Text("Certificate Not Yet Earned")
                .font(.title2)
                .fontWeight(.bold)

            Text("Complete all 8 lessons to earn your certificate")
                .font(.subheadline)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)

            VStack(spacing: 12) {
                HStack {
                    Text("Progress")
                        .font(.headline)
                    Spacer()
                    Text("\(progressManager.completedLessonsCount) / \(progressManager.totalLessonsCount)")
                        .font(.headline)
                        .foregroundColor(.blue)
                }

                ProgressBar(progress: progressManager.completionPercentage)
                    .frame(height: 8)
            }
            .padding()
            .background(Color(UIColor.secondarySystemGroupedBackground))
            .cornerRadius(12)

            Text("Keep learning to unlock your certificate!")
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
    }
}

// MARK: - Preview

#Preview("With Certificate") {
    NavigationStack {
        CertificateView()
    }
}

#Preview("Without Certificate") {
    NavigationStack {
        CertificateView()
    }
}
