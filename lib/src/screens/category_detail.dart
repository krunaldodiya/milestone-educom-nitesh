import 'package:milestone_educom/src/atp/default.dart';
import 'package:milestone_educom/src/helpers/vars.dart';
import 'package:milestone_educom/src/models/category.dart';
import 'package:milestone_educom/src/models/subscription.dart';
import 'package:milestone_educom/src/providers/theme.dart';
import 'package:milestone_educom/src/providers/user.dart';
import 'package:milestone_educom/src/screens/chapter_detail.dart';
import 'package:milestone_educom/src/screens/chapter_list.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:xs_progress_hud/xs_progress_hud.dart';

class CategoryDetailPage extends StatefulWidget {
  final Category category;

  const CategoryDetailPage({
    Key key,
    @required this.category,
  }) : super(key: key);

  @override
  _CategoryDetailPage createState() => _CategoryDetailPage();
}

class _CategoryDetailPage extends State<CategoryDetailPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeBloc themeBloc = Provider.of<ThemeBloc>(context);
    final DefaultTheme theme = themeBloc.theme;

    return Scaffold(
      backgroundColor: theme.home.appBackgroundColor,
      body: SafeArea(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              floating: true,
              pinned: true,
              expandedHeight: 240.0,
              backgroundColor: theme.home.appBackgroundColor,
              title: Text(widget.category.name),
              flexibleSpace: FlexibleSpaceBar(
                background: Hero(
                  tag: widget.category.id,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black,
                      image: DecorationImage(
                        colorFilter: ColorFilter.mode(
                          Colors.black.withOpacity(0.5),
                          BlendMode.dstATop,
                        ),
                        image: NetworkImage(
                          "$baseUrl/storage/${widget.category.image}",
                        ),
                        fit: BoxFit.cover,
                        alignment: Alignment.topCenter,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate(getTopics()),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> getTopics() {
    List<Widget> data = [];

    data.add(addSubscription());

    data.add(addLabel());

    if (widget.category.chapters.length == 0) {
      data.add(noChapters());
    } else {
      for (var chapter in widget.category.chapters) {
        data.add(
          getChapterList(chapter, () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return ChapterDetailPage(chapter: chapter);
            }));
          }),
        );
      }
    }

    return data;
  }

  Widget addLabel() {
    return Container(
      margin: EdgeInsets.only(left: 10.0, top: 15.0, bottom: 15.0),
      child: Text(
        "Chapters".toUpperCase(),
        style: TextStyle(
          color: Colors.white,
          fontSize: 18.0,
          fontWeight: FontWeight.normal,
          fontFamily: "TitilliumWeb-SemiBold",
        ),
      ),
    );
  }

  Widget noChapters() {
    return Container(
      margin: EdgeInsets.only(left: 10.0),
      child: Text(
        "No chapters added yet.",
        style: TextStyle(
          color: Colors.white,
          fontSize: 18.0,
          fontWeight: FontWeight.normal,
          fontFamily: "TitilliumWeb-Regular",
        ),
      ),
    );
  }

  Widget addSubscription() {
    final UserBloc userBloc = Provider.of<UserBloc>(context);

    List data = userBloc.user.subscriptions
        .where((subscription) => subscription.categoryId == widget.category.id)
        .toList();

    Subscription subscription = data.isNotEmpty ? data.first : null;

    return Container(
      color: Colors.grey.shade200,
      padding: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(left: 10.0),
                child: Text(
                  "Subscription",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18.0,
                    fontWeight: FontWeight.normal,
                    fontFamily: "TitilliumWeb-SemiBold",
                  ),
                ),
              ),
              Expanded(child: Container()),
              Container(
                margin: EdgeInsets.only(right: 10.0),
                child: subscription == null
                    ? RaisedButton(
                        padding: EdgeInsets.symmetric(
                          vertical: 0.0,
                          horizontal: 10.0,
                        ),
                        color: Colors.red,
                        child: Text(
                          "subscribe".toUpperCase(),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12.0,
                          ),
                        ),
                        onPressed: () {
                          createSubscription(userBloc, widget.category.id);
                        },
                      )
                    : Container(
                        margin: EdgeInsets.only(right: 10.0, bottom: 10.0),
                        child: Text(
                          subscription.status,
                          style: TextStyle(
                            color: subscription.status == 'Active'
                                ? Colors.green
                                : Colors.red,
                            fontSize: 18.0,
                            fontWeight: FontWeight.normal,
                            fontFamily: "TitilliumWeb-SemiBold",
                          ),
                        ),
                      ),
              ),
            ],
          ),
          if (subscription != null)
            Row(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(left: 10.0),
                  child: Text(
                    "Expiry Date",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18.0,
                      fontWeight: FontWeight.normal,
                      fontFamily: "TitilliumWeb-SemiBold",
                    ),
                  ),
                ),
                Expanded(child: Container()),
                Container(
                  margin: EdgeInsets.only(right: 10.0),
                  child: Text(
                    DateFormat("dd-MM-yyyy").format(subscription.expiresAt),
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }

  createSubscription(UserBloc userBloc, int categoryId) async {
    XsProgressHud.show(context);
    await userBloc.createSubscription(categoryId);
    XsProgressHud.hide();
  }
}
