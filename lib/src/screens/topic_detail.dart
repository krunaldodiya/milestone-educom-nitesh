import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:milestone_educom/src/atp/default.dart';
import 'package:milestone_educom/src/helpers/vars.dart';
import 'package:milestone_educom/src/models/subscription.dart';
import 'package:milestone_educom/src/models/topic.dart';
import 'package:milestone_educom/src/models/video.dart';
import 'package:milestone_educom/src/providers/theme.dart';
import 'package:milestone_educom/src/providers/user.dart';
import 'package:milestone_educom/src/screens/helpers/confirm.dart';
import 'package:milestone_educom/src/screens/video_list.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class TopicDetailPage extends StatefulWidget {
  final Topic topic;

  TopicDetailPage({
    Key key,
    @required this.topic,
  }) : super(key: key);

  @override
  _TopicDetailPage createState() => _TopicDetailPage();
}

class _TopicDetailPage extends State<TopicDetailPage> {
  Video currentVideo;

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(microseconds: 1), getInitialData);
  }

  getInitialData() {
    //
  }

  setCurrentVideo(video) {
    setState(() {
      currentVideo = video;
    });
  }

  String getSubscriptionUrl(Video video) {
    final int categoryId = widget.topic.categoryId;
    final UserBloc userBloc = Provider.of<UserBloc>(context);

    List data = userBloc.user.subscriptions
        .where((subscription) => subscription.categoryId == categoryId)
        .toList();

    Subscription subscription = data.isEmpty ? null : data.first;

    if (subscription == null) {
      return userBloc.user.setting.noSubscriptionUrl;
    }

    if (subscription.status == "Expired") {
      return userBloc.user.setting.subscriptionExpireUrl;
    }

    return "${userBloc.user.setting.videoUrl}/${video.url}";
  }

  @override
  Widget build(BuildContext context) {
    final ThemeBloc themeBloc = Provider.of<ThemeBloc>(context);
    final DefaultTheme theme = themeBloc.theme;

    return Scaffold(
      backgroundColor: theme.home.appBackgroundColor,
      appBar: AppBar(
        title: Text(widget.topic.name),
        backgroundColor: theme.home.appBackgroundColor,
      ),
      body: SafeArea(
        child: widget.topic.videos.length == 0
            ? Center(
                child: Text(
                  "No videos yet.",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                    fontWeight: FontWeight.normal,
                    fontFamily: "TitilliumWeb-SemiBold",
                  ),
                ),
              )
            : ListView(children: getVideos()),
      ),
    );
  }

  List<Widget> getVideos() {
    List<Widget> data = [];

    if (widget.topic.videos.length == 0) {
      data.add(noTopics());
    } else {
      for (Video video in widget.topic.videos) {
        bool isActive = currentVideo != null && currentVideo.id == video.id;

        data.add(
          GestureDetector(
            onTap: () async {
              setCurrentVideo(video);

              try {
                String url = getSubscriptionUrl(video);
                List<int> bytes = utf8.encode(url);
                String base64Str = base64.encode(bytes);

                final directory = Directory("/storage/emulated/0/mplayer");
                final file = File("${directory.path}/cache");
                final exists = file.existsSync();

                final permissions = PermissionHandler();

                final PermissionStatus permissionGranted = await permissions
                    .checkPermissionStatus(PermissionGroup.storage);

                if (permissionGranted != PermissionStatus.granted) {
                  await permissions
                      .requestPermissions([PermissionGroup.storage]);
                }

                if (!exists) {
                  file.createSync(recursive: true);
                }

                file.writeAsString(base64Str).then((data) {
                  launch("mplayer://play/url?$url");
                });
              } catch (e) {
                showConfirmationPopup(
                  context,
                  message: "Please, Install MPlayer.",
                  noText: "Cancel",
                  yesText: "Install",
                  onPressYes: () async {
                    await launch(mPlayerId);
                  },
                );
              }
            },
            child: getVideoList(video, isActive),
          ),
        );
      }
    }

    return data;
  }

  Container topicLabel() {
    return Container(
      margin: EdgeInsets.only(left: 10.0, top: 15.0, bottom: 15.0),
      child: Text(
        "Videos".toUpperCase(),
        style: TextStyle(
          color: Colors.white,
          fontSize: 18.0,
          fontWeight: FontWeight.normal,
          fontFamily: "TitilliumWeb-SemiBold",
        ),
      ),
    );
  }

  Container noTopics() {
    return Container(
      margin: EdgeInsets.only(left: 10.0),
      child: Text(
        "No videos added yet.",
        style: TextStyle(
          color: Colors.white,
          fontSize: 18.0,
          fontWeight: FontWeight.normal,
          fontFamily: "TitilliumWeb-Regular",
        ),
      ),
    );
  }
}
