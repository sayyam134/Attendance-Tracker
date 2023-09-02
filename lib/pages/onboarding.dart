import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:page_transition/page_transition.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import 'home_page.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({super.key});

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  Box onboard = Hive.box("_onboard");
  final tutorialvideo ="https://youtube.com/shorts/Y9dR1pDPfFI?feature=share";
  late YoutubePlayerController _ytcontroller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final videoID = YoutubePlayer.convertUrlToId(tutorialvideo);
    _ytcontroller = YoutubePlayerController(
      initialVideoId: videoID!,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        loop: true,
      )
    );
  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.only(top: 20,),
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  decoration: BoxDecoration(color: Colors.grey.shade50, borderRadius: BorderRadius.circular(10)),
                  padding: const EdgeInsets.only(left: 15, right: 15, top: 4, bottom: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text("Welcome",  style: TextStyle(fontSize: 34, fontWeight: FontWeight.w400),),
                      const SizedBox(height: 5,),
                      Text("Watch This Tutorial Video to use this App",  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400, color: Colors.grey.shade800,), textAlign: TextAlign.center,),
                    ],
                  ),
                ),
                const SizedBox(height: 20,),
                YoutubePlayer(
                  progressColors: const ProgressBarColors(backgroundColor: Colors.white, playedColor: Colors.red),
                  width: MediaQuery.of(context).size.width*0.80,
                  aspectRatio: 9/16,
                    controller: _ytcontroller,
                  showVideoProgressIndicator: true,
                  bottomActions: [
                    CurrentPosition(),
                    ProgressBar(
                      isExpanded: true,
                    ),
                  ],
                ),
                const SizedBox(height: 15,),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(100, 45),
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.grey.shade900,
                  ),
                  onPressed: (){
                    onboard.put("onboardshown", true);
                    Navigator.push(context,
                        PageTransition(
                            child: const HomePage(),
                            type: PageTransitionType.leftToRightWithFade));
                  },
                  child: const Text("I Understand, Continue", style: TextStyle(fontSize: 26, fontWeight: FontWeight.w400),),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
