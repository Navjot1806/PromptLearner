//
//  LockBadge.swift
//  PromptCraftAcademy
//
//  Locked content indicator component
//

import SwiftUI

struct LockBadge: View {
    let size: CGFloat

    init(size: CGFloat = 60) {
        self.size = size
    }

    var body: some View {
        ZStack {
            Circle()
                .fill(Color.gray.opacity(0.2))
                .frame(width: size, height: size)

            Image(systemName: "lock.fill")
                .font(.system(size: size * 0.4))
                .foregroundColor(.secondary)
        }
    }
}

// MARK: - Overlay Lock Badge

struct OverlayLockBadge: View {
    var body: some View {
        ZStack {
            Color.black.opacity(0.6)
                .cornerRadius(12)

            VStack(spacing: 12) {
                Image(systemName: "lock.fill")
                    .font(.system(size: 40))
                    .foregroundColor(.white)

                Text("Premium Content")
                    .font(.headline)
                    .foregroundColor(.white)

                Text("Unlock full course to access")
                    .font(.subheadline)
                    .foregroundColor(.white.opacity(0.9))
                    .multilineTextAlignment(.center)
            }
            .padding()
        }
    }
}

// MARK: - Inline Lock Badge

struct InlineLockBadge: View {
    var body: some View {
        HStack(spacing: 6) {
            Image(systemName: "lock.fill")
                .font(.caption)

            Text("Premium")
                .font(.caption)
                .fontWeight(.semibold)
        }
        .foregroundColor(.white)
        .padding(.horizontal, 10)
        .padding(.vertical, 4)
        .background(
            LinearGradient(
                colors: [Color.orange, Color.red],
                startPoint: .leading,
                endPoint: .trailing
            )
        )
        .cornerRadius(12)
    }
}

// MARK: - Preview

#Preview("Lock Badge") {
    VStack(spacing: 30) {
        LockBadge()
        LockBadge(size: 80)
        LockBadge(size: 40)
    }
    .padding()
}

#Preview("Overlay Lock") {
    ZStack {
        Color.blue
            .frame(width: 300, height: 200)
            .cornerRadius(12)

        OverlayLockBadge()
            .frame(width: 300, height: 200)
    }
    .padding()
}

#Preview("Inline Lock") {
    VStack(spacing: 20) {
        InlineLockBadge()

        HStack {
            Text("Advanced Techniques")
                .font(.headline)
            InlineLockBadge()
        }
    }
    .padding()
}
