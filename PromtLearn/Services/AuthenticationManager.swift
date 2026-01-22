//
//  AuthenticationManager.swift
//  PromtLearn
//
//  Manages user authentication and session
//

import Foundation
import SwiftUI

@MainActor
class AuthenticationManager: ObservableObject {
    static let shared = AuthenticationManager()

    @Published private(set) var currentUser: User?
    @Published private(set) var isAuthenticated: Bool = false

    private let userKey = "currentUser"
    private let defaults = UserDefaults.standard

    init() {
        loadUser()
    }

    // MARK: - Load User

    private func loadUser() {
        if let data = defaults.data(forKey: userKey),
           let user = try? JSONDecoder().decode(User.self, from: data) {
            self.currentUser = user
            self.isAuthenticated = true
        }
    }

    // MARK: - Save User

    private func saveUser() {
        if let user = currentUser,
           let encoded = try? JSONEncoder().encode(user) {
            defaults.set(encoded, forKey: userKey)
        }
    }

    // MARK: - Sign Up

    func signUp(name: String, email: String) {
        let user = User(name: name, email: email)
        self.currentUser = user
        self.isAuthenticated = true
        saveUser()
    }

    // MARK: - Sign In (Simple - just checks if user exists)

    func signIn(email: String) -> Bool {
        // In a real app, you'd verify credentials here
        // For now, we'll just check if a user with this email exists
        if let data = defaults.data(forKey: userKey),
           let user = try? JSONDecoder().decode(User.self, from: data),
           user.email.lowercased() == email.lowercased() {
            self.currentUser = user
            self.isAuthenticated = true
            return true
        }
        return false
    }

    // MARK: - Sign Out

    func signOut() {
        self.currentUser = nil
        self.isAuthenticated = false
        // Note: We keep the user data for next sign in
    }

    // MARK: - Update User

    func updateUserName(_ name: String) {
        currentUser?.name = name
        saveUser()
    }

    // MARK: - Delete Account

    func deleteAccount() {
        defaults.removeObject(forKey: userKey)
        self.currentUser = nil
        self.isAuthenticated = false
    }

    // MARK: - User Info

    var userName: String {
        currentUser?.name ?? "Guest"
    }

    var userEmail: String {
        currentUser?.email ?? ""
    }
}
