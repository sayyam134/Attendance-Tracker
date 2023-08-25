import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:a_counter/model/subject.dart';
import 'package:a_counter/pages/home_page.dart';


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
  final mybox = Hive.box("dataBox");
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.white.withOpacity(0.5)),
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0, right: 16.0, left: 16.0, bottom: 8.0),
        child:Container(
          decoration: BoxDecoration(color: Colors.grey.shade900, borderRadius: BorderRadius.circular(18)),
          height: 200,
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
                        Row(
                          children: [
                            Text("Total Classes: ",
                              style: TextStyle(fontSize: 18,color: Colors.white),),
                            Text(widget.TotClass.toString(),
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),),
                          ],
                        ),
                        Row(
                          children: [
                            Text("Present: ",
                              style: TextStyle(fontSize: 18, color: Colors.white),),
                            Text(widget.PresentClass.toString(),
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: Colors.white),),
                          ],
                        ),
                        Row(
                          children: [
                            Text("Absent: ",
                              style: TextStyle(fontSize: 18,color: Colors.white),),
                            Text((widget.TotClass-widget.PresentClass).toString(),
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: Colors.white),),
                          ],
                        ),
                      ],
                    ),

                    Text(percent(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 34,
                      fontWeight: FontWeight.bold
                    ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 5,),
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
    setState(() {
      widget.TotClass++;
      widget.PresentClass++;
      Map<String, dynamic> tempJsonData = jsonDecode(mybox.getAt(widget.index));
      Subject tempSubjectObject = Subject.fromJson(tempJsonData);
      Subject updatedSubjectPresent = Subject(subjectName: tempSubjectObject.subjectName, totDay: tempSubjectObject.totDay+1, pDay: tempSubjectObject.pDay+1);
      String tempData = jsonEncode(updatedSubjectPresent);
      mybox.putAt(widget.index, tempData);
      populateList();
    });

  }

  void absent() {
    setState(() {
      widget.TotClass++;
      Map<String, dynamic> tempJsonData = jsonDecode(mybox.getAt(widget.index));
      Subject tempSubjectObject = Subject.fromJson(tempJsonData);
      Subject updatedSubjectPresent = Subject(subjectName: tempSubjectObject.subjectName, totDay: tempSubjectObject.totDay+1, pDay: tempSubjectObject.pDay);
      String tempData = jsonEncode(updatedSubjectPresent);
      mybox.putAt(widget.index, tempData);
      populateList();
    });
  }

  String percent(){
    String percentage = "0 %";
    if(widget.TotClass!=0){
      percentage = ((widget.PresentClass/widget.TotClass)*100).toStringAsFixed(2)+"%";
    }
    return percentage;
  }

  void populateList() {
    widget.item.clear();
    for(int index=0; index<mybox.length; index++){
      Map<String, dynamic> tempJsonData = jsonDecode(mybox.getAt(index));
      Subject tempSubjectObject = Subject.fromJson(tempJsonData);
      widget.item.add(tempSubjectObject);
    }
  }
}
