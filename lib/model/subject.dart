import 'package:hive/hive.dart';
import 'detail.dart';

part 'subject.g.dart';

@HiveType(typeId: 0)
class Subject{

  @HiveField(0)
  String subjectname;

  @HiveField(1)
  int totalclass;

  @HiveField(2)
  int presentclass;

  @HiveField(3)
  List<Detail> dates = [];

  Subject({
    required this.subjectname,
    required this.totalclass,
    required this.presentclass
});
}