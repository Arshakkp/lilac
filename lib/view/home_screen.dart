import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lilac/utils/labelStyle.dart';
import 'package:lilac/view/drawer.dart';

import 'package:lilac/view/widget/video_player.dart';
import 'package:video_player/video_player.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
  bool isFullScreen = false;
  Future<bool> onBack() async {
    print("working");
    if (isFullScreen) {
      SystemChrome.setPreferredOrientations(
          [DeviceOrientation.portraitUp, DeviceOrientation.portraitUp]);
      isFullScreen = false;

      return false;
    } else {
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    var _height = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: onBack,
      child: Scaffold(
        key: _globalKey,
        drawer: const LilacDrawer(),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(children: [
              Stack(
                children: [
                  LilacVideoPlayer(
                      onBack: onBack,
                      isFullscreen: isFullScreen,
                      onFullScreen: (() {
                        SystemChrome.setPreferredOrientations([
                          DeviceOrientation.landscapeLeft,
                          DeviceOrientation.landscapeRight
                        ]);
                        setState(() {
                          isFullScreen = true;
                        });
                      }),
                      videoLink:
                          'https://drive.google.com/uc?export=download&id=17Ay3gaRBnzozeSG9QZVvc3w8-G07r-vE'),
                  if (!isFullScreen)
                    Positioned(
                        top: 0,
                        left: 0,
                        child: IconButton(
                          onPressed: () {
                            _globalKey.currentState!.openDrawer();
                          },
                          icon: const Icon(
                            Icons.menu,
                            size: 30,
                            color: Colors.white,
                          ),
                        )),
                ],
              )
            ]),
          ),
        ),
      ),
    );
  }
}
