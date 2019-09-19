import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:milestone_educom/src/models/school.dart';
import 'package:milestone_educom/src/resources/api.dart';

class SchoolBloc extends ChangeNotifier {
  final ApiProvider _apiProvider = ApiProvider();

  bool loading;
  bool loaded;
  Map error;
  List<School> schools = [];

  setState({
    bool loading,
    bool loaded,
    Map error: const {},
    List<School> schools,
  }) {
    this.loading = loading ?? this.loading;
    this.loaded = loaded ?? this.loaded;
    this.error = identical(error, {}) ? this.error : error;
    this.schools = schools ?? this.schools;

    notifyListeners();
  }

  getSchools() async {
    setState(loading: true, loaded: false);

    try {
      final Response response = await _apiProvider.getSchools();
      final results = response.data;

      setState(
        schools: School.fromList(results['schools']),
        loading: false,
        loaded: true,
      );
    } catch (error) {
      setState(error: error.response.data, loading: false, loaded: true);
    }
  }
}
