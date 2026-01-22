//
//  LessonDetailView.swift
//  PromptCraftAcademy
//
//  Individual lesson content display
//

import SwiftUI

struct LessonDetailView: View {
    let lesson: Lesson

    @EnvironmentObject var progressManager: ProgressManager
    @Environment(\.dismiss) private var dismiss

    @State private var showCompletionAlert = false
    @State private var hasMarkedComplete = false

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                // Lesson header
                lessonHeaderSection

                // Lesson content sections
                ForEach(lesson.content.sections.indices, id: \.self) { index in
                    contentSection(lesson.content.sections[index])
                }

                // Code examples
                if !lesson.codeExamples.isEmpty {
                    codeExamplesSection
                }

                // Key takeaways
                keyTakeawaysSection

                // Complete button
                if !isCompleted {
                    completeButton
                }

                Spacer(minLength: 40)
            }
            .padding()
        }
        .background(Color(UIColor.systemGroupedBackground))
        .navigationTitle(lesson.title)
        .navigationBarTitleDisplayMode(.inline)
        .alert("Lesson Complete!", isPresented: $showCompletionAlert) {
            Button("Continue") {
                dismiss()
            }
        } message: {
            if progressManager.canEarnCertificate && !progressManager.hasCertificate {
                Text("Congratulations! You've completed all lessons and earned your certificate!")
            } else {
                Text("Great job! Keep going to complete the course.")
            }
        }
    }

    // MARK: - Lesson Header

    private var lessonHeaderSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text("Lesson \(lesson.order)")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 4)
                    .background(
                        LinearGradient(
                            colors: [.blue, .purple],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .cornerRadius(8)

                Spacer()

                if !lesson.isPremium {
                    Text("FREE")
                        .font(.caption)
                        .fontWeight(.bold)
                        .foregroundColor(.green)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(Color.green.opacity(0.15))
                        .cornerRadius(6)
                }

                if isCompleted {
                    Label("Completed", systemImage: "checkmark.circle.fill")
                        .font(.caption)
                        .foregroundColor(.green)
                }
            }

            Text(lesson.subtitle)
                .font(.title3)
                .foregroundColor(.secondary)

            HStack {
                Label(lesson.formattedDuration, systemImage: "clock")
                    .font(.subheadline)
                    .foregroundColor(.secondary)

                Spacer()
            }
        }
        .padding()
        .background(Color(UIColor.secondarySystemGroupedBackground))
        .cornerRadius(12)
    }

    // MARK: - Content Section

    private func contentSection(_ section: Lesson.LessonContent.Section) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(section.heading)
                .font(.title2)
                .fontWeight(.bold)

            Text(section.body)
                .font(.body)
                .foregroundColor(.primary)
                .fixedSize(horizontal: false, vertical: true)
        }
        .padding()
        .background(Color(UIColor.secondarySystemGroupedBackground))
        .cornerRadius(12)
    }

    // MARK: - Code Examples

    private var codeExamplesSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Code Examples")
                .font(.title2)
                .fontWeight(.bold)

            ForEach(lesson.codeExamples.indices, id: \.self) { index in
                codeExampleCard(lesson.codeExamples[index])
            }
        }
    }

    private func codeExampleCard(_ example: Lesson.CodeExample) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text(example.title)
                    .font(.headline)

                Spacer()

                Text(example.language.uppercased())
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(6)
            }

            ScrollView(.horizontal, showsIndicators: false) {
                Text(example.code)
                    .font(.system(.body, design: .monospaced))
                    .padding()
                    .background(Color.black.opacity(0.05))
                    .cornerRadius(8)
            }

            Text(example.explanation)
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
        .padding()
        .background(Color(UIColor.secondarySystemGroupedBackground))
        .cornerRadius(12)
    }

    // MARK: - Key Takeaways

    private var keyTakeawaysSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Key Takeaways")
                .font(.title2)
                .fontWeight(.bold)

            VStack(alignment: .leading, spacing: 8) {
                ForEach(lesson.keyTakeaways.indices, id: \.self) { index in
                    HStack(alignment: .top, spacing: 12) {
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundColor(.green)
                            .font(.body)

                        Text(lesson.keyTakeaways[index])
                            .font(.body)
                            .foregroundColor(.primary)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                }
            }
        }
        .padding()
        .background(Color(UIColor.secondarySystemGroupedBackground))
        .cornerRadius(12)
    }

    // MARK: - Complete Button

    private var completeButton: some View {
        Button {
            markAsComplete()
        } label: {
            HStack {
                Image(systemName: "checkmark.circle.fill")
                Text("Mark as Complete")
            }
            .font(.headline)
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .padding()
            .background(
                LinearGradient(
                    colors: [.green, .green.opacity(0.7)],
                    startPoint: .leading,
                    endPoint: .trailing
                )
            )
            .cornerRadius(12)
        }
    }

    // MARK: - Helpers

    private var isCompleted: Bool {
        progressManager.isLessonCompleted(lesson.id)
    }

    private func markAsComplete() {
        guard !hasMarkedComplete else { return }
        hasMarkedComplete = true

        progressManager.completeLesson(lesson.id)
        showCompletionAlert = true
    }
}

// MARK: - Preview

#Preview {
    NavigationStack {
        LessonDetailView(lesson: Lesson.sampleFree)
    }
}
