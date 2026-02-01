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
      ..mileageUnit = fields[2] as String?;
  }

  @override
  void write(BinaryWriter writer, Vehicle obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.fuelType)
      ..writeByte(2)
      ..write(obj.mileageUnit);
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
