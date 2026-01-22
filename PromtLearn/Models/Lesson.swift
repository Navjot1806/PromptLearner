//
//  Lesson.swift
//  PromptCraftAcademy
//
//  Core lesson data model
//

import Foundation

struct Lesson: Identifiable, Codable, Hashable {
    let id: Int
    let title: String
    let subtitle: String
    let duration: Int // in minutes
    let isPremium: Bool
    let order: Int
    let content: LessonContent
    let codeExamples: [CodeExample]
    let keyTakeaways: [String]

    struct LessonContent: Codable, Hashable {
        let sections: [Section]

        struct Section: Codable, Hashable {
            let heading: String
            let body: String
        }
    }

    struct CodeExample: Codable, Hashable {
        let title: String
        let code: String
        let language: String
        let explanation: String
    }

    var formattedDuration: String {
        "\(duration) min"
    }

    var isLocked: Bool {
        isPremium
    }
}

// MARK: - Sample Data for Preview
extension Lesson {
    static let sampleFree = Lesson(
        id: 1,
        title: "Prompt Basics for Developers",
        subtitle: "Learn the fundamentals of effective AI prompting",
        duration: 15,
        isPremium: false,
        order: 1,
        content: LessonContent(sections: [
            LessonContent.Section(
                heading: "Introduction",
                body: "Learn the core principles of AI prompting for developers."
            )
        ]),
        codeExamples: [
            CodeExample(
                title: "Basic Prompt",
                code: "Write a Python function that calculates fibonacci numbers",
                language: "prompt",
                explanation: "A clear, specific request"
            )
        ],
        keyTakeaways: [
            "Be specific and clear",
            "Provide context",
            "Set constraints"
        ]
    )

    static let samplePremium = Lesson(
        id: 3,
        title: "Advanced Prompt Engineering",
        subtitle: "Master sophisticated prompting techniques",
        duration: 25,
        isPremium: true,
        order: 3,
        content: LessonContent(sections: [
            LessonContent.Section(
                heading: "Few-Shot Learning",
                body: "Provide examples to guide the AI's output."
            )
        ]),
        codeExamples: [],
        keyTakeaways: [
            "Use few-shot examples",
            "Apply chain-of-thought",
            "Leverage role-based prompts"
        ]
    )
}
