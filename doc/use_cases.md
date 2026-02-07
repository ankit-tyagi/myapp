# Use Cases

## Overview

This document outlines the core use cases for the Fuel Log App, focusing on how a typical user would interact with the application to achieve their goals.

## Primary Actors

*   **Vehicle Owner/Driver:** The primary user who wants to track their fuel consumption, costs, and vehicle maintenance.

## Use Case List

### 1. Vehicle Management

*   **Add a Vehicle:**
    *   **Goal:** Register a new vehicle to track.
    *   **Flow:**
        1.  Navigate to "My Garage".
        2.  Tap "Add Vehicle" button.
        3.  Enter vehicle details (Name, Make, Model, Year, Fuel Type, Mileage Unit).
        4.  (Optional) Add a photo.
        5.  Save.
    *   **Result:** A new vehicle card appears in the Garage list.

*   **View Vehicle Details:**
    *   **Goal:** See vehicle information.
    *   **Flow:** Open "My Garage" and view the list of vehicles.
    *   **Result:** Displays vehicle photo, name, make, model, year, and fuel type.

*   **Delete a Vehicle:**
    *   **Goal:** Remove a vehicle from tracking.
    *   **Flow:**
        1.  Navigate to "My Garage".
        2.  Tap the "Delete" icon on a vehicle card.
        3.  Confirm deletion.
    *   **Result:** The vehicle and its associated logs are removed.

### 2. Fuel Log Management

*   **Add a Fuel Entry:**
    *   **Goal:** Log a refueling event.
    *   **Precondition:** At least one vehicle must exist.
    *   **Flow:**
        1.  Tap the main "+" Floating Action Button.
        2.  Select the vehicle.
        3.  Enter Odometer reading (current).
        4.  Enter Fuel Quantity (Liters/Gallons).
        5.  Enter Price per Unit.
        6.  (Auto-calculated) Total Cost is displayed.
        7.  Save.
    *   **Result:** A new fuel entry is saved and visible in "Logs" and affects dashboard stats.

*   **View Fuel Logs:**
    *   **Goal:** Review past refueling history.
    *   **Flow:** Navigate to "Logs" screen.
    *   **Result:** A chronological list of all fuel entries is displayed.

### 3. Analytics & Dashboard

*   **View Dashboard:**
    *   **Goal:** Get an overview of fuel efficiency and spending.
    *   **Flow:** Open the app (defaults to Dashboard) or tap "Dashboard" in the bottom nav.
    *   **Result:** Displays Total Entries, Average Mileage, Total Spending, and a Mileage Trend Chart.

### 4. Settings & Customization

*   **Change Theme:**
    *   **Goal:** Switch between Light and Dark mode.
    *   **Flow:** Navigate to "Settings" -> Toggle "Dark Mode".
    *   **Result:** The app's appearance updates immediately.

*   **Change Units:**
    *   **Goal:** Use preferred measurement units.
    *   **Flow:** Navigate to "Settings" -> Select Fuel Unit (Liters/Gallons), Distance Unit (km/Miles), or Consumption Unit (km/L, MPG, L/100km).
    *   **Result:** All inputs and displays are updated to reflect the new units.

*   **Change Currency:**
    *   **Goal:** Set the currency for cost tracking.
    *   **Flow:** Navigate to "Settings" -> Select "Currency".
    *   **Result:** All cost displays show the selected currency symbol.

*   **Export Data:**
    *   **Goal:** Backup data or analyze it externally.
    *   **Flow:** Navigate to "Settings" -> Tap "Export to CSV".
    *   **Result:** A CSV file containing all vehicle and fuel log data is saved to the device.

*   **Clear Data:**
    *   **Goal:** Reset the app.
    *   **Flow:** Navigate to "Settings" -> Tap "Clear All Data" -> Confirm.
    *   **Result:** All vehicles, logs, and settings are wiped.
