import 'dart:convert';
import 'package:a_counter/model/detail.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../model/subject.dart';

class DetailPage extends StatelessWidget {
  final int index;
  Box _subjectbox = Hive.box("_subjectbox");
  DetailPage({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 10,),
            Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: (){
                        Navigator.pop(context);
                      },
                        child: Padding(
                          padding: const EdgeInsets.only(left: 15.0),
                          child: Icon(Icons.arrow_back_ios_new, size: 30),
                        )),
                    Text(data().subjectname,
                        style: TextStyle(
                            fontSize: 28, fontWeight: FontWeight.bold)),
                    SizedBox(width: 39,)
                  ],
                ),
                SizedBox(height: 10,),
              ],
            ),
            const SizedBox(height: 12),
            Expanded(
              child: ListView(
                padding: EdgeInsets.all(5),
                children: [
                  DataTable(
                    columnSpacing: 50,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), border: Border.all(width: 3)),
                  dividerThickness: 5,
                    columns: [
                  DataColumn(label: Text("ID", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),)),
                  DataColumn(label: Text("Date", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),)),
                  DataColumn(label: Text("Time", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),)),
                  DataColumn(label: Text("Status", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),)),
                ],
                    rows:_data()
                  ),
              ]),
            )
          ],
        )
      ),
    );
  }

  Subject data(){
    return _subjectbox.getAt(index);
  }

  List<DataRow> _data(){
    List<DataRow> temp = [];
    List<Detail> d = data().dates;
    for(int i=0; i<d.length; i++){
      String status = "";
      if(d[i].ispresent){
        status = "Present";
      }
      else{
        status = "Absent";
      }

      temp.add(DataRow(cells: [
        DataCell(Text((i+1).toString())),
        DataCell(Text(d[i].date)),
        DataCell(Text(d[i].time)),
        DataCell(Text(status, style: TextStyle(color: status=="Present" ? Colors.green.shade800 : Colors.red.shade900, fontWeight: FontWeight.bold),)),
      ]));
    }
    return temp;

  }
}// don't remove this
