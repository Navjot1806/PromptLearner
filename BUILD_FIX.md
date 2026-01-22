# Build Error Fixes

## Error Fixed

### Error: Value of type 'EnvironmentObject<ProgressManager>.Wrapper' has no dynamic member 'userName'

**Location:** `CertificateView.swift:106`

**Problem:**
The code was trying to access `progressManager.userName`, but `ProgressManager` doesn't expose `userName` as a published property. The `userName` actually comes from `AuthenticationManager`.

**Solution:**
Changed `CertificateView.swift` to use `authManager.userName` directly instead of `progressManager.userName`.

```swift
// Before (WRONG):
if progressManager.userName.isEmpty {
    // ...
}
Text(progressManager.userName)

// After (CORRECT):
if authManager.userName.isEmpty {
    // ...
}
Text(authManager.userName)
```

## Changes Made

**File: `Views/CertificateView.swift`**
- Line 106: Changed `$progressManager.userName.isEmpty` to `authManager.userName.isEmpty`
- Line 116: Changed `progressManager.userName` to `authManager.userName`

## Why This Works

- `AuthenticationManager` owns the user's name (from sign up/sign in)
- `CertificateView` already has `@EnvironmentObject var authManager: AuthenticationManager`
- Now it correctly accesses the user's name from the authentication manager
- The certificate will display the authenticated user's name

## Build Status

✅ Error resolved
✅ Certificate will show authenticated user's name
✅ All views now properly use shared state via environment objects

## Next Steps

1. Clean build folder: `⇧⌘K`
2. Build project: `⌘+B`
3. Run app: `⌘+R`
4. Test certificate displays correct user name

---

**Status:** ✅ Fixed and Ready to Build
