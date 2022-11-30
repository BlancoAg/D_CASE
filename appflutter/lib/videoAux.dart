import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

/*
@override
void dispose() {
  super.dispose();
  videoControllerSplash.dispose();
}
*/

Widget videoWidget(BuildContext context) {
  VideoPlayerController videoControllerSplash = VideoPlayerController.asset(
      "assets/fondos/splash2.mp4"); //"assets/fondos/splash2.mp4");
  return SizedBox.expand(
    child: AspectRatio(
      aspectRatio: videoControllerSplash.value.aspectRatio,
      child: VideoPlayer(videoControllerSplash),
    ),
  );
}
