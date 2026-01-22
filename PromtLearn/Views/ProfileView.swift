//
//  ProfileView.swift
//  PromtLearn
//
//  User profile and settings
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var authManager: AuthenticationManager
    @EnvironmentObject var progressManager: ProgressManager
    @EnvironmentObject var storeKitManager: StoreKitManager

    @State private var showSignOutConfirmation = false

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 24) {
                    // User Info Section
                    userInfoSection

                    // Progress Stats
                    statsSection

                    // Account Settings
                    accountSettingsSection

                    // Sign Out Button
                    signOutButton
                }
                .padding()
            }
            .background(Color(UIColor.systemGroupedBackground))
            .navigationTitle("Profile")
            .navigationBarTitleDisplayMode(.large)
            .alert("Sign Out", isPresented: $showSignOutConfirmation) {
                Button("Cancel", role: .cancel) { }
                Button("Sign Out", role: .destructive) {
                    authManager.signOut()
                }
            } message: {
                Text("Are you sure you want to sign out? Your progress is saved and will be restored when you sign back in.")
            }
        }
    }

    // MARK: - User Info Section

    private var userInfoSection: some View {
        VStack(spacing: 16) {
            // Avatar
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

                Text(authManager.userName.prefix(1).uppercased())
                    .font(.system(size: 40, weight: .bold))
                    .foregroundColor(.white)
            }

            VStack(spacing: 4) {
                Text(authManager.userName)
                    .font(.title2)
                    .fontWeight(.bold)

                Text(authManager.userEmail)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color(UIColor.secondarySystemGroupedBackground))
        .cornerRadius(12)
    }

    // MARK: - Stats Section

    private var statsSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Your Statistics")
                .font(.headline)

            HStack(spacing: 16) {
                StatCard(
                    icon: "book.fill",
                    value: "\(progressManager.completedLessonsCount)",
                    label: "Lessons"
                )

                StatCard(
                    icon: "chart.bar.fill",
                    value: "\(Int(progressManager.completionPercentage))%",
                    label: "Progress"
                )

                if progressManager.hasCertificate {
                    StatCard(
                        icon: "seal.fill",
                        value: "Earned",
                        label: "Certificate"
                    )
                }
            }
        }
        .padding()
        .background(Color(UIColor.secondarySystemGroupedBackground))
        .cornerRadius(12)
    }

    // MARK: - Account Settings

    private var accountSettingsSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Account")
                .font(.headline)

            VStack(spacing: 0) {
                SettingsRow(
                    icon: "person.fill",
                    title: "Account Type",
                    value: storeKitManager.hasUnlockedFullCourse || progressManager.hasFullAccess ? "Premium" : "Free"
                )

                Divider()
                    .padding(.leading, 44)

                SettingsRow(
                    icon: "calendar",
                    title: "Member Since",
                    value: formattedMemberDate
                )

                if storeKitManager.hasUnlockedFullCourse || progressManager.hasFullAccess {
                    Divider()
                        .padding(.leading, 44)

                    SettingsRow(
                        icon: "checkmark.seal.fill",
                        title: "Full Course Access",
                        value: "Unlocked"
                    )
                }
            }
        }
        .padding()
        .background(Color(UIColor.secondarySystemGroupedBackground))
        .cornerRadius(12)
    }

    // MARK: - Sign Out Button

    private var signOutButton: some View {
        Button {
            showSignOutConfirmation = true
        } label: {
            Text("Sign Out")
                .font(.headline)
                .foregroundColor(.red)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color(UIColor.secondarySystemGroupedBackground))
                .cornerRadius(12)
        }
    }

    // MARK: - Helpers

    private var formattedMemberDate: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        // Using current date as placeholder - in real app, use actual user creation date
        return formatter.string(from: Date())
    }
}

// MARK: - Supporting Views

struct StatCard: View {
    let icon: String
    let value: String
    let label: String

    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundColor(.blue)

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
}

struct SettingsRow: View {
    let icon: String
    let title: String
    let value: String

    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .font(.body)
                .foregroundColor(.blue)
                .frame(width: 28)

            Text(title)
                .font(.body)

            Spacer()

            Text(value)
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
        .padding(.vertical, 12)
    }
}

// MARK: - Preview

#Preview {
    ProfileView()
        .environmentObject(AuthenticationManager.shared)
        .environmentObject(ProgressManager.shared)
        .environmentObject(StoreKitManager.shared)
}
