import 'package:milestone_educom/src/atp/default.dart';
import 'package:milestone_educom/src/helpers/fonts.dart';
import 'package:milestone_educom/src/helpers/vars.dart';
import 'package:milestone_educom/src/models/category.dart';
import 'package:milestone_educom/src/providers/category.dart';
import 'package:milestone_educom/src/providers/theme.dart';
import 'package:milestone_educom/src/providers/user.dart';
import 'package:milestone_educom/src/screens/category_detail.dart';
import 'package:milestone_educom/src/screens/drawer.dart';
import 'package:milestone_educom/src/screens/helpers/institute.dart';
import 'package:milestone_educom/src/screens/users/view_profile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePage createState() => _HomePage();
}

class _HomePage extends State<HomePage> with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(microseconds: 1), getInitialData);
  }

  getInitialData() {
    final CategoryBloc categoryBloc = Provider.of<CategoryBloc>(context);
    categoryBloc.getCategories();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeBloc themeBloc = Provider.of<ThemeBloc>(context);
    final UserBloc userBloc = Provider.of<UserBloc>(context);
    final CategoryBloc categoryBloc = Provider.of<CategoryBloc>(context);

    final DefaultTheme theme = themeBloc.theme;

    return Scaffold(
      backgroundColor: theme.home.backgroundColor,
      appBar: AppBar(
        backgroundColor: theme.home.appBackgroundColor,
        textTheme: TextTheme(
          title: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 20.0,
            fontFamily: 'TitilliumWeb-Regular',
          ),
        ),
        title: Text(
          getInstituteName(userBloc.user.institute),
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 20.0,
            fontFamily: 'TitilliumWeb-Regular',
          ),
        ),
        actions: <Widget>[
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => ViewProfilePage(
                    shouldPop: true,
                  ),
                ),
              );
            },
            child: Hero(
              tag: "profile-image",
              child: Container(
                padding: EdgeInsets.all(10.0),
                child: ClipOval(
                  child: Image.network(
                    "$baseUrl/storage/${userBloc.user.avatar}",
                    width: 36.0,
                    height: 36.0,
                    fit: BoxFit.cover,
                    alignment: Alignment.center,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: 10.0),
          )
        ],
      ),
      body: SafeArea(
        child: categoryBloc.loaded != true
            ? Center(child: CircularProgressIndicator())
            : createGridView(categoryBloc),
      ),
      drawer: Drawer(
        child: DrawerPage(userBloc: userBloc, themeBloc: themeBloc),
      ),
    );
  }

  Container createGridView(CategoryBloc categoryBloc) {
    if (categoryBloc.categories.length == 0) {
      return Container(
        margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
        child: Text(
          "No categories yet.",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: 18.0,
            fontFamily: Fonts.titilliumWebSemiBold,
          ),
        ),
      );
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1,
        ),
        itemCount: categoryBloc.categories.length,
        itemBuilder: (context, int index) {
          final Category category = categoryBloc.categories[index];

          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return CategoryDetailPage(category: category);
                  },
                ),
              );
            },
            child: Hero(
              tag: category.id,
              child: Card(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black,
                    image: DecorationImage(
                      colorFilter: ColorFilter.mode(
                        Colors.black.withOpacity(0.25),
                        BlendMode.dstATop,
                      ),
                      image: NetworkImage(
                        "$baseUrl/storage/${category.image}",
                      ),
                      fit: BoxFit.cover,
                      alignment: Alignment.topCenter,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        child: Text(
                          category.name,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24.0,
                            fontFamily: "TitilliumWeb-SemiBold",
                          ),
                        ),
                      ),
                      Container(margin: EdgeInsets.only(top: 20.0)),
                      Container(
                        child: Text(
                          "${category.chapters.length} Chapters".toUpperCase(),
                          style: TextStyle(
                            color: Colors.yellow,
                            fontSize: 18.0,
                            fontFamily: "TitilliumWeb-SemiBold",
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
