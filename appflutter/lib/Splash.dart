//import 'dart:html';
//import 'package:appflutter/YOUTUBE.dart';

import 'dart:io';

import 'package:appflutter/DataBaseService.dart';
import 'package:appflutter/Introduccion.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';

import 'Home.dart';
//import 'videoAux.dart';

class MainPage extends StatefulWidget {
  final User user;

  const MainPage({Key key, this.user}) : super(key: key);
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  VideoPlayerController videoControllerSplash;

  @override
  void initState() {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    super.initState();

    // SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    // Pointing the video controller to our local asset.
    videoControllerSplash =
        VideoPlayerController.asset("assets/fondos/splash2.mp4") //"assets/fondos/splash2.mp4");
          ..initialize().then((_) {
            // Once the video has been loaded we play the video and set looping to true.
            videoControllerSplash.play();
            videoControllerSplash.setLooping(true);
            // Ensure the first frame is shown after the video is initialized.
            setState(() {});
          });
  }

  void playRemoteFile() {
    AudioPlayer player = new AudioPlayer();
    player.setVolume(1);
    print("audio player");
    String url =
        "https://drive.google.com/file/d/1c66Cq7CaayKMfrDDA93xSvICUJf5HxFF/view?usp=sharing";
    player.play(url);
    //player.play("https://bit.ly/2CH50TO");
  }

  playLocal() async {
    AudioPlayer audioPlayer = new AudioPlayer();
    print("audio player");
    audioPlayer.setVolume(1);
    int result = await audioPlayer.play("music.wav", isLocal: true);
  }

  Future<AudioPlayer> playLocalAsset() async {
    AudioCache audioCache = new AudioCache();
    //audioCache.fixedPlayer.stop();
    // audioCache.fixedPlayer.setVolume(1);
    if (Platform.isIOS) {
      if (audioCache.fixedPlayer != null) {
        audioCache.fixedPlayer.startHeadlessService();
      }
    }
    return await audioCache.loop("music.wav", volume: 0.5, mode: PlayerMode.LOW_LATENCY);
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  FirebaseAuth _auth = FirebaseAuth.instance;
  final databaseReference = FirebaseDatabase.instance.reference();

  @override
  Widget build(BuildContext context) {
    //playLocalAsset();
    return new WillPopScope(onWillPop: () async => false, child: caso1(context));
  }

  Widget caso1(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to Flutter',
      home: stackWidget(),
    );
  }

  Widget stackWidget() {
    return Stack(
      children: <Widget>[
        Container(
          child: videoWidget(context),
        ),
        Container(
          child: scafoldHome(),
        )
      ],
    );
  }

  Widget scafoldHome() {
    Character characterInitial = new Character();
    characterInitial.name = "Test";
    characterInitial.id = "A";
    characterInitial.pcIsUnlocked = false;
    characterInitial.phoneIsUnlocked = false;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: GestureDetector(
        onTap: () {
          //popUpCodigoCaso(context);
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => HomeNuevoWidget(
                    characterSelected: characterInitial,
                    indexBody: 0,
                  )));
        },
      ),
    );
  }

  Widget oldHome() {
    Container(
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage("assets/fondos/Splash.png"), fit: BoxFit.cover),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: GestureDetector(
          onTap: () {
            //popUpCodigoCaso(context);
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => IntroCasoUno()));
          },
        ),
      ),
    );
  }

  Widget videoWidget(BuildContext context) {
    return SizedBox.expand(
      child: AspectRatio(
        aspectRatio: videoControllerSplash.value.aspectRatio,
        child: VideoPlayer(videoControllerSplash),
      ),
    );
  }
}
