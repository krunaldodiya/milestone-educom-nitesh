import 'package:meta/meta.dart';

@immutable
class Subscription {
  final int id;
  final int categoryId;
  final DateTime expiresAt;
  final String status;

  Subscription({this.id, this.categoryId, this.expiresAt, this.status});

  Subscription copyWith(Map<String, dynamic> json) {
    return Subscription(
      id: json["id"] ?? this.id,
      categoryId: json["category_id"] ?? this.categoryId,
      expiresAt: json["expires_at"] ?? this.expiresAt,
      status: json["status"] ?? this.status,
    );
  }

  static fromMap(Map<String, dynamic> json) {
    return Subscription(
      id: json["id"] != null ? json["id"] : null,
      categoryId: json['category_id'] != null ? json["category_id"] : null,
      expiresAt: json['expires_at'] != null
          ? DateTime.parse(json["expires_at"])
          : null,
      status: json["status"] != null ? json["status"] : null,
    );
  }

  static fromList(List subscriptions) {
    List<Subscription> list = List<Subscription>();

    for (Map subscription in subscriptions) {
      list.add(Subscription.fromMap(subscription));
    }

    return list;
  }
}
