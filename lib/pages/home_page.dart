import 'package:a_counter/pages/detail_page.dart';
import 'package:a_counter/util/item.dart';
import 'package:facebook_audience_network/facebook_audience_network.dart';
import 'package:flutter/material.dart';
import 'package:a_counter/model/subject.dart';
import 'package:hive/hive.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isInterstitialAdLoaded = false;
  late TextEditingController controller1, controller2, controller3;

  List<Subject> item = [];
  Box _subjectbox = Hive.box("_subjectbox");

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller1 = TextEditingController();
    controller2 = TextEditingController();
    controller3 = TextEditingController();
    populateList();
    FacebookAudienceNetwork.init(
      testingId: "0b950512-1eee-401b-94c6-beb4ce854c7c",
      //iOSAdvertiserTrackingEnabled: true,
    );

    _loadInterstitialAd();
  }

  void _loadInterstitialAd() {
    FacebookInterstitialAd.loadInterstitialAd(
      // placementId: "YOUR_PLACEMENT_ID",
      placementId: "IMG_16_9_APP_INSTALL#277399021708749_277431985038786",
      listener: (result, value) {
        print(">> FAN > Interstitial Ad: $result --> $value");
        if (result == InterstitialAdResult.LOADED)
          _isInterstitialAdLoaded = true;

        if (result == InterstitialAdResult.DISMISSED &&
            value["invalidated"] == true) {
          _isInterstitialAdLoaded = false;
          _loadInterstitialAd();
        }
      },
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller1.dispose();
    controller2.dispose();
    controller3.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        bottom: false,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 10,),
              Column(
                children: [
                  Text("Student Attendance Tracker",
                      style: TextStyle(
                          fontSize: 26, fontWeight: FontWeight.bold)),
                  SizedBox(height: 10,),
                ],
              ),
              const SizedBox(height: 2),
              Expanded(
                  child: ListView.builder(itemBuilder: (context, index) {
                    return InkWell(
                      onLongPress: (){
                        _showInterstitialAd();
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> DetailPage(index: index,)));
                      },
                      onTap: (){
                        _showInterstitialAd();
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> DetailPage(index: index,)));
                      },
                      child: Dismissible(
                        background: Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: Container(
                            height: 200,
                            decoration: BoxDecoration(color: Colors.red.withOpacity(0.9),
                                borderRadius: BorderRadius.circular(18)),
                            //color: Colors.red,
                            child: Icon(Icons.delete_forever_rounded,
                              color: Colors.white, size: 84,),),
                        ),
                        key: UniqueKey(),
                        direction: DismissDirection.endToStart,
                        onDismissed: (DismissDirection direction) {
                          setState(() {
                            _subjectbox.deleteAt(index);
                            item.removeAt(index);
                            populateList();
                          });
                        },
                        confirmDismiss: (DismissDirection direction) async {
                          return await showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text("Confirm"),
                                  content: const Text(
                                    "Are you sure you wish to delete this Subject?",
                                    style: TextStyle(fontSize: 24),),
                                  actions: [
                                    TextButton(
                                        onPressed: () =>
                                            Navigator.of(context).pop(true),
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
                              });
                        },
                        child: MyItem(
                          index: index,
                          SubName: item[index].subjectname,
                          TotClass: item[index].totalclass,
                          PresentClass: item[index].presentclass,
                          item: item,),
                      ),
                    );
                  }, itemCount: item.length,
                  )
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: const SizedBox(height: 20),
              )
            ]
        ),
      ),
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(side: BorderSide(width: 5, color: Colors.white), borderRadius: BorderRadius.circular(100)),
        onPressed: () {
          addItem();
        },
        backgroundColor: Colors.grey.shade900,
        child: Icon(Icons.add, color: Colors.white, size: 38,),
      ),
    );
  }

  void addItem() {
    showDialog(context: context, builder: (context) {
      return AlertDialog(
        title: Center(child: Text(
          "Add Subject", style: TextStyle(fontWeight: FontWeight.bold),)),
        content: Container(
          height: 145,
          child: Column(
            children: [
              TextField(controller: controller1,
                  autofocus: true,
                  decoration: InputDecoration(hintText: "Enter Subject Name")),
              TextField(controller: controller2,
                  autofocus: true,
                  decoration: InputDecoration(
                      hintText: "Enter Total No. of Class"),
                  keyboardType: TextInputType.number),
              TextField(controller: controller3,
                  autofocus: true,
                  decoration: InputDecoration(
                      hintText: "Enter No. of Present Class "),
                  keyboardType: TextInputType.number),
            ],
          ),
        ),
        actions: [
          Center(
            child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    item_added();
                  });
                },
                child: Text("Submit")),
          )
        ],
      );
    });
  }

  void item_added() async {
    var name = controller1.text;
    var totday = int.parse(controller2.text);
    var pday = int.parse(controller3.text);

    if (totday >= pday) {
      Subject temp = Subject(subjectname: name, totalclass: totday, presentclass: pday);
      _subjectbox.add(temp);
      populateList();
      Navigator.of(context).pop();
    }
    else {
      Navigator.of(context).pop();
      showDialog(context: context, builder: (context) {
        return AlertDialog(
          title: Center(child: Text(
            "Subject Not Added",
            style: TextStyle(fontWeight: FontWeight.bold),)),
          content: Container(
            height: 60,
            child: Text(
                "No of Present cannot be more than Total No of days.", style: TextStyle(fontSize: 20),),
          ),
        actions: [
          Center(
            child: TextButton(
                onPressed: () {
                  _showInterstitialAd();
                  setState(() {
                    Navigator.of(context).pop();
                  });
                },
                child: Text("Close", style: TextStyle(color: Colors.red, fontSize: 24),)),
          )
        ],
        );
      });
    }
  }

  void populateList() {
    item.clear();
    for (int index = 0; index < _subjectbox.length; index++) {
      item.add(_subjectbox.getAt(index));
    }
  }

  _showInterstitialAd() {
    if (_isInterstitialAdLoaded == true)
      FacebookInterstitialAd.showInterstitialAd();
    else
      print("Interstial Ad not yet loaded!");
  }
}// don't remove this

