# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is **IcePlanet Mobile Application** - a Flutter e-commerce mobile app for Android and iOS. The app uses Riverpod for state management and includes features for authentication, product browsing, and user management.

## Development Commands

This project uses FVM (Flutter Version Manager) to manage Flutter versions:

- **Install dependencies**: `fvm flutter pub get`
- **Run app (debug)**: `fvm flutter run`
- **Run app on specific device**: `fvm flutter run -d <device-id>`
- **Build APK**: `fvm flutter build apk`
- **Build iOS**: `fvm flutter build ios`
- **Run tests**: `fvm flutter test`
- **Analyze code**: `fvm flutter analyze`
- **Format code**: `fvm flutter format .`
- **Clean build**: `fvm flutter clean`

**Note**: This project uses Flutter 3.24.3 managed by FVM. Always prefix flutter commands with `fvm`.

## Architecture & Key Patterns

### State Management
- **Riverpod** is used for state management
- Providers are located in `lib/providers/`
- Main providers: `AuthProvider`, `NavBarProvider`

### Project Structure
```
lib/
├── common/           # Shared UI components (custom_appbar.dart)
├── config/theme/     # Theme configuration (dark/light themes)
├── constants/        # App-wide constants (colors, strings)
├── helpers/          # Utility helpers (toast_helper.dart)
├── models/           # Data models (Product, LoginResponse)
├── providers/        # Riverpod providers for state management
├── screens/          # Main app screens
├── services/         # API services (ProductService)
├── utils/            # Utility functions
└── widgets/          # Reusable UI widgets
```

### Key Services
- **ProductService**: Handles product data fetching from API endpoints
- **AuthProvider**: Manages authentication state using Riverpod StateNotifier

### Environment Configuration
- Uses `.env` file for environment variables
- Key variables include AWS configurations
- Environment is loaded in `main.dart` using flutter_dotenv

### Theme System
- Supports both light and dark themes
- Theme files: `lib/config/theme/light_theme.dart` and `dark_theme.dart`
- Colors defined in `lib/constants/app_colors.dart`

### Navigation
- Currently uses basic MaterialApp routing
- Main entry point can be configured in `main.dart` (currently set to `ShopScreen2`)

## Key Dependencies
- `flutter_riverpod`: State management
- `http`: API calls
- `flutter_dotenv`: Environment variables
- `image_picker`: Image selection
- `aws_s3_upload_lite`: AWS S3 integration
- `google_fonts`: Custom fonts
- `carousel_slider`: Image carousels
- `fluttertoast`: Toast notifications

## Development Notes
- App is locked to portrait orientation only
- Uses Material Design 3
- Includes custom app icons for both Android and iOS
- Banner images are stored in `assets/images/banners/`