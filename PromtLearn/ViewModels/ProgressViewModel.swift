//
//  ProgressViewModel.swift
//  PromptCraftAcademy
//
//  Manages user progress tracking and certificate status
//

import Foundation
import SwiftUI

@MainActor
class ProgressViewModel: ObservableObject {
    @Published var userName: String = ""
    @Published var showCertificate = false

    private let progressManager = ProgressManager.shared

    init() {
        loadUserName()
    }

    // MARK: - User Name

    func loadUserName() {
        userName = UserDefaults.standard.string(forKey: "userName") ?? ""
    }

    func saveUserName() {
        progressManager.setUserName(userName)
    }

    // MARK: - Progress Stats

    var completionPercentage: Double {
        progressManager.completionPercentage
    }

    var completedLessonsCount: Int {
        progressManager.completedLessonsCount
    }

    var totalLessonsCount: Int {
        8
    }

    var remainingLessonsCount: Int {
        totalLessonsCount - completedLessonsCount
    }

    // MARK: - Certificate

    var canEarnCertificate: Bool {
        progressManager.progress.allLessonsCompleted
    }

    var hasCertificate: Bool {
        progressManager.hasCertificate
    }

    func getCertificationStatus() -> CertificationStatus {
        progressManager.getCertificationStatus()
    }

    func requestCertificate() {
        if canEarnCertificate {
            progressManager.earnCertificate()
            showCertificate = true
        }
    }

    // MARK: - Lesson Progress

    func isLessonCompleted(_ lessonId: Int) -> Bool {
        progressManager.isLessonCompleted(lessonId)
    }

    func completeLesson(_ lessonId: Int) {
        progressManager.completeLesson(lessonId)

        // Check if certificate should be shown
        if canEarnCertificate && !hasCertificate {
            requestCertificate()
        }
    }

    // MARK: - Access Control

    var hasFullAccess: Bool {
        progressManager.hasFullAccess
    }

    // MARK: - Reset (for testing)

    func resetAllProgress() {
        progressManager.resetProgress()
        userName = ""
        showCertificate = false
    }

    // MARK: - Progress Summary

    var progressSummary: String {
        if completedLessonsCount == 0 {
            return "Start your AI prompting journey!"
        } else if completedLessonsCount == totalLessonsCount {
            return "All lessons completed!"
        } else {
            return "\(completedLessonsCount) of \(totalLessonsCount) lessons completed"
        }
    }

    var formattedCompletionPercentage: String {
        String(format: "%.0f%%", completionPercentage)
    }
}
