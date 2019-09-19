import 'package:milestone_educom/src/atp/default.dart';
import 'package:milestone_educom/src/helpers/fonts.dart';
import 'package:milestone_educom/src/providers/theme.dart';
import 'package:milestone_educom/src/providers/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:milestone_educom/src/routes/list.dart' as routeList;

class InvalidDevice extends StatefulWidget {
  @override
  _InvalidDevice createState() => _InvalidDevice();
}

class _InvalidDevice extends State<InvalidDevice> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final UserBloc userBloc = Provider.of<UserBloc>(context);
    final ThemeBloc themeBloc = Provider.of<ThemeBloc>(context);
    final DefaultTheme theme = themeBloc.theme;

    return Scaffold(
      backgroundColor: theme.home.appBackgroundColor,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: theme.home.appBackgroundColor,
        title: Text(
          "Device Already Registered",
          style: TextStyle(
            color: Colors.white,
            fontSize: 22.0,
            fontFamily: Fonts.titilliumWebSemiBold,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(height: 50.0),
            Container(
              padding: EdgeInsets.all(40.0),
              child: Text(
                "This Number is already registered on another device. If you want to change device, please contact us.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22.0,
                  fontFamily: Fonts.titilliumWebRegular,
                ),
              ),
            ),
            Expanded(child: Container()),
            GestureDetector(
              onTap: () {
                userBloc.removeAuth();
                Navigator.pushNamed(context, routeList.request_otp);
              },
              child: Container(
                padding: EdgeInsets.all(40.0),
                child: Text(
                  "Log out",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.redAccent,
                    fontSize: 22.0,
                    fontFamily: Fonts.titilliumWebSemiBold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
