import 'package:milestone_educom/src/atp/default.dart';
import 'package:milestone_educom/src/atp/screens/drawer_menu.dart';
import 'package:milestone_educom/src/atp/screens/edit_profile.dart';
import 'package:milestone_educom/src/atp/screens/home.dart';
import 'package:milestone_educom/src/atp/screens/request_otp.dart';
import 'package:milestone_educom/src/atp/screens/verify_otp.dart';
import 'package:milestone_educom/src/atp/screens/view_profile.dart';
import 'package:milestone_educom/src/atp/themes/black/drawer.dart';
import 'package:milestone_educom/src/atp/themes/black/edit_profile.dart';
import 'package:milestone_educom/src/atp/themes/black/home.dart';
import 'package:milestone_educom/src/atp/themes/black/request_otp.dart';
import 'package:milestone_educom/src/atp/themes/black/verify_otp.dart';
import 'package:milestone_educom/src/atp/themes/black/view_profile.dart';

class Black implements DefaultTheme {
  @override
  Home home = homeTheme;
  @override
  RequestOtp requestOtp = requestOtpTheme;
  @override
  VerifyOtp verifyOtp = verifyOtpTheme;
  @override
  DrawerMenu drawerMenu = drawerMenuTheme;
  @override
  EditProfile editProfile = editProfileTheme;
  @override
  ViewProfile viewProfile = viewProfileTheme;
}
