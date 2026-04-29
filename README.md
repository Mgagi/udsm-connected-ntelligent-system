# udsm-connected-intelligent-system
An integrated university platform designed to unify fragmented UDSM systems (LMS, FYP, PTMS, ARIS) into a single seamless application.

## Mobile UI prototype

This repository now includes a Flutter Material 3 staff mobile interface for the UCIS platform, matching the staff direction from the PowerPoint prototype. The project is configured for Android and iOS only; the web target has been removed.

Implemented areas:

- Role-choice login with Staff selected for the current build
- Staff sign-in screen
- Staff dashboard with LMS teaching, FYP review, student management, grading, and staff tasks
- Staff announcements, services, calendar, AI assistant, and campus map screens
- UDSM-inspired mobile styling with blue headers, rounded panels, and bottom navigation

Run on mobile targets with:

```sh
flutter pub get
flutter run -d android
flutter run -d ios
```
