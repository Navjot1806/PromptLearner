//
//  LessonListView.swift
//  PromptCraftAcademy
//
//  List of all lessons with access control
//

import SwiftUI

struct LessonListView: View {
    @EnvironmentObject var progressManager: ProgressManager
    @EnvironmentObject var storeKitManager: StoreKitManager

    @State private var lessons: [Lesson] = LessonContentProvider.shared.allLessons
    @State private var selectedLesson: Lesson?
    @State private var showPaywall = false

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // Course overview
                courseOverviewSection

                // Free lessons
                if !lessons.filter { !$0.isPremium }.isEmpty {
                    lessonsSection(
                        title: "Free Lessons",
                        lessons: lessons.filter { !$0.isPremium },
                        color: .green
                    )
                }

                // Premium lessons
                if !lessons.filter { $0.isPremium }.isEmpty {
                    lessonsSection(
                        title: "Premium Lessons",
                        lessons: lessons.filter { $0.isPremium },
                        color: .purple
                    )
                }

                // Unlock prompt
                if !storeKitManager.hasUnlockedFullCourse || progressManager.hasFullAccess {
                    unlockPromptSection
                }
            }
            .padding()
        }
        .background(Color(UIColor.systemGroupedBackground))
        .navigationTitle("Course Lessons")
        .navigationBarTitleDisplayMode(.large)
        .navigationDestination(item: $selectedLesson) { lesson in
            LessonDetailView(lesson: lesson)
        }
        .sheet(isPresented: $showPaywall) {
            PaywallView()
        }
    }

    // MARK: - Course Overview

    private var courseOverviewSection: some View {
        VStack(spacing: 12) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("AI Prompting Masterclass")
                        .font(.title3)
                        .fontWeight(.bold)

                    Text("\(lessons.count) lessons • \(lessons.reduce(0) { $0 + $1.duration }) minutes")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }

                Spacer()
            }

            ProgressBar(progress: progressManager.completionPercentage)
        }
        .padding()
        .background(Color(UIColor.secondarySystemGroupedBackground))
        .cornerRadius(12)
    }

    // MARK: - Lessons Section

    private func lessonsSection(title: String, lessons: [Lesson], color: Color) -> some View {
        VStack(spacing: 12) {
            HStack {
                Text(title)
                    .font(.headline)
                    .foregroundColor(color)

                Spacer()

                if title == "Premium Lessons" && !storeKitManager.hasUnlockedFullCourse || progressManager.hasFullAccess {
                    InlineLockBadge()
                }
            }

            VStack(spacing: 12) {
                ForEach(lessons) { lesson in
                    Button {
                        handleLessonTap(lesson)
                    } label: {
                        LessonCard(
                            lesson: lesson,
                            isCompleted: progressManager.isLessonCompleted(lesson.id),
                            isLocked: lesson.isPremium && !storeKitManager.hasUnlockedFullCourse || progressManager.hasFullAccess
                        )
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }
        }
    }

    // MARK: - Unlock Prompt

    private var unlockPromptSection: some View {
        VStack(spacing: 16) {
            VStack(spacing: 8) {
                Image(systemName: "star.fill")
                    .font(.system(size: 40))
                    .foregroundColor(.yellow)

                Text("Unlock Full Course")
                    .font(.title3)
                    .fontWeight(.bold)

                Text("Get access to all 6 premium lessons and earn your certificate")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
            }

            Button {
                showPaywall = true
            } label: {
                Text("Unlock Now for \(storeKitManager.formattedPrice)")
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
        }
        .padding()
        .background(Color(UIColor.secondarySystemGroupedBackground))
        .cornerRadius(12)
    }

    // MARK: - Actions

    private func handleLessonTap(_ lesson: Lesson) {
        if lesson.isPremium && !(storeKitManager.hasUnlockedFullCourse || progressManager.hasFullAccess) {
            showPaywall = true
        } else {
            selectedLesson = lesson
            progressManager.markLessonAsAccessed(lesson.id)
        }
    }
}

// MARK: - Preview

#Preview {
    NavigationStack {
        LessonListView()
    }
}
