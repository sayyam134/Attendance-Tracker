import 'package:a_counter/pages/home_page.dart';
import 'package:a_counter/pages/onboarding.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'model/detail.dart';
import 'model/subject.dart';

bool? isshown;

void main()async{
  await Hive.initFlutter();
  Hive.registerAdapter(SubjectAdapter());
  Hive.registerAdapter(DetailAdapter());
  await Hive.openBox("_subjectbox");
  Box onBoard = await Hive.openBox("_onboard");
  isshown =onBoard.get("onboardshown");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: isshown !=true ? OnBoarding(): HomePage(),
    );
  }
}
