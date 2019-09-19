import 'package:flutter/foundation.dart' show kReleaseMode;

String appName = "Milestone Educom";

String appId =
    "https://play.google.com/store/apps/details?id=com.milestone.org";

String mPlayerId =
    "https://play.google.com/store/apps/details?id=player.milestoneeducom.com";

String shareText =
    "$appName app is helping me learning Maths. You might like it too! Download app at: $appId";

String webUrl = "https://www.milestoneeducom.com";

String baseUrl = kReleaseMode
    ? "https://api.milestoneducation.com"
    : "https://api.milestoneducation.com";
