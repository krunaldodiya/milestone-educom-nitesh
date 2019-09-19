import 'package:milestone_educom/src/helpers/vars.dart';
import 'package:milestone_educom/src/models/chapter.dart';
import 'package:flutter/material.dart';

getChapterList(Chapter chapter, Function onTap) {
  return Card(
    elevation: 1.0,
    margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 3.0),
    child: GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: ListTile(
          isThreeLine: false,
          leading: ClipOval(
            child: Image.network(
              "$baseUrl/storage/${chapter.image}",
              width: 50,
              height: 50,
              fit: BoxFit.cover,
              alignment: Alignment.center,
            ),
          ),
          title: Container(
            margin: EdgeInsets.only(bottom: 5.0),
            child: Text(
              chapter.name,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.blue,
                fontSize: 16.0,
                fontFamily: "TitilliumWeb-Regular",
              ),
            ),
          ),
          subtitle: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: 175.0,
                  child: Text(
                    chapter.description,
                    maxLines: 2,
                    softWrap: true,
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      color: Colors.black,
                      fontSize: 14.0,
                      fontFamily: "TitilliumWeb-Regular",
                    ),
                  ),
                ),
              ],
            ),
          ),
          trailing: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  chapter.topics.length.toString(),
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    color: Colors.black,
                    fontSize: 22.0,
                    fontFamily: "TitilliumWeb-SemiBold",
                  ),
                ),
                Text(
                  "Topics",
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    color: Colors.black,
                    fontSize: 12.0,
                    fontFamily: "TitilliumWeb-Regular",
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
