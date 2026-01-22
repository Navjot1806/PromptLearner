//
//  ProgressManager.swift
//  PromptCraftAcademy
//
//  Manages user progress persistence using UserDefaults
//

import Foundation

@MainActor
class ProgressManager: ObservableObject {
    static let shared = ProgressManager()

    @Published private(set) var progress: LessonProgress

    private let progressKey = "userProgress"
    private let defaults = UserDefaults.standard

    init() {
        if let data = defaults.data(forKey: progressKey),
           let decoded = try? JSONDecoder().decode(LessonProgress.self, from: data) {
            self.progress = decoded
        } else {
            self.progress = LessonProgress()
        }
    }

    // MARK: - Save Progress

    private func saveProgress() {
        if let encoded = try? JSONEncoder().encode(progress) {
            defaults.set(encoded, forKey: progressKey)
        }
    }

    // MARK: - Lesson Progress Methods

    func completeLesson(_ lessonId: Int) {
        progress.completeLesson(lessonId)
        saveProgress()

        // Check if all lessons are completed for certificate
        if progress.allLessonsCompleted && !progress.certificateEarned {
            earnCertificate()
        }
    }

    func markLessonAsAccessed(_ lessonId: Int) {
        progress.markLessonAsAccessed(lessonId)
        saveProgress()
    }

    func isLessonCompleted(_ lessonId: Int) -> Bool {
        progress.isLessonCompleted(lessonId)
    }

    // MARK: - Purchase Status

    func unlockFullAccess() {
        progress.unlockFullAccess()
        saveProgress()
    }

    var hasFullAccess: Bool {
        progress.hasPurchasedFullAccess
    }

    // MARK: - Certificate

    func earnCertificate() {
        progress.earnCertificate()
        saveProgress()
    }

    var hasCertificate: Bool {
        progress.certificateEarned
    }

    func getCertificationStatus() -> CertificationStatus {
        if progress.certificateEarned {
            return CertificationStatus(
                isEligible: true,
                earnedDate: progress.lastUpdated,
                studentName: getUserName()
            )
        } else {
            return CertificationStatus(isEligible: false)
        }
    }

    // MARK: - User Info

    private func getUserName() -> String {
        // Get name from authenticated user
        return AuthenticationManager.shared.userName
    }

    func setUserName(_ name: String) {
        AuthenticationManager.shared.updateUserName(name)
    }

    // MARK: - Statistics

    var completionPercentage: Double {
        progress.completionPercentage
    }

    var completedLessonsCount: Int {
        progress.completedLessons.count
    }

    var totalLessonsCount: Int {
        8
    }

    var remainingLessonsCount: Int {
        totalLessonsCount - completedLessonsCount
    }

    var progressSummary: String {
        if completedLessonsCount == 0 {
            return "Start your AI prompting journey!"
        } else if completedLessonsCount == totalLessonsCount {
            return "All lessons completed!"
        } else {
            return "\(completedLessonsCount) of \(totalLessonsCount) lessons completed"
        }
    }

    var canEarnCertificate: Bool {
        progress.allLessonsCompleted
    }

    // MARK: - Reset (for testing)

    func resetProgress() {
        progress = LessonProgress()
        saveProgress()
        defaults.removeObject(forKey: "userName")
    }

    // MARK: - Access Check

    func canAccessLesson(_ lesson: Lesson) -> Bool {
        // Free lessons are always accessible
        if !lesson.isPremium {
            return true
        }
        // Premium lessons require purchase
        return hasFullAccess
    }
}
