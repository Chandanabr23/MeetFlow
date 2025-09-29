# MeetFlow

A Flutter application that demonstrates:

- Authentication & login with mock REST API (ReqRes).
- One-to-one video calling (using WebRTC/Agora/Amazon Chime SDK).
- User list fetched via REST API with offline caching.
- Splash screen, app icons, and store readiness setup.

---

## 📱 Features

1. **Authentication & Login Screen**
   - Email + password fields with validation.
   - Mock authentication using [ReqRes API](https://reqres.in).

2. **Video Call Screen**
   - One-to-one video call with camera & microphone.
   - Local + remote video streams.
   - Mute/unmute audio, enable/disable video.
   - Screen sharing support.
   - Uses RTC SDK  WebRTC.

3. **User List Screen**
   - Fetches users from ReqRes API (mock api : https://randomuser.me/api/?results=10).
   - Displays avatars and names.
   - Offline caching using Hive.

4. **App Lifecycle & Store-Readiness**
   - Splash screen.
   - Custom app icon.
   - Android/iOS signing config.
   - Required permissions (Camera, Microphone, Internet).
   - App versioning.

---

## 🛠️ Tech Stack

- **Flutter** (latest stable SDK)
- **State Management**: BLoC / Cubit
- **Networking**: `http`
- **Offline Storage**: `hive`
- **Video SDK**: `flutter_webrtc`
- **Form Validation**: `flutter_form_builder`
- **Permissions**: `permission_handler`

---

## 🚀 Getting Started

### Prerequisites
- [Flutter SDK](https://docs.flutter.dev/get-started/install) (latest stable)
- Android Studio / VS Code
- Android Emulator or iOS Simulator
- A physical device (recommended for camera/mic testing)

Verify Flutter installation:

```bash
flutter doctor
