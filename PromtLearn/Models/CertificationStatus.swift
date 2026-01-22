//
//  CertificationStatus.swift
//  PromptCraftAcademy
//
//  Certificate eligibility and display model
//

import Foundation

struct CertificationStatus: Codable {
    let isEligible: Bool
    let earnedDate: Date?
    let studentName: String?

    init(isEligible: Bool, earnedDate: Date? = nil, studentName: String? = nil) {
        self.isEligible = isEligible
        self.earnedDate = earnedDate
        self.studentName = studentName
    }

    var formattedDate: String {
        guard let date = earnedDate else { return "N/A" }
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter.string(from: date)
    }

    var certificateText: String {
        """
        Certificate of Completion

        AI Prompting Masterclass for Coders

        This certifies that \(studentName ?? "Student") has successfully
        completed all 8 lessons of the PromptCraft Academy course,
        demonstrating proficiency in AI-assisted code development.

        Completed: \(formattedDate)
        """
    }
}

// MARK: - Sample Data
extension CertificationStatus {
    static let sample = CertificationStatus(
        isEligible: true,
        earnedDate: Date(),
        studentName: "Developer"
    )

    static let notEligible = CertificationStatus(
        isEligible: false
    )
}
