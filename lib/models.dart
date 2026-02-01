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
