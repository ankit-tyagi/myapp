# Fuel Log App

A Flutter application for tracking fuel consumption, mileage, and vehicle maintenance expenses.

## Features

*   **Dashboard:** View key statistics like total spending, average mileage, and fuel consumption trends with visual charts.
*   **Garage:** Manage multiple vehicles with details like make, model, year, and photos.
*   **Fuel Logs:** Record fuel entries including odometer reading, fuel quantity, price, and date.
*   **Settings:** Customize units (Liters/Gallons, km/Miles, km/L / MPG / L/100km), currency, and app theme (Light/Dark mode).
*   **Offline First:** All data is stored locally on the device using Hive.
*   **Data Export:** Export your fuel logs to CSV for external analysis.

## Getting Started

### Prerequisites

*   Flutter SDK: [Install Flutter](https://flutter.dev/docs/get-started/install)
*   Dart SDK: Included with Flutter
*   Android Studio / Xcode: For emulator and device setup

### Installation

1.  **Clone the repository:**
    ```bash
    git clone <repository-url>
    cd <project-directory>
    ```

2.  **Install dependencies:**
    ```bash
    flutter pub get
    ```

3.  **Run code generation (for Hive & Models):**
    This step is crucial as the app uses `hive_generator` for data persistence.
    ```bash
    dart run build_runner build --delete-conflicting-outputs
    ```

### Running the App

*   **Run on an emulator or connected device:**
    ```bash
    flutter run
    ```
    To specify a device:
    ```bash
    flutter run -d <device-id>
    ```

*   **Run on Web:**
    ```bash
    flutter run -d chrome
    ```

## Architecture

This app follows a simple, maintainable architecture suitable for its scale.

*   **State Management:** `Provider` is used for theming and simple state sharing. `ValueListenableBuilder` from `hive_flutter` is heavily used to reactively update the UI when the local database changes.
*   **Persistence:** `Hive` (NoSQL database) is used for storing Vehicles, Fuel Entries, and Settings locally.
*   **UI:** Built with Material Design 3 widgets. `fl_chart` is used for data visualization.

## Folder Structure

*   `lib/`
    *   `models.dart`: Data models (Vehicle, FuelEntry, Settings) and Hive adapters.
    *   `screens/`: UI screens (Dashboard, Garage, Logs, Settings, Add Entry).
    *   `main.dart`: App entry point and theme configuration.
    *   `constants.dart`: specific constants like currencies.

## Troubleshooting

*   **Android Emulator Issues:** If the emulator fails to start or the app crashes on launch, try:
    1.  Wiping data from the emulator in Android Studio AVD Manager.
    2.  Running `flutter clean` and then `flutter run`.
    3.  Ensuring your computer has virtualization enabled (VT-x / AMD-V).
*   **Hive Errors:** If you see errors related to `TypeAdapter` or `Hive`, make sure you have run the build_runner command mentioned in the Installation section.
