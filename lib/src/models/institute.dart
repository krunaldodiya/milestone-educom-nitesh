import 'package:meta/meta.dart';

@immutable
class Institute {
  final int id;
  final String name;

  Institute({
    this.id,
    this.name,
  });

  Institute copyWith(Map<String, dynamic> json) {
    return Institute(
      id: json["id"] ?? this.id,
      name: json["name"] ?? this.name,
    );
  }

  Institute.fromMap(Map<String, dynamic> json)
      : id = json != null ? json["id"] : null,
        name = json != null ? json["name"] : null;
}
