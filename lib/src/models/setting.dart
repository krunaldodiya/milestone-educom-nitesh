import 'package:meta/meta.dart';

@immutable
class Setting {
  final String title;
  final String description;
  final String logo;
  final String videoUrl;
  final String subscriptionExpireUrl;
  final String noSubscriptionUrl;
  final String trialDays;
  final String youtubeChannel;
  final String facebookPage;
  final String watermarkColor;
  final String watermarkSize;

  Setting({
    this.title,
    this.description,
    this.logo,
    this.videoUrl,
    this.subscriptionExpireUrl,
    this.noSubscriptionUrl,
    this.trialDays,
    this.youtubeChannel,
    this.facebookPage,
    this.watermarkColor,
    this.watermarkSize,
  });

  Setting copyWith(Map<String, dynamic> json) {
    return Setting(
      title: json["title"] ?? this.title,
      description: json["description"] ?? this.description,
      logo: json["logo"] ?? this.logo,
      videoUrl: json["video_url"] ?? this.videoUrl,
      subscriptionExpireUrl:
          json["expire_subscription_url"] ?? this.subscriptionExpireUrl,
      noSubscriptionUrl: json["no_subscription_url"] ?? this.noSubscriptionUrl,
      trialDays: json["trial_days"] ?? this.trialDays,
      youtubeChannel: json["youtube_channel"] ?? this.youtubeChannel,
      facebookPage: json["facebook_page"] ?? this.facebookPage,
      watermarkColor: json["watermark_color"] ?? this.watermarkColor,
      watermarkSize: json["watermark_size"] ?? this.watermarkSize,
    );
  }

  Setting.fromMap(Map<String, dynamic> json)
      : title = json != null ? json["title"] : null,
        description = json != null ? json["description"] : null,
        logo = json != null ? json["logo"] : null,
        videoUrl = json != null ? json["video_url"] : null,
        subscriptionExpireUrl =
            json != null ? json["expire_subscription_url"] : null,
        noSubscriptionUrl = json != null ? json["no_subscription_url"] : null,
        trialDays = json != null ? json["trial_days"] : null,
        youtubeChannel = json != null ? json["youtube_channel"] : null,
        facebookPage = json != null ? json["facebook"] : null,
        watermarkColor = json != null ? json["watermark_color"] : null,
        watermarkSize = json != null ? json["watermark_size"] : null;

  static fromList(List settings) {
    List<Setting> list = List<Setting>();

    for (Map setting in settings) {
      list.add(Setting.fromMap(setting));
    }

    return list;
  }
}
