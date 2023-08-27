import 'package:hive/hive.dart';

part 'detail.g.dart';

@HiveType(typeId: 1)
class Detail{

  @HiveField(0)
  String date;

  @HiveField(1)
  String time;

  @HiveField(2)
  bool ispresent;

  Detail({
    required this.date,
    required this.time,
    required this.ispresent,
});
}