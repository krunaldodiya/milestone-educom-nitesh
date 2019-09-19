import 'package:milestone_educom/src/atp/screens/drawer_menu.dart';
import 'package:milestone_educom/src/atp/screens/edit_profile.dart';
import 'package:milestone_educom/src/atp/screens/home.dart';
import 'package:milestone_educom/src/atp/screens/request_otp.dart';
import 'package:milestone_educom/src/atp/screens/verify_otp.dart';
import 'package:milestone_educom/src/atp/screens/view_profile.dart';
import 'package:milestone_educom/src/atp/themes/black/_theme.dart';
import 'package:flutter/material.dart';

class DefaultTheme {
  static Map themes = {
    "black": Black(),
  };

  Home home;
  DrawerMenu drawerMenu;
  RequestOtp requestOtp;
  VerifyOtp verifyOtp;
  EditProfile editProfile;
  ViewProfile viewProfile;

  DefaultTheme({
    @required this.home,
    @required this.drawerMenu,
    @required this.requestOtp,
    @required this.verifyOtp,
    @required this.editProfile,
    @required this.viewProfile,
  });

  static DefaultTheme defaultTheme(String themeName) {
    var theme = themes[themeName];

    return DefaultTheme(
      home: theme.home,
      drawerMenu: theme.drawerMenu,
      requestOtp: theme.requestOtp,
      verifyOtp: theme.verifyOtp,
      editProfile: theme.editProfile,
      viewProfile: theme.viewProfile,
    );
  }
}
