
# Fuel Log App Blueprint

## 1. Overview

This document outlines the features, design, and development plan for the Fuel Log App. The goal is to create a beautiful, intuitive, and robust Flutter application for tracking vehicle fuel consumption and costs.

## 2. Core Features

- **Vehicle Management:** Add, view, and remove vehicles from "My Garage."
- **Fuel Entry Logging:** Record fuel-ups with details like odometer reading, fuel quantity, and cost.
- **Dashboard Analytics:** View key statistics like average fuel economy, total spending, and recent entries.
- **Log History:** Browse, search, and filter all past fuel entries.
- **Data Management:** Export all data to a CSV file and clear all data.
- **Theming:** Switch between light and dark modes.

## 3. Design and UI/UX

- **Aesthetics:** Modern, clean design using Material 3 components. A visually balanced layout with clear typography and iconography.
- **Color Scheme:** Based on a `deepPurple` seed color for a vibrant and consistent look.
- **Typography:** Using the `google_fonts` package for readable and stylish text (`Oswald` for headlines, `Roboto` for titles, `Open Sans` for body).
- **Interactivity:** Smooth navigation, clear feedback on actions, and intuitive forms.
- **Responsiveness:** The app is designed to work flawlessly on both mobile and web.

---

## 4. Current Development Plan

This section details the immediate tasks to fix existing issues and implement new, user-requested features.

### Step 1: Bug Fixes & Stabilization

- **[In Progress]** **Fix Analyzer Warnings:** Systematically eliminate all remaining issues reported by `flutter analyze`.
  - Fix `use_build_context_synchronously` warnings in `settings_screen.dart` to prevent potential crashes.
  - Address `deprecated_member_use` warnings in form elements.
- **[In Progress]** **Ensure Responsiveness:** Verify and improve UI layouts to ensure a consistent and accurate experience on both web and mobile, addressing the user's concern about the faulty Android emulator.

### Step 2: Implement "Edit Fuel Entry" Feature

- **[Pending]** Create a new `edit_fuel_entry_screen.dart`.
- **[Pending]** Add an "Edit" icon button to each item in the `logs_screen.dart`.
- **[Pending]** Implement the logic to update an existing `FuelEntry` in the Hive database.

### Step 3: Enhance Vehicle Details

- **[Pending]** **Update Data Model:** Modify the `Vehicle` class in `models.dart` to include:
  - `make` (String)
  - `model` (String)
  - `year` (int)
  - `licensePlate` (String)
  - `imagePath` (String, nullable)
- **[Pending]** **Update UI:**
  - Add new fields to the "Add Vehicle" form in `garage_screen.dart`.
  - Display the new, richer details in the vehicle list.
- **[Pending]** **Add Image Picker:**
  - Integrate the `image_picker` package.
  - Add a button to the "Add/Edit Vehicle" form to allow users to select a photo.
  - Display the selected image in the garage and on the dashboard. Add a default placeholder image.

### Step 4: Final Polish and Review

- **[Pending]** Conduct a full review of the application to ensure all new features are integrated smoothly and the UI is polished.
- **[Pending]** Run `flutter analyze` one final time to guarantee a clean, error-free codebase.


=============version2==============

This is a comprehensive, expanded blueprint based on the analysis of the top fuel log apps (Fuelio, Drivvo, etc.) but strictly adhered to your **Offline-First, Privacy-Centric, and Minimalist** philosophy.

I have reverse-engineered the core value propositions of those apps and stripped away the bloat (social, cloud sync, maps) to focus on the pure utility you requested.

---

# Project Blueprint: Minimalist Fuel & Mileage Tracker

## 1. Executive Summary

**Philosophy:** "Input Speed & Data Privacy."
The app is a standalone, offline-first utility to track vehicle fuel efficiency and costs. Unlike competitors, it rejects feature bloat (GPS, Maps, Accounts) in favor of instant startup time, zero data collection, and a high-contrast, legible UI.

**Core Value:**

1. **Speed:** Log a fill-up in under 10 seconds.
2. **Clarity:** See cost-per-mile/km and fuel efficiency instantly.
3. **Privacy:** Data never leaves the device.

---

## 2. Detailed Feature Requirements

### A. Garage (Vehicle Management)

* **Multi-Vehicle Support:** Users can add multiple vehicles (Car, Motorcycle, Truck).
* **Active Vehicle Switch:** A simple dropdown or swipe mechanism on the home screen to switch the context of the data.
* **Vehicle Attributes:**
* Name (e.g., "Red Ford")
* Make/Model/Year (Text fields)
* **Initial Odometer:** (Crucial for establishing the baseline).
* **Fuel Unit Preference:** (Liters vs. Gallons).
* **Distance Unit Preference:** (Km vs. Miles).
* **Consumption Unit:** (MPG, L/100km, km/L).
* *Optional:* Photo (Local storage only).



### B. The Fuel Log (The Core Loop)

To calculate mileage accurately, the app needs specific logic.

* **Data Points Required:**
1. **Date/Time:** Defaults to `DateTime.now()`.
2. **Odometer Reading:** The total current mileage. (Auto-fill this based on the previous entry + a predicted average, or just leave blank).
3. **Fuel Volume:** Amount filled.
4. **Price per Unit:** (Or Total Cost - app should calculate the missing variable).
5. **"Missed Previous Entry" Toggle:** If a user forgets a log, the next calculation will be wrong. This checkbox resets the calculation chain.
6. **"Partial Tank" Toggle:** If the tank wasn't filled to the top, mileage cannot be calculated for this specific entry.



### C. Dashboard Analytics (The "Read" Mode)

