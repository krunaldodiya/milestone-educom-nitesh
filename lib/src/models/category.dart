import 'package:milestone_educom/src/models/chapter.dart';
import 'package:meta/meta.dart';

@immutable
class Category {
  final int id;
  final String name;
  final String image;
  final List<Chapter> chapters;

  Category({
    this.id,
    this.name,
    this.image,
    this.chapters,
  });

  Category copyWith(Map<String, dynamic> json) {
    return Category(
      id: json["id"] ?? this.id,
      name: json["name"] ?? this.name,
      image: json["image"] ?? this.image,
      chapters: json["chapters"] ?? this.chapters,
    );
  }

  Category.fromMap(Map<String, dynamic> json)
      : id = json != null ? json["id"] : null,
        name = json != null ? json["name"] : null,
        image = json != null ? json["image"] : null,
        chapters = json["chapters"] is Chapter
            ? json["chapters"]
            : Chapter.fromList(json["chapters"]);

  static fromList(List categories) {
    List<Category> list = List<Category>();

    for (Map category in categories) {
      list.add(Category.fromMap(category));
    }

    return list;
  }
}
