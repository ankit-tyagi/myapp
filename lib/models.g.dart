// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class VehicleAdapter extends TypeAdapter<Vehicle> {
  @override
  final int typeId = 1;

  @override
  Vehicle read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Vehicle()
      ..name = fields[0] as String
      ..fuelType = fields[1] as String?
      ..mileageUnit = fields[2] as String?
      ..make = fields[3] as String?
      ..model = fields[4] as String?
      ..year = fields[5] as int?
      ..licensePlate = fields[6] as String?
      ..imagePath = fields[7] as String?;
  }

  @override
  void write(BinaryWriter writer, Vehicle obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.fuelType)
      ..writeByte(2)
      ..write(obj.mileageUnit)
      ..writeByte(3)
      ..write(obj.make)
      ..writeByte(4)
      ..write(obj.model)
      ..writeByte(5)
      ..write(obj.year)
      ..writeByte(6)
      ..write(obj.licensePlate)
      ..writeByte(7)
      ..write(obj.imagePath);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VehicleAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class FuelEntryAdapter extends TypeAdapter<FuelEntry> {
  @override
  final int typeId = 2;

  @override
  FuelEntry read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FuelEntry()
      ..vehicleId = fields[0] as int
      ..date = fields[1] as DateTime
      ..odometer = fields[2] as double
      ..fuelQuantity = fields[3] as double
      ..pricePerUnit = fields[4] as double?
      ..totalCost = fields[5] as double?;
  }

  @override
  void write(BinaryWriter writer, FuelEntry obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.vehicleId)
      ..writeByte(1)
      ..write(obj.date)
      ..writeByte(2)
      ..write(obj.odometer)
      ..writeByte(3)
      ..write(obj.fuelQuantity)
      ..writeByte(4)
      ..write(obj.pricePerUnit)
      ..writeByte(5)
      ..write(obj.totalCost);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FuelEntryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class SettingsAdapter extends TypeAdapter<Settings> {
  @override
  final int typeId = 3;

  @override
  Settings read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Settings()
      ..fuelUnit = fields[0] as String
      ..distanceUnit = fields[1] as String
      ..consumptionUnit = fields[2] as String;
  }

  @override
  void write(BinaryWriter writer, Settings obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.fuelUnit)
      ..writeByte(1)
      ..write(obj.distanceUnit)
      ..writeByte(2)
      ..write(obj.consumptionUnit);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SettingsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
