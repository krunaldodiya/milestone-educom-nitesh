import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class Home {
  Color backgroundColor;
  Color appBackgroundColor;
  Color navigationBackgroundColor;
  Color navigationColor;
  Color navigationButtonBackgroundColor;
  Color fabBackgroundColor;
  Color fabIconColor;

  Home({
    @required this.backgroundColor,
    @required this.appBackgroundColor,
    @required this.navigationBackgroundColor,
    @required this.navigationColor,
    @required this.navigationButtonBackgroundColor,
    @required this.fabBackgroundColor,
    @required this.fabIconColor,
  });

  factory Home.initial() {
    return Home(
      backgroundColor: Colors.black,
      appBackgroundColor: Colors.black,
      navigationBackgroundColor: Colors.black,
      navigationColor: Colors.black,
      navigationButtonBackgroundColor: Colors.black,
      fabBackgroundColor: Colors.black,
      fabIconColor: Colors.white,
    );
  }
}
