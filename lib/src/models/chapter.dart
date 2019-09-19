import 'package:milestone_educom/src/models/topic.dart';
import 'package:meta/meta.dart';

@immutable
class Chapter {
  final int id;
  final String name;
  final String description;
  final String image;
  final List<Topic> topics;

  Chapter({this.id, this.name, this.description, this.image, this.topics});

  Chapter copyWith(Map<String, dynamic> json) {
    return Chapter(
      id: json["id"] ?? this.id,
      name: json["name"] ?? this.name,
      description: json["description"] ?? this.description,
      image: json["image"] ?? this.image,
      topics: json["topics"] ?? this.topics,
    );
  }

  Chapter.fromMap(Map<String, dynamic> json)
      : id = json != null ? json["id"] : null,
        name = json != null ? json["name"] : null,
        description = json != null ? json["description"] : null,
        image = json != null ? json["image"] : null,
        topics = json["topics"] is Topic
            ? json["topics"]
            : Topic.fromList(json["topics"]);

  static fromList(List chapters) {
    List<Chapter> list = List<Chapter>();

    for (Map chapter in chapters) {
      list.add(Chapter.fromMap(chapter));
    }

    return list;
  }
}
