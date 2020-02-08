import 'package:milestone_educom/src/providers/category.dart';
import 'package:milestone_educom/src/providers/otp.dart';
import 'package:milestone_educom/src/providers/school.dart';
import 'package:milestone_educom/src/providers/theme.dart';
import 'package:milestone_educom/src/providers/user.dart';
import 'package:milestone_educom/src/screens/app.dart';
import 'package:flutter/material.dart';
import 'package:imei_plugin/imei_plugin.dart';
import 'package:provider/provider.dart';
import 'package:screen/screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Screen.keepOn(true);

  String imei =
      await ImeiPlugin.getImei(shouldShowRequestPermissionRationale: false);

  SharedPreferences prefs = await SharedPreferences.getInstance();

  String authToken = prefs.getString("authToken");
  String defaultTheme = prefs.getString("defaultTheme") ?? "black";

  // prefs.remove("authToken");

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<CategoryBloc>.value(
          notifier: CategoryBloc(),
        ),
        ChangeNotifierProvider<SchoolBloc>.value(
          notifier: SchoolBloc(),
        ),
        ChangeNotifierProvider<UserBloc>.value(
          notifier: UserBloc(),
        ),
        ChangeNotifierProvider<ThemeBloc>.value(
          notifier: ThemeBloc(),
        ),
        ChangeNotifierProvider<OtpBloc>.value(
          notifier: OtpBloc(),
        ),
      ],
      child: MyApp(
        imei: imei,
        authToken: authToken,
        defaultTheme: defaultTheme,
      ),
    ),
  );
}
