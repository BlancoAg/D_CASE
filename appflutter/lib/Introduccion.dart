//import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:flutter/services.dart';
/*
void main() => runApp(IntroduccionCasoUno());

class IntroduccionCasoUno extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: IntroCasoUno(),
    );
  }
}
*/

class IntroCasoUno extends StatefulWidget {
  @override
  IntroCasoUnoState createState() => IntroCasoUnoState();
}

class IntroCasoUnoState extends State<IntroCasoUno> {
  String videoURL = "https://www.youtube.com/watch?v=Z6W40XmaoJk";
  YoutubePlayerController _controller;

  @override
  void initState() {
    _controller = YoutubePlayerController(
        flags: YoutubePlayerFlags(autoPlay: false),
        initialVideoId: YoutubePlayer.convertUrlToId(videoURL)); //YoutubePlayerController 1

    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
      onWillPop: () async => false,
      child: scaffoldIntro(context),
    );
    //return testVideoPlayer(context);//gamePlayScafold(context);//test(context);//
    //return scaffoldIntro(context);

    //MaterialApp(
    // home: Container(child: scaffoldIntro(context)),
    //);
  }

  // oldIntro(BuildContext context) {
  //   return MaterialApp(
  //     title: 'Welcome to Flutter',
  //     home: Container(
  //       decoration: BoxDecoration(
  //           image: DecorationImage(
  //               image: null, // AssetImage("assets/fondos/Splash.png"),
  //               fit: BoxFit.cover)),
  //       child: scaffoldIntro(context),
  //     ),
  //   );
  // }

  Widget scaffoldIntro(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      //backgroundColor: Colors.deepPurple[600],
      body: Container(
        child: Stack(
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              child: //Padding(
                  //padding: const EdgeInsets.only(top: 200),
                  //child:
                  YoutubePlayer(
                controller: _controller,
                showVideoProgressIndicator: true,
              ),
            ),
            //)Padding,

            Container(
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states) {
                      if (states.contains(MaterialState.pressed)) return Colors.green;
                      return null; // Use the component's default.
                    },
                  ),
                ),
                child: Icon(
                  Icons.close,
                ),
                onPressed: () {
                  ////_controller.pause();
                  ////Navigator.of(context).push(MaterialPageRoute(builder: (context) => Gameplay()));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() async {
    _controller.dispose();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    super.dispose();
  }
}
