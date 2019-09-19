import 'package:milestone_educom/src/models/school.dart';
import 'package:milestone_educom/src/providers/school.dart';
import 'package:flutter/material.dart';
import 'package:milestone_educom/src/atp/default.dart';
import 'package:milestone_educom/src/helpers/fonts.dart';
import 'package:milestone_educom/src/providers/theme.dart';
import 'package:milestone_educom/src/providers/user.dart';
import 'package:provider/provider.dart';

class ChooseSchool extends StatefulWidget {
  @override
  _ChooseSchoolState createState() => _ChooseSchoolState();
}

class _ChooseSchoolState extends State<ChooseSchool> {
  String keywords;

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(microseconds: 1), getInitialData);
  }

  void getInitialData() async {
    final SchoolBloc schoolBloc = Provider.of<SchoolBloc>(context);

    if (schoolBloc.schools.length == 0) {
      schoolBloc.getSchools();
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeBloc themeBloc = Provider.of<ThemeBloc>(context);
    final UserBloc userBloc = Provider.of<UserBloc>(context);
    final SchoolBloc schoolBloc = Provider.of<SchoolBloc>(context);

    final DefaultTheme theme = themeBloc.theme;

    List schools = schoolBloc.schools;

    if (schoolBloc.loading == true) {
      return Center(child: CircularProgressIndicator());
    }

    if (keywords != null) {
      schools = schoolBloc.schools.where((school) {
        return school.name.toLowerCase().contains(keywords.toLowerCase());
      }).toList();
    }

    return Scaffold(
      backgroundColor: theme.editProfile.backgroundColor,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(20.0),
              child: TextField(
                cursorColor: theme.editProfile.cursorColor,
                onChanged: (value) {
                  setState(() {
                    keywords = value;
                  });
                },
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                  fontFamily: 'TitilliumWeb-Regular',
                ),
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.blue,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.blue,
                    ),
                  ),
                  labelText: "Filter School",
                  labelStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                    fontFamily: 'TitilliumWeb-Regular',
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(left: 20.0),
                child: ListView.builder(
                  itemCount: schools.length,
                  itemBuilder: (BuildContext context, index) {
                    final School school = schools[index];

                    return GestureDetector(
                      onTap: () {
                        userBloc.onChangeData(
                          "school",
                          school,
                          userBloc.user,
                        );

                        Navigator.of(context).pop(school);
                      },
                      child: Container(
                        padding: EdgeInsets.all(10.0),
                        child: Text(
                          school.name,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                            fontFamily: Fonts.titilliumWebRegular,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
