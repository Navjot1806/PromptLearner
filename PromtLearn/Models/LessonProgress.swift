//
//  LessonProgress.swift
//  PromptCraftAcademy
//
//  User progress tracking model
//

import Foundation

struct LessonProgress: Codable {
    var completedLessons: Set<Int>
    var lastAccessedLesson: Int?
    var certificateEarned: Bool
    var hasPurchasedFullAccess: Bool
    var lastUpdated: Date

    init() {
        self.completedLessons = []
        self.lastAccessedLesson = nil
        self.certificateEarned = false
        self.hasPurchasedFullAccess = false
        self.lastUpdated = Date()
    }

    mutating func completeLesson(_ lessonId: Int) {
        completedLessons.insert(lessonId)
        lastAccessedLesson = lessonId
        lastUpdated = Date()
    }

    mutating func markLessonAsAccessed(_ lessonId: Int) {
        lastAccessedLesson = lessonId
        lastUpdated = Date()
    }

    mutating func unlockFullAccess() {
        hasPurchasedFullAccess = true
        lastUpdated = Date()
    }

    mutating func earnCertificate() {
        certificateEarned = true
        lastUpdated = Date()
    }

    func isLessonCompleted(_ lessonId: Int) -> Bool {
        completedLessons.contains(lessonId)
    }

    var completionPercentage: Double {
        let totalLessons = 8
        return Double(completedLessons.count) / Double(totalLessons) * 100
    }

    var allLessonsCompleted: Bool {
        completedLessons.count == 8
    }
}
