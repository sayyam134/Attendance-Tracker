import 'package:a_counter/services/noti.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:a_counter/model/subject.dart';
import 'package:percent_indicator/percent_indicator.dart';
import '../model/detail.dart';


class MyItem extends StatefulWidget {
  int index;
  String SubName;
  int TotClass;
  int PresentClass;
  List<Subject> item;

   MyItem({super.key,
     required this.index,
     required this.SubName,
     required this.TotClass,
     required this.PresentClass,
     required this.item,
  });

  @override
  State<MyItem> createState() => _MyItemState();
}

class _MyItemState extends State<MyItem> {
  Box _subjectbox = Hive.box("_subjectbox");
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.white.withOpacity(0.5)),
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0, right: 16.0, left: 16.0, bottom: 8.0),
        child:Container(
          decoration: BoxDecoration(color: Colors.grey.shade900, borderRadius: BorderRadius.circular(18)),
          height: 252,
          padding: EdgeInsets.only(top: 5.0, bottom: 16.0, right: 18.0, left: 18.0),
          child:
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(height: 5,),
              Text(widget.SubName,
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white)),
              SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.only(left: 12, right: 12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 15,),
                        Row(
                          children: [
                            Text("Total Classes: ",
                              style: TextStyle(fontSize: 20,color: Colors.white),),
                            Text(widget.TotClass.toString(),
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),),
                          ],
                        ),
                        SizedBox(height: 8,),
                        Row(
                          children: [
                            Text("Present: ",
                              style: TextStyle(fontSize: 20, color: Colors.white),),
                            Text(widget.PresentClass.toString(),
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Colors.white),),
                          ],
                        ),
                        SizedBox(height: 8,),
                        Row(
                          children: [
                            Text("Absent: ",
                              style: TextStyle(fontSize: 20,color: Colors.white),),
                            Text((widget.TotClass-widget.PresentClass).toString(),
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Colors.white),),
                          ],
                        ),
                      ],
                    ),
                    CircularPercentIndicator(
                        radius: 60,
                      lineWidth: 11,
                      circularStrokeCap: CircularStrokeCap.round,
                      percent: percent(),
                      progressColor: percent() >= 0.75 ? Colors.green.shade500 : percent()< 0.75 && percent()>= 0.6 ? Colors.yellow.shade500 : Colors.red.shade500,
                      backgroundColor: percent() >= 0.75 ? Colors.green.shade100 : percent()< 0.75 && percent()>= 0.6 ? Colors.yellow.shade50 : Colors.red.shade100,
                      center: Text((percent()*100).toStringAsFixed(1)+"%",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(onPressed: (){
                  present();
                }, child: Text("Present", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19),), style: ElevatedButton.styleFrom(backgroundColor: Colors.green.shade500, minimumSize: Size(100, 50)),),
                  ElevatedButton(onPressed: (){
                    absent();
                  }, child: Text("Absent", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19),), style: ElevatedButton.styleFrom(backgroundColor: Colors.red.shade500, minimumSize: Size(100, 50)),),
              ],)
            ],
          ),
        ),
      ),
    );
  }

  void present() {
    DateTime datetime = DateTime.now();
    DateTime tomorrow = datetime.add(Duration(days: 1));
    if(datetime.weekday==5){
      tomorrow = datetime.add(Duration(days: 3));
    }
    if(datetime.weekday==6){
      tomorrow = datetime.add(Duration(days: 2));
    }
    String _date = DateFormat('yyyy-MM-dd').format(datetime);
    String _time = DateFormat('kk:mm').format(datetime);
    setState(() {
      widget.TotClass++;
      widget.PresentClass++;
      Subject temp = _subjectbox.getAt(widget.index);
      temp.totalclass++;
      temp.presentclass++;
      Detail tempDetail= Detail(date: _date, time: _time, ispresent: true);
      temp.dates.add(tempDetail);
      _subjectbox.putAt(widget.index, temp);
      populateList();
      NotificationService().schdeuleNotification(id: widget.index ,body: "Update Attendance of ${widget.SubName}",scheduleDateTime: tomorrow);
    });

  }

  void absent() {
    DateTime datetime = DateTime.now();
    DateTime tomorrow = datetime.add(Duration(days: 1));
    if(datetime.weekday==5){
      tomorrow = datetime.add(Duration(days: 3));
    }
    if(datetime.weekday==6){
      tomorrow = datetime.add(Duration(days: 2));
    }
    String _date = DateFormat('yyyy-MM-dd').format(datetime);
    String _time = DateFormat('kk:mm').format(datetime);
    setState(() {
      widget.TotClass++;
      Subject temp = _subjectbox.getAt(widget.index);
      temp.totalclass++;
      Detail tempDetail= Detail(date: _date, time: _time, ispresent: false);
      temp.dates.add(tempDetail);
      _subjectbox.putAt(widget.index, temp);
      populateList();
      NotificationService().schdeuleNotification(id: widget.index ,body: "Update Attendance of ${widget.SubName}",scheduleDateTime: tomorrow);
    });
  }

  double percent(){
    double percentage = 0;
    if(widget.TotClass!=0){
      percentage = ((widget.PresentClass/widget.TotClass));
    }
    return percentage;
  }

  void populateList() {
    widget.item.clear();
    for (int index = 0; index < _subjectbox.length; index++) {
      widget.item.add(_subjectbox.getAt(index));
    }
  }
}
