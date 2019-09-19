import 'package:milestone_educom/src/helpers/vars.dart';
import 'package:milestone_educom/src/models/topic.dart';
import 'package:flutter/material.dart';

getTopicList(Topic topic, Function onTap) {
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
              "$baseUrl/storage/${topic.image}",
              width: 50,
              height: 50,
              fit: BoxFit.cover,
              alignment: Alignment.center,
            ),
          ),
          title: Container(
            margin: EdgeInsets.only(bottom: 5.0),
            child: Text(
              topic.name,
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
                    topic.description,
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
              children: <Widget>[
                Text(
                  topic.videos.length.toString(),
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    color: Colors.black,
                    fontSize: 22.0,
                    fontFamily: "TitilliumWeb-SemiBold",
                  ),
                ),
                Text(
                  "Videos",
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
