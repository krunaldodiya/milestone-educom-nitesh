import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:milestone_educom/src/providers/user.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

class LoadVideoPlayer extends StatefulWidget {
  final String url;

  LoadVideoPlayer({
    Key key,
    @required this.url,
  }) : super(key: key);

  @override
  _LoadVideoPlayer createState() => _LoadVideoPlayer();
}

class _LoadVideoPlayer extends State<LoadVideoPlayer> {
  VideoPlayerController controller;

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(microseconds: 1), getInitialData);
  }

  getInitialData() async {
    setState(() {
      if (widget.url != null) {
        controller = VideoPlayerController.network(widget.url);
      }
    });
  }

  @override
  void dispose() {
    setPortrait();

    if (widget.url != null) {
      controller.dispose();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (controller == null) return Container();

    final UserBloc userBloc = Provider.of<UserBloc>(context);

    final ChewieController getChewieController = chewieController(userBloc);

    getChewieController.addListener(() {
      if (getChewieController.isFullScreen) {
        setLandscape();
      } else {
        setPortrait();
      }
    });

    return SafeArea(
      child: Chewie(controller: getChewieController),
    );
  }

  setPortrait() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  setLandscape() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
  }

  ChewieController chewieController(UserBloc userBloc) {
    return ChewieController(
      videoPlayerController: controller,
      autoInitialize: true,
      aspectRatio: 16 / 9,
      autoPlay: true,
      showControls: true,
      allowedScreenSleep: false,
      // placeholder: Center(child: CircularProgressIndicator()),
      allowFullScreen: true,
      allowMuting: true,
      fullScreenByDefault: false,
      placeholder: Container(
        alignment: Alignment.topRight,
        child: Text(
          userBloc.user.mobile,
          textAlign: TextAlign.right,
          style: TextStyle(
            fontSize: double.parse(userBloc.user.setting.watermarkSize),
            color: Color(int.parse(userBloc.user.setting.watermarkColor)),
          ),
        ),
      ),
      overlay: Container(
        alignment: Alignment.topRight,
        child: Text(
          userBloc.user.mobile,
          textAlign: TextAlign.right,
          style: TextStyle(
            fontSize: double.parse(userBloc.user.setting.watermarkSize),
            color: Color(int.parse(userBloc.user.setting.watermarkColor)),
          ),
        ),
      ),
    );
  }
}
