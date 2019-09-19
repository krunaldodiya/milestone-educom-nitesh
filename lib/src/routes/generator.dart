import 'package:milestone_educom/src/routes/list.dart' as routeList;
import 'package:milestone_educom/src/screens/feedback.dart';
import 'package:milestone_educom/src/screens/home.dart';
import 'package:milestone_educom/src/screens/initial_screen.dart';
import 'package:milestone_educom/src/screens/invalid_device.dart';
import 'package:milestone_educom/src/screens/manage_theme.dart';
import 'package:milestone_educom/src/screens/otp/request_otp.dart';
import 'package:milestone_educom/src/screens/otp/verify_otp.dart';
import 'package:milestone_educom/src/screens/show_photo.dart';
import 'package:milestone_educom/src/screens/users/edit_profile.dart';
import 'package:milestone_educom/src/screens/users/profile/gender.dart';
import 'package:milestone_educom/src/screens/users/view_profile.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final Map args = settings.arguments;

    switch (settings.name) {
      case routeList.home:
        return MaterialPageRoute(
          builder: (context) {
            return HomePage();
          },
        );
        break;

      case routeList.show_photo:
        return MaterialPageRoute(
          builder: (context) {
            return ShowPhoto(
              photo: args['photo'],
            );
          },
        );
        break;

      case routeList.manage_theme:
        return MaterialPageRoute(
          builder: (context) {
            return ManageTheme();
          },
        );
        break;

      case routeList.request_otp:
        return MaterialPageRoute(
          builder: (context) {
            return RequestOtpPage();
          },
        );
        break;

      case routeList.verify_otp:
        return MaterialPageRoute(
          builder: (context) {
            return VerifyOtpPage();
          },
        );
        break;

      case routeList.edit_profile:
        if (args['shouldPop'] is bool) {
          return MaterialPageRoute(
            builder: (context) {
              return EditProfilePage(
                shouldPop: args['shouldPop'],
              );
            },
          );
        }

        return _errorRoute();
        break;

      case routeList.view_profile:
        return MaterialPageRoute(
          builder: (context) {
            return ViewProfilePage(
              shouldPop: args['shouldPop'],
            );
          },
        );
        break;

      case routeList.feedback:
        return MaterialPageRoute(
          builder: (context) {
            return FeedbackPage();
          },
        );
        break;

      case routeList.gender:
        return MaterialPageRoute(
          builder: (context) {
            return ChooseGender();
          },
        );
        break;

      case routeList.verify_otp:
        return MaterialPageRoute(
          builder: (context) {
            return FeedbackPage();
          },
        );
        break;

      case routeList.invalid_device:
        return MaterialPageRoute(
          builder: (context) {
            return InvalidDevice();
          },
        );
        break;

      case routeList.verify_otp:
        return MaterialPageRoute(
          builder: (context) {
            return ViewProfilePage(shouldPop: args['shouldPop']);
          },
        );
        break;

      case routeList.initial_screen:
        return MaterialPageRoute(
          builder: (context) {
            return InitialScreen(
              imei: args['imei'],
              authToken: args['authToken'],
            );
          },
        );
        break;

      default:
        return _errorRoute();
    }
  }
}

Route<dynamic> _errorRoute() {
  return MaterialPageRoute(
    builder: (BuildContext context) {
      return Scaffold(body: Center(child: Text("Error")));
    },
  );
}
