//
//  ProgressBar.swift
//  PromptCraftAcademy
//
//  Progress indicator component
//

import SwiftUI

struct ProgressBar: View {
    let progress: Double // 0.0 to 100.0
    let height: CGFloat = 8
    let showPercentage: Bool

    init(progress: Double, showPercentage: Bool = true) {
        self.progress = min(max(progress, 0), 100)
        self.showPercentage = showPercentage
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            if showPercentage {
                HStack {
                    Text("Progress")
                        .font(.subheadline)
                        .foregroundColor(.secondary)

                    Spacer()

                    Text("\(Int(progress))%")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundColor(.primary)
                }
            }

            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    // Background
                    RoundedRectangle(cornerRadius: height / 2)
                        .fill(Color.gray.opacity(0.2))
                        .frame(height: height)

                    // Progress fill
                    RoundedRectangle(cornerRadius: height / 2)
                        .fill(progressGradient)
                        .frame(width: geometry.size.width * (progress / 100), height: height)
                        .animation(.spring(response: 0.5), value: progress)
                }
            }
            .frame(height: height)
        }
    }

    private var progressGradient: LinearGradient {
        LinearGradient(
            colors: [Color.blue, Color.purple],
            startPoint: .leading,
            endPoint: .trailing
        )
    }
}

// MARK: - Circular Progress View

struct CircularProgressView: View {
    let progress: Double // 0.0 to 100.0
    let lineWidth: CGFloat

    init(progress: Double, lineWidth: CGFloat = 12) {
        self.progress = min(max(progress, 0), 100)
        self.lineWidth = lineWidth
    }

    var body: some View {
        ZStack {
            // Background circle
            Circle()
                .stroke(Color.gray.opacity(0.2), lineWidth: lineWidth)

            // Progress circle
            Circle()
                .trim(from: 0, to: progress / 100)
                .stroke(
                    LinearGradient(
                        colors: [Color.blue, Color.purple],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    ),
                    style: StrokeStyle(lineWidth: lineWidth, lineCap: .round)
                )
                .rotationEffect(.degrees(-90))
                .animation(.spring(response: 0.5), value: progress)

            // Percentage text
            VStack(spacing: 2) {
                Text("\(Int(progress))%")
                    .font(.title2)
                    .fontWeight(.bold)

                Text("Complete")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
    }
}

// MARK: - Preview

#Preview("Progress Bar") {
    VStack(spacing: 30) {
        ProgressBar(progress: 0)
        ProgressBar(progress: 25)
        ProgressBar(progress: 50)
        ProgressBar(progress: 75)
        ProgressBar(progress: 100)
    }
    .padding()
}

#Preview("Circular Progress") {
    VStack(spacing: 30) {
        CircularProgressView(progress: 25)
            .frame(width: 120, height: 120)

        CircularProgressView(progress: 62.5)
            .frame(width: 120, height: 120)

        CircularProgressView(progress: 100)
            .frame(width: 120, height: 120)
    }
    .padding()
}
