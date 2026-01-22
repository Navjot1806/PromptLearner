# PromptCraft Academy - iOS App 🎓

An iOS educational app that teaches AI prompting skills for developers. Built with SwiftUI, featuring user authentication, in-app purchases, and progress tracking.

![iOS](https://img.shields.io/badge/iOS-16.0+-blue.svg)
![Swift](https://img.shields.io/badge/Swift-5.9+-orange.svg)
![SwiftUI](https://img.shields.io/badge/SwiftUI-Latest-green.svg)
![License](https://img.shields.io/badge/License-MIT-yellow.svg)

## 📱 Features

### 🔐 User Authentication
- Email-based sign up and sign in
- Persistent user sessions
- Profile management with statistics
- Sign out functionality

### 📚 8 Comprehensive Lessons
**Free Lessons (35 min):**
1. **Prompt Basics for Developers** - Core principles and fundamentals
2. **Code Generation Fundamentals** - Effective generation techniques

**Premium Lessons (145 min):**
3. **Advanced Prompt Engineering** - Few-shot learning & chain-of-thought
4. **Debugging with AI** - Error explanation and debugging strategies
5. **Refactoring & Code Review** - Code improvement and architecture
6. **Documentation & Comments** - Clear documentation generation
7. **Test Generation** - Unit tests and edge case identification
8. **Production-Ready Patterns** - Security and performance optimization

### 💰 In-App Purchase
- One-time purchase ($9.99) to unlock all premium content
- StoreKit 2 integration with async/await
- Restore purchases functionality
- Sandbox testing support

### 📊 Progress Tracking
- Real-time progress synchronization across all views
- Per-lesson completion tracking
- Overall completion percentage
- UserDefaults persistence

### 🏆 Certificate of Completion
- Awarded after completing all 8 lessons
- Displays authenticated user's name
- Achievement statistics
- Shareable certificate

## 🛠 Technical Stack

- **Framework:** SwiftUI (iOS 16+)
- **Architecture:** MVVM pattern
- **Payment:** StoreKit 2 (modern async/await API)
- **Persistence:** UserDefaults
- **Language:** Swift 5.9+
- **Dependencies:** None (fully native)

## 📁 Project Structure

```
PromtLearn/
├── Models/
│   ├── User.swift                    # User authentication model
│   ├── Lesson.swift                  # Lesson data structure
│   ├── LessonProgress.swift          # Progress tracking
│   └── CertificationStatus.swift     # Certificate model
│
├── ViewModels/
│   ├── LessonViewModel.swift         # Lesson management (legacy)
│   ├── PurchaseViewModel.swift       # IAP logic (legacy)
│   └── ProgressViewModel.swift       # Progress tracking (legacy)
│
├── Views/
│   ├── AuthenticationView.swift      # Sign up/sign in screen
│   ├── HomeView.swift                # Main landing view
│   ├── LessonListView.swift          # Lesson catalog
│   ├── LessonDetailView.swift        # Lesson content display
│   ├── PaywallView.swift             # Purchase screen
│   ├── CertificateView.swift         # Certificate display
│   ├── ProfileView.swift             # User profile
│   └── Components/
│       ├── LessonCard.swift          # Reusable lesson card
│       ├── ProgressBar.swift         # Progress indicators
│       └── LockBadge.swift           # Lock indicators
│
├── Services/
│   ├── AuthenticationManager.swift   # User authentication
│   ├── StoreKitManager.swift         # IAP with StoreKit 2
│   └── ProgressManager.swift         # Progress persistence
│
├── Content/
│   └── LessonContent.swift           # All 8 lessons (fully written)
│
└── Configuration.storekit            # IAP testing config
```

## 🚀 Getting Started

### Prerequisites
- macOS 13.0+ (Ventura)
- Xcode 15.0 or later
- iOS 16.0+ deployment target
- Apple Developer account (for testing on device)

### Installation

1. Clone the repository:
```bash
git clone https://github.com/YOUR_USERNAME/PromtLearn.git
cd PromtLearn
```

2. Open the project in Xcode:
```bash
open PromtLearn.xcodeproj
```

3. Select your development team in Xcode:
   - Select the project in the navigator
   - Go to "Signing & Capabilities"
   - Choose your team

4. Enable StoreKit testing:
   - Product → Scheme → Edit Scheme
   - Run → Options
   - StoreKit Configuration: Select "Configuration.storekit"

5. Build and run:
   - Press `⌘+R` or click the Run button
   - Choose a simulator or connected device

## 🧪 Testing

### Test Authentication
1. Launch the app
2. Sign up with a test email and name
3. Complete lessons and track progress
4. Sign out and sign back in to verify session persistence

### Test In-App Purchases
1. In Xcode, ensure StoreKit Configuration is enabled
2. Navigate to a locked lesson
3. Tap "Unlock Full Course"
4. Complete the mock purchase (no real charge in simulator)
5. Verify premium lessons unlock

### Test Progress Sync
1. Complete a lesson in Lesson Detail view
2. Navigate to Home tab - verify progress updated
3. Check Progress tab - verify checkmark appears
4. Go to Profile tab - verify statistics reflect change

## 📱 App Architecture

### State Management
The app uses shared singleton managers injected via `@EnvironmentObject`:

```swift
// App Level
@StateObject private var authManager = AuthenticationManager.shared
@StateObject private var progressManager = ProgressManager.shared
@StateObject private var storeKitManager = StoreKitManager.shared

// Views access shared state
@EnvironmentObject var authManager: AuthenticationManager
@EnvironmentObject var progressManager: ProgressManager
@EnvironmentObject var storeKitManager: StoreKitManager
```

This ensures:
- ✅ Real-time synchronization across all views
- ✅ Single source of truth
- ✅ Automatic UI updates via `@Published` properties

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 👤 Author

**Navjyot Singh Multani**

## 🙏 Acknowledgments

- SwiftUI framework by Apple
- StoreKit 2 for seamless IAP integration
- Claude AI for development assistance

## 📝 Notes

- All 8 lessons contain complete, production-ready educational content
- IAP product ID: `com.promptcraft.fullcourse`
- User data persisted in UserDefaults
- No external dependencies - fully native iOS app

## 🔮 Future Enhancements

- [ ] iCloud sync for cross-device progress
- [ ] Social sharing for certificates
- [ ] Additional lessons and content updates
- [ ] Dark mode optimization
- [ ] iPad optimization
- [ ] Code playground for testing prompts
- [ ] Community features

---

**⭐️ If you find this project useful, please consider giving it a star!**

Built with ❤️ using SwiftUI
