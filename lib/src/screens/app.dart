import 'package:flutter/material.dart';
import 'package:milestone_educom/src/atp/default.dart';
import 'package:milestone_educom/src/providers/theme.dart';
import 'package:milestone_educom/src/providers/user.dart';
import 'package:milestone_educom/src/routes/generator.dart';
import 'package:milestone_educom/src/screens/initial_screen.dart';
import 'package:provider/provider.dart';

class MyApp extends StatefulWidget {
  final String imei;
  final String authToken;
  final String defaultTheme;

  MyApp({
    this.imei,
    this.authToken,
    this.defaultTheme,
  });

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(microseconds: 1), getInitialData);
  }

  getInitialData() async {
    final UserBloc userBloc = Provider.of<UserBloc>(context);
    final ThemeBloc themeBloc = Provider.of<ThemeBloc>(context);

    await themeBloc.setTheme(DefaultTheme.defaultTheme(widget.defaultTheme));

    await userBloc.setImei(widget.imei);
    await userBloc.getAuthUser();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(platform: TargetPlatform.android),
      home: InitialScreen(authToken: widget.authToken, imei: widget.imei),
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
