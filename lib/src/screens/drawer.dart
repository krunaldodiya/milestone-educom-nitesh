import 'package:milestone_educom/src/atp/default.dart';
import 'package:milestone_educom/src/helpers/fonts.dart';
import 'package:milestone_educom/src/helpers/vars.dart';
import 'package:milestone_educom/src/models/user.dart';
import 'package:milestone_educom/src/providers/theme.dart';
import 'package:milestone_educom/src/providers/user.dart';
import 'package:milestone_educom/src/routes/list.dart' as routeList;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:milestone_educom/src/screens/helpers/institute.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

class DrawerPage extends StatefulWidget {
  final UserBloc userBloc;
  final ThemeBloc themeBloc;

  const DrawerPage({
    Key key,
    @required this.userBloc,
    @required this.themeBloc,
  }) : super(key: key);

  @override
  _DrawerPageState createState() => _DrawerPageState();
}

class _DrawerPageState extends State<DrawerPage> {
  launchURL(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeBloc themeBloc = widget.themeBloc;
    final UserBloc userBloc = widget.userBloc;

    final DefaultTheme theme = themeBloc.theme;
    final User user = userBloc.user;

    return Container(
      color: theme.drawerMenu.backgroundColor,
      child: ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text(
              user.name.toUpperCase(),
              style: TextStyle(
                color: Colors.black,
                fontFamily: Fonts.titilliumWebSemiBold,
              ),
            ),
            accountEmail: Text(
              user.email,
              style: TextStyle(
                color: Colors.black,
                fontFamily: Fonts.titilliumWebRegular,
              ),
            ),
            currentAccountPicture: Container(
              child: ClipOval(
                child: CachedNetworkImage(
                  imageUrl: "$baseUrl/storage/${user.avatar}",
                  placeholder: (context, url) => CircularProgressIndicator(),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                  width: 60.0,
                  height: 60.0,
                  fit: BoxFit.cover,
                  alignment: Alignment.center,
                ),
              ),
            ),
            decoration: BoxDecoration(
              color: theme.drawerMenu.topBackgroundColor,
            ),
          ),
          ListTile(
            title: Text(
              getInstituteName(userBloc.user.institute),
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.0,
                fontFamily: "TitilliumWeb-Regular",
              ),
            ),
            trailing: Icon(
              Icons.home,
              color: Colors.white,
            ),
            onTap: () {
              Navigator.of(context).pop();
            },
          ),
          Divider(color: Colors.grey),
          ListTile(
            title: Text(
              "About",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.0,
                fontFamily: "TitilliumWeb-Regular",
              ),
            ),
            trailing: Icon(
              Icons.info,
              color: Colors.white,
            ),
            onTap: () async {
              launchURL(webUrl);
            },
          ),
          ListTile(
            title: Text(
              "Feedback",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.0,
                fontFamily: "TitilliumWeb-Regular",
              ),
            ),
            trailing: Icon(
              Icons.mail,
              color: Colors.white,
            ),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.pushNamed(context, routeList.feedback);
            },
          ),
          ListTile(
            title: Text(
              "Share",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.0,
                fontFamily: "TitilliumWeb-Regular",
              ),
            ),
            trailing: Icon(
              Icons.share,
              color: Colors.white,
            ),
            onTap: () {
              Share.share(shareText).then((data) {
                print("data");
              });
            },
          ),
          ListTile(
            title: Text(
              "Rate Us",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.0,
                fontFamily: "TitilliumWeb-Regular",
              ),
            ),
            trailing: Icon(
              Icons.star,
              color: Colors.white,
            ),
            onTap: () {
              launchURL(appId);
            },
          ),
          Divider(color: Colors.grey),
          ListTile(
            title: Text(
              "Facebook Page",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.0,
                fontFamily: "TitilliumWeb-Regular",
              ),
            ),
            trailing: Icon(
              Ionicons.logo_facebook,
              color: Colors.white,
            ),
            onTap: () async {
              launchURL(userBloc.user.setting.facebookPage);
            },
          ),
          ListTile(
            title: Text(
              "Youtube Channel",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.0,
                fontFamily: "TitilliumWeb-Regular",
              ),
            ),
            trailing: Icon(
              Ionicons.logo_youtube,
              color: Colors.white,
            ),
            onTap: () {
              launchURL(userBloc.user.setting.youtubeChannel);
            },
          ),
          Divider(color: Colors.grey),
          ListTile(
            title: Text(
              "Terms & Conditions",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.0,
                fontFamily: "TitilliumWeb-Regular",
              ),
            ),
            trailing: Icon(
              Icons.assignment,
              color: Colors.white,
            ),
            onTap: () async {
              launchURL("$webUrl/terms-and-condition");
            },
          ),
          ListTile(
            title: Text(
              "Privacy Policy",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.0,
                fontFamily: "TitilliumWeb-Regular",
              ),
            ),
            trailing: Icon(
              Icons.lock,
              color: Colors.white,
            ),
            onTap: () {
              launchURL("$webUrl/privacy-policy");
            },
          ),
          ListTile(
            title: Text(
              "Legal Notice",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.0,
                fontFamily: "TitilliumWeb-Regular",
              ),
            ),
            trailing: Icon(
              Icons.book,
              color: Colors.white,
            ),
            onTap: () async {
              launchURL("$webUrl/legal-notice");
            },
          ),
          ListTile(
            title: Text(
              "Disclaimer",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.0,
                fontFamily: "TitilliumWeb-Regular",
              ),
            ),
            trailing: Icon(
              Icons.new_releases,
              color: Colors.white,
            ),
            onTap: () {
              launchURL("$webUrl/disclaimer");
            },
          ),
          Divider(color: Colors.grey),
          ListTile(
            title: Text(
              "All Rights Reserved.",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.0,
                fontFamily: "TitilliumWeb-Regular",
              ),
            ),
            trailing: Icon(
              Icons.copyright,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
