import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../model/subject.dart';

class DetailPage extends StatelessWidget {
  final int index;
  final mybox = Hive.box("dataBox");
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
                    Text(data().subjectName,
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
                padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                children: [
                  DataTable(
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), border: Border.all(width: 2)),
                  dividerThickness: 5,
                    columns: [
                  DataColumn(label: Text("ID", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),)),
                  DataColumn(label: Text("Date", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),)),
                  DataColumn(label: Text("Time", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),)),
                  DataColumn(label: Text("Status", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),)),
                ],
                    rows:[
                      DataRow(cells: [
                        DataCell(Text("1")),
                        DataCell(Text("01-02-2005")),
                        DataCell(Text("10:30")),
                        DataCell(Text("Present")),
                      ]),
                      DataRow(cells: [
                        DataCell(Text("1")),
                        DataCell(Text("01-02-2005")),
                        DataCell(Text("10:30")),
                        DataCell(Text("Present")),
                      ]),
                      DataRow(cells: [
                        DataCell(Text("1")),
                        DataCell(Text("01-02-2005")),
                        DataCell(Text("10:30")),
                        DataCell(Text("Present")),
                      ]),
                      DataRow(cells: [
                        DataCell(Text("1")),
                        DataCell(Text("01-02-2005")),
                        DataCell(Text("10:30")),
                        DataCell(Text("Present")),
                      ]),
                      DataRow(cells: [
                        DataCell(Text("1")),
                        DataCell(Text("01-02-2005")),
                        DataCell(Text("10:30")),
                        DataCell(Text("Present")),
                      ]),
                      DataRow(cells: [
                        DataCell(Text("1")),
                        DataCell(Text("01-02-2005")),
                        DataCell(Text("10:30")),
                        DataCell(Text("Present")),
                      ]),
                      DataRow(cells: [
                        DataCell(Text("1")),
                        DataCell(Text("01-02-2005")),
                        DataCell(Text("10:30")),
                        DataCell(Text("Present")),
                      ]),
                      DataRow(cells: [
                        DataCell(Text("1")),
                        DataCell(Text("01-02-2005")),
                        DataCell(Text("10:30")),
                        DataCell(Text("Present")),
                      ]),
                      DataRow(cells: [
                        DataCell(Text("1")),
                        DataCell(Text("01-02-2005")),
                        DataCell(Text("10:30")),
                        DataCell(Text("Present")),
                      ]),
                      DataRow(cells: [
                        DataCell(Text("1")),
                        DataCell(Text("01-02-2005")),
                        DataCell(Text("10:30")),
                        DataCell(Text("Present")),
                      ]),
                      DataRow(cells: [
                        DataCell(Text("1")),
                        DataCell(Text("01-02-2005")),
                        DataCell(Text("10:30")),
                        DataCell(Text("Present")),
                      ]),
                      DataRow(cells: [
                        DataCell(Text("1")),
                        DataCell(Text("01-02-2005")),
                        DataCell(Text("10:30")),
                        DataCell(Text("Present")),
                      ]),
                      DataRow(cells: [
                        DataCell(Text("1")),
                        DataCell(Text("01-02-2005")),
                        DataCell(Text("10:30")),
                        DataCell(Text("Present")),
                      ]),
                      DataRow(cells: [
                        DataCell(Text("1")),
                        DataCell(Text("01-02-2005")),
                        DataCell(Text("10:30")),
                        DataCell(Text("Present")),
                      ]),
                      DataRow(cells: [
                        DataCell(Text("1")),
                        DataCell(Text("01-02-2005")),
                        DataCell(Text("10:30")),
                        DataCell(Text("Present")),
                      ]),
                      DataRow(cells: [
                        DataCell(Text("1")),
                        DataCell(Text("01-02-2005")),
                        DataCell(Text("10:30")),
                        DataCell(Text("Present")),
                      ]),
                      DataRow(cells: [
                        DataCell(Text("1")),
                        DataCell(Text("01-02-2005")),
                        DataCell(Text("10:30")),
                        DataCell(Text("Present")),
                      ]),

                    ]),
              ]),
            )
          ],
        )
      ),
    );
  }

  Subject data(){
    Map<String, dynamic> tempJsonData = jsonDecode(mybox.getAt(index));
    Subject tempSubjectObject = Subject.fromJson(tempJsonData);
    return tempSubjectObject;
  }
}// don't remove this