* **Primary Card (The "Hero" Stat):** Average Fuel Efficiency (e.g., 15 km/L).
* **Secondary Stats:**
* Last Log Consumption.
* Cost per Mile/Km (The "Real" cost of driving).
* Total Distance Tracked.
* Total Money Spent (All time vs. This Month).



### D. Settings & Tools

* **Data Export:** Generate a `.csv` file (Standard format compatible with Excel/Google Sheets) to local phone storage.
* **Backup/Restore:** Export the Hive database file as a backup.
* **Theme:** System Default / Light / Dark (High contrast for sunlight visibility).

---

## 3. UI/UX Architecture & Flow

**Design Language:** Material 3. Large touch targets (for use in a car). Zero clutter.

### Screen 1: The Dashboard (Home)

* **Top Bar:**
* **Left:** "My Garage" dropdown (Current Vehicle Name).
* **Right:** Settings Icon (Gear).


* **Body:**
* **Top Section:** A clean Graph (Line chart) showing Fuel Efficiency trends over the last 10 entries.
* **Middle Section:** 3-Column Stats Grid (Last Efficiency, Last Cost, Total Cost).
* **Bottom Section:** "Recent Activity" list (Last 3 entries).


* **Floating Action Button (FAB):**
* **Location:** Bottom Right (or Center Docked).
* **Icon:** `Icons.local_gas_station`.
* **Action:** Opens the **Add Entry Modal**.



### Screen 2: Add Entry (The "Write" Mode)

* **Type:** Full-screen modal or bottom sheet (needs to focus the user).
* **Layout:**
* **Odometer Field:** Large text input. *UX Feature: Show the "Previous Odometer" reading below it nicely so the user knows they entered a higher number.*
* **Row 1:** Price per Liter | Total Cost (Auto-calculate one if the other is changed).
* **Row 2:** Liters/Gallons filled.
* **Toggles:** [ ] Full Tank (Default Checked) | [ ] Missed Previous.


* **Button:** "Save Log" (Large, spans full width).

### Screen 3: Log History (List View)

* **Layout:** A scrolling list.
* **Card Item:**
* **Left:** Date (e.g., "12 Oct").
* **Center:** Odometer & Distance traveled since last fill.
* **Right:** Calculated Efficiency (green if better than average, red if worse).


* **Interaction:** Tap to Edit, Long-press to Delete.

### Screen 4: Garage/Settings

* List of vehicles with an "Add Vehicle" button.
* Preferences (Units, Currency Symbol).

---

## 4. Development Roadmap

### Phase 1: Foundation (The Skeleton)

1. **Project Setup:** Flutter create.
2. **Database Layer (Hive):**
* Define `Vehicle` Model (Name, Units, ImagePath).
* Define `FuelEntry` Model (Date, Odometer, Volume, Price, IsFullTank).
* Create Repository class to handle CRUD operations.


3. **State Management:** Provider or Riverpod (Provider is sufficient for this complexity). Setup a `VehicleProvider` to handle the "Current Active Vehicle."

### Phase 2: The Core Loop (CRUD)

1. **Vehicle Screen:** Build the form to add a car. Ensure the user *must* have one car to proceed.
2. **Add Entry Screen:**
* Build the form with validation (New Odometer > Old Odometer).
* Implement the math: `Distance = CurrentOdometer - PreviousOdometer`. `Efficiency = Distance / Volume`.


3. **Log List:** Display the raw data in a `ListView.builder`.

### Phase 3: The Dashboard (Analytics)

1. **Math Logic:** Write a helper class `Calculator`.
* *Logic:* Iterate through logs. If `entry.isFullTank` is true, calculate efficiency based on distance from the previous entry.


2. **UI Construction:** Build the Stat Cards and the Graph (use `fl_chart` package).

### Phase 4: Polish & Refinement (The User's Request)

1. **Image Picker:** Implement `image_picker` for the vehicle photo.
2. **Edit Capability:** Add the "Edit" icon to the Log List items. Reuse the "Add Entry" screen but populate it with existing data.
3. **CSV Export:** Implement `csv` and `path_provider` packages to write the data to a file.

---

## 5. Technical Requirements (Flutter)

**Packages Needed:**

* `hive`, `hive_flutter`: For local NoSQL database (fast, offline).
* `provider` or `flutter_riverpod`: State management.
* `intl`: Date and number formatting.
* `fl_chart`: For the dashboard graph.
* `image_picker`: For vehicle photos.
* `path_provider` & `share_plus` / `file_picker`: For exporting CSVs.
* `google_fonts`: For typography (Oswald/Roboto).

**Data Structure (Hive Model Example):**

```dart
@HiveType(typeId: 0)
class FuelEntry extends HiveObject {
  @HiveField(0)
  final DateTime date;
  @HiveField(1)
  final double odometer;
  @HiveField(2)
  final double volume; // Liters or Gallons
  @HiveField(3)
  final double pricePerUnit;
  @HiveField(4)
  final double totalCost;
  @HiveField(5)
  final bool isFullTank;
  @HiveField(6)
  final String? notes; // Optional
}

```

## 6. Next Immediate Steps (Actionable)

*Based on your current status ("Pending" items in your draft).*

1. **Complete the Data Model Update:** Go to `models.dart` and add `make`, `model`, `year` to the Hive object. You need to run `flutter pub run build_runner build` after changing Hive models.
2. **Build the `edit_fuel_entry_screen.dart`:** This is the highest priority usability feature.
3. **Refine the Calculation Logic:** Ensure that when you display "MPG" or "L/100km", it ignores entries marked as "Partial Tank" for the efficiency calc, but keeps them for the "Total Cost" calc.