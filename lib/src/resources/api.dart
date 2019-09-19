import 'dart:async';

import 'package:milestone_educom/src/helpers/vars.dart';
import 'package:milestone_educom/src/resources/client.dart';
import 'package:dio/dio.dart';

class ApiProvider {
  Future getAuthUser() async {
    return sendRequest(Api.me);
  }

  Future createSubscription(int categoryId) async {
    return sendRequest(Api.createSubscription, {
      "category_id": categoryId,
    });
  }

  Future getCategories() async {
    return sendRequest(Api.getCategories, {});
  }

  Future requestOtp(String mobile) async {
    return sendRequest(Api.requestOtp, {
      "mobile": mobile,
    });
  }

  Future verifyOtp(String imei, String mobile, int otp) async {
    return sendRequest(Api.verifyOtp, {
      "imei": imei,
      "mobile": mobile,
      "otp": otp,
    });
  }

  Future updateProfile(Map data) async {
    return sendRequest(Api.updateProfile, data);
  }

  Future sendFeedback(Map data) async {
    return sendRequest(Api.sendFeedback, data);
  }

  Future getSchools() async {
    return sendRequest(Api.getSchools);
  }

  Future uploadAvatar(FormData image) async {
    return sendRequest(Api.uploadAvatar, image);
  }

  Future notifyError(error) async {
    return sendRequest(Api.notifyError, {
      "error": error,
    });
  }
}

class Api {
  static String me = "$baseUrl/api/users/me";
  static String createSubscription = "$baseUrl/api/subscriptions/create";
  static String getCategories = "$baseUrl/api/categories/all";
  static String requestOtp = "$baseUrl/api/otp/request-otp";
  static String verifyOtp = "$baseUrl/api/otp/verify-otp";
  static String getSchools = "$baseUrl/api/home/schools";
  static String sendFeedback = "$baseUrl/api/home/feedback";
  static String updateProfile = "$baseUrl/api/users/update";
  static String uploadAvatar = "$baseUrl/api/users/avatar/upload";
  static String notifyError = "$baseUrl/api/error/notify";
}
