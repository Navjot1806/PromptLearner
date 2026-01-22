//
//  HomeView.swift
//  PromptCraftAcademy
//
//  Main landing view with welcome and progress overview
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var authManager: AuthenticationManager
    @EnvironmentObject var progressManager: ProgressManager
    @EnvironmentObject var storeKitManager: StoreKitManager

    @State private var lessons: [Lesson] = LessonContentProvider.shared.allLessons

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 24) {
                    // Header
                    headerSection

                    // Progress Overview
                    progressSection

                    // Quick Actions
                    quickActionsSection

                    // Features
                    featuresSection

                    Spacer(minLength: 20)
                }
                .padding()
            }
            .background(Color(UIColor.systemGroupedBackground))
            .navigationTitle("PromptCraft Academy")
            .navigationBarTitleDisplayMode(.large)
        }
    }

    // MARK: - Header Section

    private var headerSection: some View {
        VStack(spacing: 12) {
            Image(systemName: "brain.head.profile")
                .font(.system(size: 60))
                .foregroundStyle(
                    LinearGradient(
                        colors: [.blue, .purple],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )

            Text("Welcome to PromptCraft Academy")
                .font(.title2)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)

            Text("Master AI prompting for professional code development")
                .font(.subheadline)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
        }
        .padding()
    }

    // MARK: - Progress Section

    private var progressSection: some View {
        VStack(spacing: 16) {
            HStack {
                Text("Your Progress")
                    .font(.headline)
                Spacer()
            }

            HStack(spacing: 20) {
                // Circular progress
                CircularProgressView(progress: progressManager.completionPercentage)
                    .frame(width: 100, height: 100)

                // Stats
                VStack(alignment: .leading, spacing: 12) {
                    HStack {
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundColor(.green)
                        Text("\(progressManager.completedLessonsCount) of \(progressManager.totalLessonsCount) lessons completed")
                            .font(.subheadline)
                    }

                    if progressManager.remainingLessonsCount > 0 {
                        HStack {
                            Image(systemName: "book.circle")
                                .foregroundColor(.blue)
                            Text("\(progressManager.remainingLessonsCount) lessons remaining")
                                .font(.subheadline)
                        }
                    }

                    if progressManager.hasCertificate {
                        HStack {
                            Image(systemName: "seal.fill")
                                .foregroundColor(.yellow)
                            Text("Certificate earned!")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                        }
                    }
                }

                Spacer()
            }
            .padding()
            .background(Color(UIColor.secondarySystemGroupedBackground))
            .cornerRadius(12)
        }
    }

    // MARK: - Quick Actions

    private var quickActionsSection: some View {
        VStack(spacing: 12) {
            HStack {
                Text("Quick Actions")
                    .font(.headline)
                Spacer()
            }

            VStack(spacing: 12) {
                NavigationLink(destination: LessonListView()) {
                    ActionButton(
                        icon: "book.fill",
                        title: "Browse Lessons",
                        subtitle: "8 comprehensive lessons",
                        color: .blue
                    )
                }

                if !storeKitManager.hasUnlockedFullCourse || progressManager.hasFullAccess {
                    NavigationLink(destination: PaywallView()) {
                        ActionButton(
                            icon: "lock.open.fill",
                            title: "Unlock Full Course",
                            subtitle: "Access all premium content",
                            color: .purple
                        )
                    }
                }

                if progressManager.hasCertificate {
                    NavigationLink(destination: CertificateView()) {
                        ActionButton(
                            icon: "seal.fill",
                            title: "View Certificate",
                            subtitle: "Your achievement",
                            color: .yellow
                        )
                    }
                }
            }
        }
    }

    // MARK: - Features Section

    private var featuresSection: some View {
        VStack(spacing: 16) {
            HStack {
                Text("What You'll Learn")
                    .font(.headline)
                Spacer()
            }

            VStack(spacing: 12) {
                FeatureRow(icon: "lightbulb.fill", text: "Prompt engineering fundamentals", color: .orange)
                FeatureRow(icon: "gearshape.fill", text: "Code generation techniques", color: .blue)
                FeatureRow(icon: "wrench.fill", text: "Debugging with AI assistance", color: .green)
                FeatureRow(icon: "doc.text.fill", text: "Documentation best practices", color: .purple)
                FeatureRow(icon: "checkmark.shield.fill", text: "Production-ready patterns", color: .red)
            }
            .padding()
            .background(Color(UIColor.secondarySystemGroupedBackground))
            .cornerRadius(12)
        }
    }
}

// MARK: - Supporting Views

struct ActionButton: View {
    let icon: String
    let title: String
    let subtitle: String
    let color: Color

    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundColor(color)
                .frame(width: 44, height: 44)
                .background(color.opacity(0.15))
                .cornerRadius(10)

            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.headline)
                    .foregroundColor(.primary)

                Text(subtitle)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }

            Spacer()

            Image(systemName: "chevron.right")
                .foregroundColor(.secondary)
                .font(.caption)
        }
        .padding()
        .background(Color(UIColor.secondarySystemGroupedBackground))
        .cornerRadius(12)
    }
}

struct FeatureRow: View {
    let icon: String
    let text: String
    let color: Color

    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .foregroundColor(color)
                .frame(width: 30)

            Text(text)
                .font(.subheadline)
                .foregroundColor(.primary)

            Spacer()
        }
    }
}

// MARK: - Preview

#Preview {
    HomeView()
}
