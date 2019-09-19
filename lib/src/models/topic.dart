import 'package:milestone_educom/src/models/video.dart';
import 'package:meta/meta.dart';

@immutable
class Topic {
  final int id;
  final int categoryId;
  final String name;
  final String description;
  final String image;
  final List<Video> videos;

  Topic({
    this.id,
    this.categoryId,
    this.name,
    this.description,
    this.image,
    this.videos,
  });

  Topic copyWith(Map<String, dynamic> json) {
    return Topic(
      id: json["id"] ?? this.id,
      categoryId: json["category_id"] ?? this.categoryId,
      name: json["name"] ?? this.name,
      description: json["description"] ?? this.description,
      image: json["image"] ?? this.image,
      videos: json["videos"] ?? this.videos,
    );
  }

  Topic.fromMap(Map<String, dynamic> json)
      : id = json != null ? json["id"] : null,
        categoryId = json != null ? json["category_id"] : null,
        name = json != null ? json["name"] : null,
        description = json != null ? json["description"] : null,
        image = json != null ? json["image"] : null,
        videos = json["videos"] is Video
            ? json["videos"]
            : Video.fromList(json["videos"]);

  static fromList(List chapters) {
    List<Topic> list = List<Topic>();

    for (Map chapter in chapters) {
      list.add(Topic.fromMap(chapter));
    }

    return list;
  }
}
