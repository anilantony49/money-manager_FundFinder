// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_models.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class transactionModelsAdapter extends TypeAdapter<transactionModels> {
  @override
  final int typeId = 3;

  @override
  transactionModels read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return transactionModels(
      id: fields[0] as String,
      amount: fields[1] as double,
      purpose: fields[2] as String,
      isDeleted: fields[3] as bool,
      date: fields[4] as DateTime,
      type: fields[5] as CategoryType,
      model: fields[6] as CategoryModels,
    );
  }

  @override
  void write(BinaryWriter writer, transactionModels obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.amount)
      ..writeByte(2)
      ..write(obj.purpose)
      ..writeByte(3)
      ..write(obj.isDeleted)
      ..writeByte(4)
      ..write(obj.date)
      ..writeByte(5)
      ..write(obj.type)
      ..writeByte(6)
      ..write(obj.model);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is transactionModelsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
