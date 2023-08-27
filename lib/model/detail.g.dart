// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'detail.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DetailAdapter extends TypeAdapter<Detail> {
  @override
  final int typeId = 1;

  @override
  Detail read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Detail(
      date: fields[0] as String,
      time: fields[1] as String,
      ispresent: fields[2] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, Detail obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.date)
      ..writeByte(1)
      ..write(obj.time)
      ..writeByte(2)
      ..write(obj.ispresent);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DetailAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
