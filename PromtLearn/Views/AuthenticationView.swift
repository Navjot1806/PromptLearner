//
//  AuthenticationView.swift
//  PromtLearn
//
//  User authentication screen
//

import SwiftUI

struct AuthenticationView: View {
    @EnvironmentObject var authManager: AuthenticationManager
    @State private var name = ""
    @State private var email = ""
    @State private var isSignUp = true
    @State private var showError = false
    @State private var errorMessage = ""

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 30) {
                    // Header
                    headerSection

                    // Form
                    formSection

                    // Action Button
                    actionButton

                    // Toggle Sign In/Sign Up
                    toggleButton
                }
                .padding()
            }
            .background(Color(UIColor.systemGroupedBackground))
            .navigationTitle(isSignUp ? "Create Account" : "Welcome Back")
            .navigationBarTitleDisplayMode(.large)
            .alert("Error", isPresented: $showError) {
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

                Image(systemName: "brain.head.profile")
                    .font(.system(size: 50))
                    .foregroundColor(.white)
            }

            Text("PromptCraft Academy")
                .font(.title)
                .fontWeight(.bold)

            Text(isSignUp ? "Create your account to start learning" : "Sign in to continue your journey")
                .font(.subheadline)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
        }
    }

    // MARK: - Form

    private var formSection: some View {
        VStack(spacing: 16) {
            if isSignUp {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Full Name")
                        .font(.subheadline)
                        .foregroundColor(.secondary)

                    TextField("Enter your name", text: $name)
                        .textFieldStyle(RoundedTextFieldStyle())
                        .textContentType(.name)
                        .textInputAutocapitalization(.words)
                }
            }

            VStack(alignment: .leading, spacing: 8) {
                Text("Email")
                    .font(.subheadline)
                    .foregroundColor(.secondary)

                TextField("Enter your email", text: $email)
                    .textFieldStyle(RoundedTextFieldStyle())
                    .textContentType(.emailAddress)
                    .textInputAutocapitalization(.never)
                    .keyboardType(.emailAddress)
            }
        }
        .padding()
        .background(Color(UIColor.secondarySystemGroupedBackground))
        .cornerRadius(12)
    }

    // MARK: - Action Button

    private var actionButton: some View {
        Button {
            handleAction()
        } label: {
            Text(isSignUp ? "Create Account" : "Sign In")
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
        .disabled(!isFormValid)
        .opacity(isFormValid ? 1.0 : 0.6)
    }

    // MARK: - Toggle Button

    private var toggleButton: some View {
        Button {
            withAnimation {
                isSignUp.toggle()
                errorMessage = ""
            }
        } label: {
            HStack(spacing: 4) {
                Text(isSignUp ? "Already have an account?" : "Don't have an account?")
                    .foregroundColor(.secondary)
                Text(isSignUp ? "Sign In" : "Sign Up")
                    .foregroundColor(.blue)
                    .fontWeight(.semibold)
            }
            .font(.subheadline)
        }
    }

    // MARK: - Validation

    private var isFormValid: Bool {
        if isSignUp {
            return !name.isEmpty && !email.isEmpty && email.contains("@")
        } else {
            return !email.isEmpty && email.contains("@")
        }
    }

    // MARK: - Actions

    private func handleAction() {
        if isSignUp {
            // Sign up
            authManager.signUp(name: name, email: email)
        } else {
            // Sign in
            if authManager.signIn(email: email) {
                // Success - authentication state will update automatically
            } else {
                errorMessage = "No account found with this email. Please sign up first."
                showError = true
            }
        }
    }
}

// MARK: - Custom TextField Style

struct RoundedTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding()
            .background(Color(UIColor.tertiarySystemGroupedBackground))
            .cornerRadius(10)
    }
}

// MARK: - Preview

#Preview {
    AuthenticationView()
        .environmentObject(AuthenticationManager.shared)
}
