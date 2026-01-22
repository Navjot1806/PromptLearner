//
//  User.swift
//  PromtLearn
//
//  User authentication model
//

import Foundation

struct User: Codable, Identifiable {
    let id: UUID
    var name: String
    var email: String
    let createdAt: Date

    init(name: String, email: String) {
        self.id = UUID()
        self.name = name
        self.email = email
        self.createdAt = Date()
    }
}
