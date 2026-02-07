# Application Architecture

## Overview

The Fuel Log App is built using Flutter, adhering to a clean and pragmatic architecture suitable for offline-first mobile applications. It leverages the following key technologies and patterns:

*   **Flutter:** Cross-platform UI framework.
*   **Hive:** A lightweight and fast key-value database written in pure Dart for local persistence.
*   **Provider:** For simple dependency injection and theme state management.
*   **Material Design 3:** For a modern and accessible user interface.

## Architecture Pattern

The application follows a **Model-View-ViewModel (MVVM)** inspired structure, but simplified given the reactive nature of Flutter and Hive:

*   **Model:** Defines the data structures (Vehicle, FuelEntry, Settings) and handles data persistence using Hive.
*   **View (UI):** The visual representation of the app (Screens). It observes changes in the Model directly via `ValueListenableBuilder` or through `Provider`.
*   **ViewModel (Implicit):** Logic for data manipulation and state updates is often handled within the Widget itself (for simple cases) or encapsulated in `ChangeNotifier` classes (like `ThemeProvider`).

## Key Components

### 1. Data Layer (`lib/models.dart`)

*   **Models:**
    *   `Vehicle`: Represents a user's vehicle (name, make, model, year, fuel type, mileage unit).
    *   `FuelEntry`: Represents a single fuel log entry (date, odometer, fuel quantity, price, total cost).
    *   `Settings`: Stores user preferences (units, currency, theme).
*   **Persistence:**
    *   Hive is used to store these models in "boxes" (`vehicles`, `fuel_entries`, `settings`).
    *   `HiveObject` mixin allows objects to save/delete themselves directly.
    *   `TypeAdapter`s are generated using `build_runner` to serialize/deserialize custom objects.

### 2. UI Layer (`lib/screens/`)

*   **DashboardScreen:** Displays key metrics and charts. Listens to changes in `fuel_entries` box.
*   **GarageScreen:** Manages vehicles. Listens to changes in `vehicles` box.
*   **LogsScreen:** Shows a history of fuel entries. Listens to changes in `fuel_entries` box.
*   **SettingsScreen:** Allows customization. Listens to changes in `settings` box and uses `ThemeProvider`.
*   **AddFuelEntryScreen:** Form for adding new entries. Validates input and saves to Hive.

### 3. State Management (`lib/main.dart` & `Provider`)

*   **ThemeProvider:** A `ChangeNotifier` that manages the app's theme mode (Light/Dark/System).
*   **ValueListenableBuilder:** Used extensively to rebuild UI parts automatically when data in Hive boxes changes. This provides a reactive data flow without complex boilerplate.

## Data Flow

1.  **User Interaction:** User performs an action (e.g., adds a fuel entry).
2.  **Logic Execution:** The UI widget validates input and calls Hive methods (e.g., `box.add(entry)`).
3.  **Persistence Update:** Hive updates the local storage.
4.  **UI Update:** `ValueListenableBuilder` detects the change in the Hive box and rebuilds the relevant widgets with the new data.

## Scalability & Future Improvements

*   **Repository Pattern:** For larger apps, abstracting direct Hive access behind a Repository interface would improve testability and allow swapping data sources (e.g., to a remote API).
*   **BLoC / Riverpod:** For more complex state management needs, migrating to BLoC or Riverpod could provide better separation of concerns.
