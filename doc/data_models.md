# Data Models

## Overview

The application uses three primary data models to manage the core domain logic: `Vehicle`, `FuelEntry`, and `Settings`. These models are persisted locally using Hive.

## 1. Vehicle

Represents a user's vehicle.

| Field | Type | Description |
| :--- | :--- | :--- |
| `name` | `String` | User-defined nickname for the vehicle (e.g., "My Civic"). |
| `make` | `String?` | Manufacturer of the vehicle (e.g., "Honda"). |
| `model` | `String?` | Model name (e.g., "Civic"). |
| `year` | `int?` | Manufacturing year. |
| `licensePlate` | `String?` | License plate number. |
| `fuelType` | `String?` | Type of fuel used (e.g., "Gasoline", "Diesel", "Electric"). |
| `mileageUnit` | `String?` | Unit used for odometer (e.g., "Kilometers", "Miles"). |
| `imagePath` | `String?` | Local file path to the vehicle's image. |

**Hive Type ID:** `1`
**Box Name:** `vehicles`

## 2. FuelEntry

Represents a single refueling event.

| Field | Type | Description |
| :--- | :--- | :--- |
| `vehicleId` | `int` | Foreign key linking to the `Vehicle`'s Hive key. |
| `date` | `DateTime` | The date and time of refueling. |
| `odometer` | `double` | Odometer reading at the time of refueling. |
| `fuelQuantity` | `double` | Amount of fuel added. |
| `pricePerUnit` | `double?` | Cost per unit of fuel (e.g., $/Liter). |
| `totalCost` | `double?` | Total cost of the transaction. |

**Hive Type ID:** `2`
**Box Name:** `fuel_entries`

## 3. Settings

Stores application-wide user preferences.

| Field | Type | Default | Description |
| :--- | :--- | :--- | :--- |
| `fuelUnit` | `String` | 'Liters' | Preferred unit for fuel volume (Liters/Gallons). |
| `distanceUnit` | `String` | 'Kilometers' | Preferred unit for distance (Kilometers/Miles). |
| `consumptionUnit` | `String` | 'km/L' | Preferred unit for fuel efficiency (km/L, MPG, L/100km). |
| `currencyCode` | `String` | 'USD' | ISO 4217 Currency Code for costs (e.g., USD, EUR). |

**Hive Type ID:** `3`
**Box Name:** `settings`
**Key:** `user_settings` (Stored as a single object in the box)

## Persistence Layer

*   **Database:** [Hive](https://pub.dev/packages/hive) (NoSQL, Key-Value).
*   **Adapters:** `TypeAdapter`s are generated automatically using `build_runner` and `hive_generator` to serialize Dart objects to binary for storage.
*   **Code Generation:** Run `dart run build_runner build` to regenerate `models.g.dart` if schema changes.
