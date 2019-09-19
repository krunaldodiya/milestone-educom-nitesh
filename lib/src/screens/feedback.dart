import 'package:milestone_educom/src/atp/default.dart';
import 'package:milestone_educom/src/helpers/fonts.dart';
import 'package:milestone_educom/src/helpers/validation.dart';
import 'package:milestone_educom/src/providers/theme.dart';
import 'package:milestone_educom/src/providers/user.dart';
import 'package:milestone_educom/src/screens/helpers/alert.dart';
import 'package:milestone_educom/src/screens/users/editable.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xs_progress_hud/xs_progress_hud.dart';

class FeedbackPage extends StatefulWidget {
  FeedbackPage({Key key}) : super(key: key);

  @override
  _FeedbackPage createState() => _FeedbackPage();
}

class _FeedbackPage extends State<FeedbackPage> {
  TextEditingController feedbackController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final ThemeBloc themeBloc = Provider.of<ThemeBloc>(context);
    final UserBloc userBloc = Provider.of<UserBloc>(context);

    final DefaultTheme theme = themeBloc.theme;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.home.appBackgroundColor,
        title: Text(
          "Feedback",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.0,
            fontWeight: FontWeight.normal,
            fontFamily: "TitilliumWeb-SemiBold",
          ),
        ),
      ),
      backgroundColor: theme.requestOtp.backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(margin: EdgeInsets.all(10.0)),
              Container(
                padding: EdgeInsets.all(20.0),
                child: Text(
                  "આપના કિંમતી અભિપ્રાય અમને આપ અહીં કહી શકો છો. એપ્લીકેશન ને લગતું કે વિડિયોને લગતું કોઈપણ સુધારા/વધારા, સલાહ/સુચન હોય તો તે આવકાર્ય છે. યોગ્ય સલાહ સુચનનું વહેલા તે પહેલાના ધોરણે અમલ કરવામાં આવશે. ઉપરાંત આપને મુંજવતા કોઈપણ પ્રશ્ન તમે અમને અહીં પૂછી શકો છો.",
                  textAlign: TextAlign.center,
                  softWrap: true,
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.white,
                    fontFamily: Fonts.titilliumWebRegular,
                  ),
                ),
              ),
              Container(margin: EdgeInsets.all(10.0)),
              EditableFormField(
                maxLength: 500,
                maxLines: 5,
                keyboardType: TextInputType.multiline,
                labelText: "Feedback Form",
                errorText: getErrorText(userBloc.error, 'feedback'),
                onChanged: (feedback) {
                  setState(() {
                    feedbackController.text = feedback;
                  });
                },
              ),
              FlatButton(
                onPressed: () {
                  sendFeedback(userBloc);
                },
                padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                child: Text(
                  "SEND FEEDBACK",
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: Fonts.titilliumWebRegular,
                  ),
                ),
                color: Colors.red,
              ),
            ],
          ),
        ),
      ),
    );
  }

  sendFeedback(UserBloc userBloc) async {
    XsProgressHud.show(context);

    final String message = await userBloc.sendFeedback(
      feedbackController.text,
      userBloc.user,
    );

    XsProgressHud.hide();

    if (userBloc.error == null) {
      return showAlertPopup(
        context,
        message: message,
        onPressOk: () {
          Navigator.of(context).popUntil((route) => route.isFirst);
        },
      );
    }
  }
}
