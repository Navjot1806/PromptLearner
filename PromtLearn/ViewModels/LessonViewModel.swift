//
//  LessonViewModel.swift
//  PromptCraftAcademy
//
//  Manages lesson list and detail view logic
//

import Foundation
import SwiftUI

@MainActor
class LessonViewModel: ObservableObject {
    @Published var lessons: [Lesson] = []
    @Published var selectedLesson: Lesson?

    private let contentProvider = LessonContentProvider.shared
    private let progressManager = ProgressManager.shared

    init() {
        loadLessons()
    }

    func loadLessons() {
        lessons = contentProvider.allLessons
    }

    func selectLesson(_ lesson: Lesson) {
        selectedLesson = lesson
        progressManager.markLessonAsAccessed(lesson.id)
    }

    func completeLesson(_ lesson: Lesson) {
        progressManager.completeLesson(lesson.id)
    }

    func isLessonCompleted(_ lessonId: Int) -> Bool {
        progressManager.isLessonCompleted(lessonId)
    }

    func canAccessLesson(_ lesson: Lesson) -> Bool {
        progressManager.canAccessLesson(lesson)
    }

    var freeLessons: [Lesson] {
        lessons.filter { !$0.isPremium }
    }

    var premiumLessons: [Lesson] {
        lessons.filter { $0.isPremium }
    }

    var totalDuration: Int {
        lessons.reduce(0) { $0 + $1.duration }
    }

    var completedLessonsCount: Int {
        progressManager.completedLessonsCount
    }

    var totalLessonsCount: Int {
        lessons.count
    }
}
