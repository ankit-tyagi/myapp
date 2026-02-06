
# Fuel Log App Blueprint

## Overview

This document outlines the features and implementation details of the Fuel Log app. The app allows users to track their vehicle's fuel consumption and expenses.

## Features Implemented

### Vehicle Management

*   **Add Vehicle:** Users can add new vehicles to their garage.
*   **Vehicle Details:** For each vehicle, users can store the following information:
    *   Name (e.g., "My Sedan")
    *   Make
    *   Model
    *   Year
    *   License Plate
    *   Image
*   **Garage View:** The app displays a list of all vehicles in the user's garage, showing the vehicle's image, name, make, model, and year.
*   **Delete Vehicle:** Users can delete vehicles from their garage.

### Settings

*   **Unit Preferences:** Users can set their preferred units for:
    *   Fuel: Liters or Gallons
    *   Distance: Kilometers or Miles
    *   Fuel Consumption: MPG, L/100km, or km/L
*   **Theme:** Users can switch between light and dark mode.

### Data Persistence

*   All vehicle and settings data is stored locally on the device using the Hive database.

## Next Steps

### Fuel Log Entries

*   **Add Fuel Entry Form:** Create a form to add new fuel entries associated with a specific vehicle. The form will include fields for:
    *   Date
    *   Odometer reading
    *   Fuel quantity
    *   Price per unit
    *   Total cost
*   **Fuel Log List:** Display a list of all fuel entries for a selected vehicle.
*   **Edit/Delete Fuel Entry:** Allow users to edit or delete existing fuel entries.

### Dashboard & Analytics

*   **Fuel Consumption Statistics:** Calculate and display key fuel consumption metrics, such as:
    *   Average fuel consumption
    *   Total fuel consumed
    *   Total distance traveled
    *   Total cost of fuel
*   **Charts and Graphs:** Visualize fuel consumption data using charts and graphs to help users understand their vehicle's performance over time.
