import 'package:milestone_educom/src/atp/default.dart';
import 'package:milestone_educom/src/helpers/vars.dart';
import 'package:milestone_educom/src/models/chapter.dart';
import 'package:milestone_educom/src/providers/theme.dart';
import 'package:milestone_educom/src/screens/topic_detail.dart';
import 'package:milestone_educom/src/screens/topic_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChapterDetailPage extends StatefulWidget {
  final Chapter chapter;

  const ChapterDetailPage({
    Key key,
    @required this.chapter,
  }) : super(key: key);

  @override
  _ChapterDetailPage createState() => _ChapterDetailPage();
}

class _ChapterDetailPage extends State<ChapterDetailPage> {
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
              title: Text(widget.chapter.name),
              flexibleSpace: FlexibleSpaceBar(
                background: Hero(
                  tag: widget.chapter.id,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black,
                      image: DecorationImage(
                        colorFilter: ColorFilter.mode(
                          Colors.black.withOpacity(0.5),
                          BlendMode.dstATop,
                        ),
                        image: NetworkImage(
                          "$baseUrl/storage/${widget.chapter.image}",
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

    data.add(addLabel());

    if (widget.chapter.topics.length == 0) {
      data.add(noChapters());
    } else {
      for (var topic in widget.chapter.topics) {
        data.add(
          getTopicList(topic, () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return TopicDetailPage(topic: topic);
            }));
          }),
        );
      }
    }

    return data;
  }

  Container addLabel() {
    return Container(
      margin: EdgeInsets.only(left: 10.0, top: 15.0, bottom: 15.0),
      child: Text(
        "Topics".toUpperCase(),
        style: TextStyle(
          color: Colors.white,
          fontSize: 18.0,
          fontWeight: FontWeight.normal,
          fontFamily: "TitilliumWeb-SemiBold",
        ),
      ),
    );
  }

  Container noChapters() {
    return Container(
      margin: EdgeInsets.only(left: 10.0),
      child: Text(
        "No topics added yet.",
        style: TextStyle(
          color: Colors.white,
          fontSize: 18.0,
          fontWeight: FontWeight.normal,
          fontFamily: "TitilliumWeb-Regular",
        ),
      ),
    );
  }
}
