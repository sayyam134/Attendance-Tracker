import 'package:a_counter/model/detail.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../model/subject.dart';

class DetailPage extends StatefulWidget {
  final int index;

  DetailPage({
    super.key,
    required this.index,
  });

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  Box _subjectbox = Hive.box("_subjectbox");
  List<DataRow> _datarows = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _datapopulate();
  }
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.info_outline_rounded, color: Colors.grey.shade600,),
                    SizedBox(width: 8,),
                    Text("Long Press on Entries to ", style: TextStyle(fontWeight: FontWeight.w300, fontSize: 16),),
                    Text("DELETE", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, color: Colors.red.shade900),),
                  ],
                ),
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
                  //DataColumn(label: Text("ID", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),)),
                  DataColumn(label: Text("Date", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),)),
                  DataColumn(label: Text("Time", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),)),
                  DataColumn(label: Text("Status", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),)),
                ],
                    rows:_datarows
                  ),
              ]),
            )
          ],
        )
      ),
    );
  }

  Subject data(){
    return _subjectbox.getAt(widget.index);
  }

  void _datapopulate(){
    _datarows.clear();
    List<Detail> d = data().dates;
    for(int i=0; i<d.length; i++){
      String status = "";
      if(d[i].ispresent){
        status = "Present";
      }
      else{
        status = "Absent";
      }

      _datarows.add(DataRow(
        onLongPress: (){
          deleterow(i);
        },
          cells: [
        DataCell(Text(d[i].date)),
        DataCell(Text(d[i].time)),
        DataCell(Text(status, style: TextStyle(color: status=="Present" ? Colors.green.shade800 : Colors.red.shade900, fontWeight: FontWeight.bold),)),
      ]));
    }
  }

  void deleterow(int i) async{
    return await showDialog(
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
            title: const Text("Confirm"),
            content: const Text(
              "Are you sure you wish to delete this Entry?",
              style: TextStyle(fontSize: 24),),
            actions: [
              TextButton(
                  onPressed: (){
                    del(i);
                    _datapopulate();
                    Navigator.of(context).pop(true);

          },

                  child: const Text("DELETE",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                        fontSize: 18),)
              ),
              TextButton(
                  onPressed: () =>
                      Navigator.of(context).pop(false),
                  child: const Text("CANCEL",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18),)
              ),
            ],
          );
        }
    );

  }

  void del(int i){
    setState(() {
      Subject temp = data();
      bool status = temp.dates[i].ispresent;
      if(status){
        temp.totalclass--;
        temp.presentclass--;
      }
      else{
        temp.totalclass--;
      }
      //remove from display
      _datarows.removeAt(i);

      //remove from memory

      temp.dates.removeAt(i);
      _subjectbox.putAt(widget.index, temp);
    });
  }
}// don't remove this
