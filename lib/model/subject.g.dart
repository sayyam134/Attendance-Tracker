// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subject.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SubjectAdapter extends TypeAdapter<Subject> {
  @override
  final int typeId = 0;

  @override
  Subject read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Subject(
      subjectname: fields[0] as String,
      totalclass: fields[1] as int,
      presentclass: fields[2] as int,
    )..dates = (fields[3] as List).cast<Detail>();
  }

  @override
  void write(BinaryWriter writer, Subject obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.subjectname)
      ..writeByte(1)
      ..write(obj.totalclass)
      ..writeByte(2)
      ..write(obj.presentclass)
      ..writeByte(3)
      ..write(obj.dates);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SubjectAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
