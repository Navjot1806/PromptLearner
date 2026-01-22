//
//  LessonCard.swift
//  PromptCraftAcademy
//
//  Reusable lesson card component
//

import SwiftUI

struct LessonCard: View {
    let lesson: Lesson
    let isCompleted: Bool
    let isLocked: Bool

    var body: some View {
        HStack(spacing: 16) {
            // Lesson number badge
            ZStack {
                Circle()
                    .fill(badgeGradient)
                    .frame(width: 50, height: 50)

                if isCompleted {
                    Image(systemName: "checkmark")
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                } else {
                    Text("\(lesson.order)")
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                }
            }

            // Lesson details
            VStack(alignment: .leading, spacing: 4) {
                HStack {
                    Text(lesson.title)
                        .font(.headline)
                        .foregroundColor(.primary)

                    if isLocked {
                        Image(systemName: "lock.fill")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }

                    if !lesson.isPremium {
                        Text("FREE")
                            .font(.caption2)
                            .fontWeight(.bold)
                            .padding(.horizontal, 6)
                            .padding(.vertical, 2)
                            .background(Color.green.opacity(0.2))
                            .foregroundColor(.green)
                            .cornerRadius(4)
                    }
                }

                Text(lesson.subtitle)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .lineLimit(2)

                Text(lesson.formattedDuration)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }

            Spacer()

            // Chevron
            Image(systemName: "chevron.right")
                .foregroundColor(.secondary)
                .font(.caption)
        }
        .padding()
        .background(cardBackground)
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
    }

    private var badgeGradient: LinearGradient {
        if isCompleted {
            return LinearGradient(
                colors: [Color.green, Color.green.opacity(0.7)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        } else if isLocked {
            return LinearGradient(
                colors: [Color.gray.opacity(0.6), Color.gray.opacity(0.4)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        } else {
            return LinearGradient(
                colors: [Color.blue, Color.purple],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        }
    }

    private var cardBackground: Color {
        Color(UIColor.secondarySystemGroupedBackground)
    }
}

// MARK: - Preview

#Preview {
    VStack(spacing: 16) {
        LessonCard(
            lesson: Lesson.sampleFree,
            isCompleted: false,
            isLocked: false
        )

        LessonCard(
            lesson: Lesson.sampleFree,
            isCompleted: true,
            isLocked: false
        )

        LessonCard(
            lesson: Lesson.samplePremium,
            isCompleted: false,
            isLocked: true
        )
    }
    .padding()
}
