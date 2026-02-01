# Fuel Log App Blueprint

## 1. Core Concept

The app is a simple, offline-first fuel logbook. Mileage is derived from the distance traveled between manual fuel entries. The app does not use GPS or any real-time tracking.

## 2. Core Data Model

The app is built around **manual fuel entries**, which include:

*   Date
*   Odometer reading
*   Fuel quantity
*   Fuel price (optional)

From this data, the app will derive:

*   Mileage (km/l or mpg)
*   Cost per km
*   Average mileage
*   Monthly stats
*   Efficiency trends

## 3. App Features

### 3.1. MVP (Must-Have)

*   **Vehicle Management:** Support for a single vehicle initially.
*   **Fuel Log Entry:** A simple form to add new fuel entries.
*   **Mileage Calculation:** Automatic calculation of mileage based on odometer readings and fuel quantity.
*   **Dashboard:** A home screen that displays key stats at a glance, including average mileage, last trip mileage, total distance, and total fuel spent.
*   **Log History:** A chronological list of all fuel entries, with the ability to view, edit, and delete entries.

### 3.2. V1 (Good-to-Have)

*   Monthly summaries
*   Best/worst mileage
*   Cost per km
*   Simple bar graph for monthly mileage
*   Data export to CSV
*   Multiple vehicle support

### 3.3. V2 (Optional/Future)

*   Manual location name entry
*   Local backup/restore
*   Dark mode
*   Home screen widget

## 4. UI and Navigation

The app will use a bottom navigation bar with three tabs:

*   **Dashboard:** The main screen with key stats.
*   **Logs:** A list of all fuel entries.
*   **Settings:** App settings, such as units and currency.

The UI will be minimal, numbers-first, and easy to use, with a floating action button (FAB) for adding new fuel entries.

## 5. Local Storage

The app will use a local database to store all data. [Hive](https://pub.dev/packages/hive) is the recommended solution due to its simplicity and performance for offline apps.

## 6. Development Plan

The app will be built in the following phases:

1.  **Phase 1: Skeleton**
    *   Set up the Flutter project with bottom navigation.
    *   Create empty screens for the dashboard, logs, and settings.
    *   Set up the theme and typography.
2.  **Phase 2: Data Layer**
    *   Set up the local database using Hive.
    *   Create data models for vehicles and fuel entries.
    *   Implement CRUD (Create, Read, Update, Delete) operations for the database.
3.  **Phase 3: Fuel Entry Flow**
    *   Create the "Add Fuel Entry" screen with validation.
    *   Implement the logic to save, edit, and delete fuel entries.
4.  **Phase 4: Dashboard Logic**
    *   Implement the logic to calculate and display dashboard stats.
    *   Handle empty states gracefully.
5.  **Phase 5: UI Polish**
    *   Refine the UI with proper spacing, typography, and a polished look and feel.
    *   Implement light and dark themes.
6.  **Phase 6: Optional Features**
    *   Implement features from the V1 and V2 backlogs, such as monthly stats, graphs, and data export.
