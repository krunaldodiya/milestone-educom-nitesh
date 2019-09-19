import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:milestone_educom/src/models/user.dart';
import 'package:milestone_educom/src/resources/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserBloc extends ChangeNotifier {
  final ApiProvider _apiProvider = ApiProvider();

  bool loading;
  bool loaded;
  Map error;
  User user;
  String imei;

  setState({
    bool loading,
    bool loaded,
    Map error: const {},
    User user,
    String imei,
  }) {
    this.loading = loading ?? this.loading;
    this.loaded = loaded ?? this.loaded;
    this.error = identical(error, {}) ? this.error : error;
    this.user = user ?? this.user;
    this.imei = imei ?? this.imei;

    notifyListeners();
  }

  setImei(String imei) {
    setState(imei: imei);
  }

  onChangeData(String key, dynamic value, User userData) {
    setState(
      user: userData.copyWith({key: value == "" ? null : value}),
      error: null,
    );
  }

  sendFeedback(String feedback, User user) async {
    setState(loading: true, loaded: false);

    try {
      final Response response = await _apiProvider.sendFeedback({
        "feedback": feedback,
        "user_id": user.id,
      });

      setState(error: null, loading: false, loaded: true);
      return response.data['message'];
    } catch (error) {
      setState(error: error.response.data, loading: false, loaded: true);
    }
  }

  createProfile(User user) async {
    setState(loading: true, loaded: false);

    try {
      final Response response = await _apiProvider.updateProfile({
        "id": user.id,
        "name": user.name,
        "email": user.email,
        "dob": user.dob,
        "gender": user.gender,
        "school": user.school,
        "education": user.education,
      });

      final results = response.data;

      setAuthUser(results['user']);
    } catch (error) {
      setState(error: error.response.data, loading: false, loaded: true);
    }
  }

  updateProfile(User user) async {
    setState(loading: true, loaded: false);

    try {
      final Response response = await _apiProvider.updateProfile({
        "id": user.id,
        "name": user.name,
        "dob": user.dob,
        "gender": user.gender,
        "school": user.school,
        "education": user.education,
      });

      final results = response.data;

      setAuthUser(results['user']);
    } catch (error) {
      setState(error: error.response.data, loading: false, loaded: true);
    }
  }

  createSubscription(int categoryId) async {
    setState(loading: true, loaded: false);

    try {
      final Response response =
          await _apiProvider.createSubscription(categoryId);
      final results = response.data;

      await setAuthUser(results['user']);
    } catch (error) {
      setState(loading: false, loaded: true);
    }
  }

  getAuthUser() async {
    try {
      final Response response = await _apiProvider.getAuthUser();
      final results = response.data;

      await setAuthUser(results['user']);
    } catch (error) {
      print(error);
      setState(loading: false, loaded: true);
    }
  }

  setAuthToken(String token) async {
    if (token != null) {
      SharedPreferences pref = await SharedPreferences.getInstance();
      pref.setString("authToken", token);
    }
  }

  setAuthUser(Map userData) {
    setState(
      user: User.fromMap(userData),
      error: null,
      loading: false,
      loaded: true,
    );
  }

  removeAuth() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.remove("authToken");
    prefs.remove("defaultTheme");
    prefs.remove("contacts");

    setState(
      user: null,
      error: null,
      loading: false,
      loaded: true,
    );
  }
}
