import 'package:hive/hive.dart';

part 'models.g.dart';

@HiveType(typeId: 1)
class Vehicle extends HiveObject {
  @HiveField(0)
  late String name;

  @HiveField(1)
  String? fuelType;

  @HiveField(2)
  String? mileageUnit;

  @HiveField(3)
  String? make;

  @HiveField(4)
  String? model;

  @HiveField(5)
  int? year;

  @HiveField(6)
  String? licensePlate;

  @HiveField(7)
  String? imagePath;
}

@HiveType(typeId: 2)
class FuelEntry extends HiveObject {
  @HiveField(0)
  late int vehicleId;

  @HiveField(1)
  late DateTime date;

  @HiveField(2)
  late double odometer;

  @HiveField(3)
  late double fuelQuantity;

  @HiveField(4)
  double? pricePerUnit;

  @HiveField(5)
  double? totalCost;
}

@HiveType(typeId: 3)
class Settings extends HiveObject {
  @HiveField(0, defaultValue: 'Liters')
  String fuelUnit = 'Liters';

  @HiveField(1, defaultValue: 'Kilometers')
  String distanceUnit = 'Kilometers';

  @HiveField(2, defaultValue: 'km/L')
  String consumptionUnit = 'km/L';

  @HiveField(3, defaultValue: 'USD')
  String currencyCode = 'USD';
}
