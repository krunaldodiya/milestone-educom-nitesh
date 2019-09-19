import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:milestone_educom/src/helpers/fonts.dart';
import 'package:milestone_educom/src/helpers/vars.dart';
import 'package:milestone_educom/src/providers/user.dart';
import 'package:milestone_educom/src/routes/list.dart' as routeList;

import 'src/atp/default.dart';

AppBar getAppBar(
  BuildContext context,
  UserBloc userBloc,
  DefaultTheme theme,
) {
  return AppBar(
    centerTitle: true,
    elevation: 0.5,
    backgroundColor: theme.home.appBackgroundColor,
    textTheme: TextTheme(
      title: TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.white,
        fontSize: 20.0,
        fontFamily: Fonts.titilliumWebRegular,
      ),
    ),
    iconTheme: IconThemeData(
      color: Colors.white,
    ),
    title: Text(
      appName,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.white,
        fontSize: 20.0,
        fontFamily: Fonts.titilliumWebRegular,
      ),
    ),
    actions: <Widget>[
      GestureDetector(
        onTap: () {
          Navigator.pushNamed(
            context,
            routeList.view_profile,
            arguments: {
              "shouldPop": true,
            },
          );
        },
        child: Hero(
          tag: "profile-image",
          child: Container(
            padding: EdgeInsets.all(10.0),
            child: ClipOval(
              child: CachedNetworkImage(
                imageUrl: "$baseUrl/storage/${userBloc.user.avatar}",
                placeholder: (context, url) => CircularProgressIndicator(),
                errorWidget: (context, url, error) => Icon(Icons.error),
                width: 36.0,
                height: 36.0,
                fit: BoxFit.cover,
                alignment: Alignment.center,
              ),
            ),
          ),
        ),
      ),
      Padding(
        padding: EdgeInsets.only(right: 10.0),
      )
    ],
  );
}
