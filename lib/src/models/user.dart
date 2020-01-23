import 'package:milestone_educom/src/models/institute.dart';
import 'package:milestone_educom/src/models/setting.dart';
import 'package:milestone_educom/src/models/subscription.dart';
import 'package:meta/meta.dart';

@immutable
class User {
  final int id;
  final String name;
  final String email;
  final String avatar;
  final String mobile;
  final String dob;
  final String gender;
  final String school;
  final String education;
  final String imei;
  final int status;
  final List<Subscription> subscriptions;
  final Setting setting;
  final Institute institute;

  User({
    this.id,
    this.name,
    this.email,
    this.avatar,
    this.mobile,
    this.dob,
    this.gender,
    this.school,
    this.education,
    this.imei,
    this.status,
    this.subscriptions,
    this.setting,
    this.institute,
  });

  User copyWith(Map<String, dynamic> json) {
    return User(
      id: json["id"] ?? this.id,
      name: json["name"] ?? this.name,
      email: json["email"] ?? this.email,
      avatar: json["avatar"] ?? this.avatar,
      mobile: json["mobile"] ?? this.mobile,
      dob: json["dob"] ?? this.dob,
      gender: json["gender"] ?? this.gender,
      school: json["school"] ?? this.school,
      education: json["education"] ?? this.education,
      imei: json["imei"] ?? this.imei,
      status: json["status"] ?? this.status,
      subscriptions: json["subscriptions"] ?? this.subscriptions,
      setting: json["site_settings"] ?? this.setting,
      institute: json["institute"] ?? this.institute,
    );
  }

  User.fromMap(Map<String, dynamic> json)
      : id = json["id"],
        name = json["name"],
        email = json["email"],
        avatar = json["avatar"],
        mobile = json["mobile"],
        dob = json["dob"],
        gender = json["gender"],
        school = json["school"],
        education = json["education"],
        imei = json["imei"],
        subscriptions = json["subscriptions"] is Subscription
            ? json["subscriptions"]
            : Subscription.fromList(json["subscriptions"]),
        status = json["status"],
        setting = json["site_settings"] is Setting
            ? json["site_settings"]
            : Setting.fromMap(json["site_settings"]),
        institute = json["institute"] is Institute
            ? json["institute"]
            : Institute.fromMap(json["institute"]);

  static fromList(List users) {
    List<User> list = List<User>();

    for (Map user in users) {
      list.add(User.fromMap(user));
    }

    return list;
  }
}
