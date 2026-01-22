//
//  PromptCraftAcademyApp.swift
//  PromptCraftAcademy
//
//  App entry point
//

import SwiftUI

@main
struct PromtLearnApp: App {
    // Initialize managers on app launch
    @StateObject private var authManager = AuthenticationManager.shared
    @StateObject private var storeKitManager = StoreKitManager.shared
    @StateObject private var progressManager = ProgressManager.shared

    var body: some Scene {
        WindowGroup {
            if authManager.isAuthenticated {
                ContentView()
                    .environmentObject(authManager)
                    .environmentObject(storeKitManager)
                    .environmentObject(progressManager)
            } else {
                AuthenticationView()
                    .environmentObject(authManager)
            }
        }
    }
}

// MARK: - Content View (Tab Navigation)

struct ContentView: View {
    @State private var selectedTab = 0

    var body: some View {
        TabView(selection: $selectedTab) {
            // Home Tab
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
                .tag(0)

            // Lessons Tab
            NavigationStack {
                LessonListView()
            }
            .tabItem {
                Label("Lessons", systemImage: "book.fill")
            }
            .tag(1)

            // Progress Tab
            NavigationStack {
                ProgressView()
            }
            .tabItem {
                Label("Progress", systemImage: "chart.bar.fill")
            }
            .tag(2)

            // Profile Tab
            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person.fill")
                }
                .tag(3)
        }
    }
}

// MARK: - Progress Tab View

struct ProgressView: View {
    @EnvironmentObject var progressManager: ProgressManager
    @EnvironmentObject var storeKitManager: StoreKitManager

    var body: some View{
        ScrollView {
            VStack(spacing: 24) {
                // Progress overview
                progressOverviewSection

                // Lessons completed
                lessonsCompletedSection

                // Certificate section
                if progressManager.hasCertificate {
                    certificateSection
                } else if progressManager.canEarnCertificate {
                    earnCertificateSection
                }

                // Unlock section
                if !storeKitManager.hasUnlockedFullCourse || progressManager.hasFullAccess {
                    unlockSection
                }
            }
            .padding()
        }
        .background(Color(UIColor.systemGroupedBackground))
        .navigationTitle("Your Progress")
        .navigationBarTitleDisplayMode(.large)
    }

    // MARK: - Progress Overview

    private var progressOverviewSection: some View {
        VStack(spacing: 20) {
            CircularProgressView(progress: progressManager.completionPercentage)
                .frame(width: 150, height: 150)

            VStack(spacing: 8) {
                Text(progressManager.progressSummary)
                    .font(.headline)

                if progressManager.completedLessonsCount > 0 {
                    Text("Keep going! You're doing great.")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
            }
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color(UIColor.secondarySystemGroupedBackground))
        .cornerRadius(12)
    }

    // MARK: - Lessons Completed

    private var lessonsCompletedSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Completed Lessons")
                .font(.headline)

            if progressManager.completedLessonsCount == 0 {
                Text("No lessons completed yet. Start your first lesson!")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .padding()
            } else {
                VStack(alignment: .leading, spacing: 8) {
                    ForEach(1...8, id: \.self) { lessonId in
                        lessonProgressRow(lessonId: lessonId)
                    }
                }
            }
        }
        .padding()
        .background(Color(UIColor.secondarySystemGroupedBackground))
        .cornerRadius(12)
    }

    private func lessonProgressRow(lessonId: Int) -> some View {
        HStack {
            Image(systemName: progressManager.isLessonCompleted(lessonId) ? "checkmark.circle.fill" : "circle")
                .foregroundColor(progressManager.isLessonCompleted(lessonId) ? .green : .secondary)

            Text("Lesson \(lessonId)")
                .font(.subheadline)

            Spacer()
        }
    }

    // MARK: - Certificate Section

    private var certificateSection: some View {
        NavigationLink(destination: CertificateView()) {
            HStack {
                Image(systemName: "seal.fill")
                    .font(.title)
                    .foregroundColor(.yellow)

                VStack(alignment: .leading, spacing: 4) {
                    Text("View Certificate")
                        .font(.headline)
                        .foregroundColor(.primary)

                    Text("Congratulations on completing the course!")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }

                Spacer()

                Image(systemName: "chevron.right")
                    .foregroundColor(.secondary)
            }
            .padding()
            .background(Color(UIColor.secondarySystemGroupedBackground))
            .cornerRadius(12)
        }
    }

    private var earnCertificateSection: some View {
        VStack(spacing: 12) {
            Image(systemName: "seal.fill")
                .font(.system(size: 50))
                .foregroundColor(.yellow)

            Text("Certificate Available!")
                .font(.headline)

            Text("You've completed all lessons. View your certificate now!")
                .font(.subheadline)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)

            NavigationLink(destination: CertificateView()) {
                Text("View Certificate")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(
                        LinearGradient(
                            colors: [.yellow, .orange],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .cornerRadius(12)
            }
        }
        .padding()
        .background(Color(UIColor.secondarySystemGroupedBackground))
        .cornerRadius(12)
    }

    // MARK: - Unlock Section

    private var unlockSection: some View {
        NavigationLink(destination: PaywallView()) {
            VStack(spacing: 12) {
                Image(systemName: "lock.open.fill")
                    .font(.title)
                    .foregroundColor(.purple)

                Text("Unlock Full Course")
                    .font(.headline)

                Text("Get access to all premium lessons")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color(UIColor.secondarySystemGroupedBackground))
            .cornerRadius(12)
        }
    }
}

// MARK: - Preview

#Preview {
    ContentView()
}
