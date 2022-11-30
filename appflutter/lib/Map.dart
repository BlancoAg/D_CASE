import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_player_360/video_player_360.dart';

//Planta Baja
String videoPileta = "";

Widget zoomeableMap(String imageName) {
  return InteractiveViewer(
      panEnabled: false, // Set it to false to prevent panning.
      boundaryMargin: EdgeInsets.all(0),
      minScale: 1,
      maxScale: 4,
      child: mapBodyResponsiveFloor1(imageName));
  // child: imageName == "floor 1"
  //     ? mapBodyResponsiveFloor1(imageName)
  //     : imageName == "floor 2"
  //         ? mapBodyFloor2(imageName)
  //         : mapBodyFloor3(imageName));
}

Widget mapBodyResponsiveFloor1(String imageName) {
  return Stack(children: [
    //IMAGEN DE MAPA --NO SE TOCA
    Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(imageName),
          fit: BoxFit.cover,
        ),
      ),
    ),

    return3Columns(imageName),
  ]);
}

Widget customButtonMap2(String videoURL) {
  return OutlineButton(
      borderSide: BorderSide(color: Colors.orange, width: 2.0), //solo desarrollo
      onPressed: () async {
        await VideoPlayer360.playVideoURL(videoURL);
        // gameplayState.refresh();
      });
}

Widget return3Columns(String imageName) {
  String videoUrl = "https://github.com/maxmouser/D-CASE/blob/main/estar_360_4k.mp4?raw=true%22";
  return Container(
    child: new Row(
      children: <Widget>[
        new Expanded(
          flex: 12,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              new Flexible(fit: FlexFit.tight, child: Container()),
              new Flexible(fit: FlexFit.tight, child: Container()),
              new Flexible(fit: FlexFit.tight, child: customButtonMap2(videoUrl)), //garage
            ],
          ),
        ),
        new Expanded(
          flex: 4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              new Flexible(fit: FlexFit.tight, child: Container()),
              new Flexible(fit: FlexFit.tight, child: Container()),
              new Flexible(fit: FlexFit.tight, child: Container()),
            ],
          ),
        ),
        new Expanded(
          flex: 10,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              new Flexible(fit: FlexFit.tight, child: customButtonMap2(videoUrl)), //pileta
              new Flexible(fit: FlexFit.tight, child: customButtonMap2(videoUrl)), //living
              new Flexible(fit: FlexFit.tight, child: customButtonMap2(videoUrl)), //cocina
            ],
          ),
        ),
      ],
    ),
  );
}

// Widget mapBodyFloor1(String imageName) {
//     return Stack(
//       children: [
//         //IMAGEN DE MAPA --NO SE TOCA
//         Container(
//           decoration: BoxDecoration(
//             image: DecorationImage(
//               image: AssetImage(imageName),
//               fit: BoxFit.cover,
//             ),
//           ),
//         ),
//         //BOTON PILETA
//         customButtonMap(268, 65, 140, 0,
//             "https://github.com/maxmouser/D-CASE/blob/main/estar_360_4k.mp4?raw=true%22"),

//         //BOTON DE GARAGE
//         customButtonMap(5, 430, 200, 180,
//             "https://github.com/maxmouser/D-CASE/blob/main/estar_360_4k.mp4?raw=true%22"),

//         //Boton Living
//         customButtonMap(270, 260, 170, 90,
//             "https://github.com/maxmouser/D-CASE/blob/main/estar_360_4k.mp4?raw=true%22"),

//         //Boton Cocina
//         customButtonMap(270, 480, 100, 100,
//             "https://github.com/maxmouser/D-CASE/blob/main/estar_360_4k.mp4?raw=true%22"),
//       ],
//     );
//   }
