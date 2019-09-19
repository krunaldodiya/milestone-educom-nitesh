import 'package:milestone_educom/src/models/category.dart';
import 'package:milestone_educom/src/resources/api.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class CategoryBloc extends ChangeNotifier {
  final ApiProvider _apiProvider = ApiProvider();

  bool loading;
  bool loaded;
  Map error;
  List<Category> categories = [];

  setState({
    bool loading,
    bool loaded,
    Map error: const {},
    List<Category> categories,
  }) {
    this.loading = loading ?? this.loading;
    this.loaded = loaded ?? this.loaded;
    this.error = identical(error, {}) ? this.error : error;
    this.categories = categories ?? this.categories;

    notifyListeners();
  }

  getCategories() async {
    setState(loading: true, loaded: false);

    try {
      final Response response = await _apiProvider.getCategories();
      final results = response.data;

      setState(
        categories: Category.fromList(results['categories']),
        loading: false,
        loaded: true,
      );
    } catch (error) {
      setState(error: error.response.data, loading: false, loaded: true);
    }
  }
}
