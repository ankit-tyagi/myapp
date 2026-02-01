import 'package:hive/hive.dart';

part 'models.g.dart';

@HiveType(typeId: 0)
class Vehicle extends HiveObject {
  @HiveField(0)
  late String name;

  @HiveField(1)
  late String fuelType;

  @HiveField(2)
  late String mileageUnit;
}

@HiveType(typeId: 1)
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
  late double? pricePerUnit;

  @HiveField(5)
  late double? totalCost;

  @HiveField(6)
  late double? calculatedMileage;
}
