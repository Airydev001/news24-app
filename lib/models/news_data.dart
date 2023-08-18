import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

class NewsData with ChangeNotifier {
  Map<String, dynamic> _map = {};
  bool _error = false;
  String _errorMessage = "";
  //getters fuction for the declared variable
  Map<String, dynamic> get map => _map;
  bool get error => _error;
  String get errorMessage => _errorMessage;

  Future<void> get fetchData async {
    final response = await get(
      Uri.parse(
          "https://newsapi.org/v2/top-headlines?country=us&category=entertainment&apiKey=2b7039517b7b49f5bcda89677b7565b0"),
    );

    if (response.statusCode == 200) {
      try {
        _map = jsonDecode(response.body);
        _error = false; //deserialization
      } catch (e) {
        _error = true;
        _errorMessage = e.toString();
        _map = {};
      }
    } else {
      _error = true;
      _errorMessage = "It could be your internet collection?";
      _map = {};
    }
    notifyListeners(); // listen to any action from the application;
  }

  void initialValue() {
    _map = {};
    _error = false;
    _errorMessage = "";
    notifyListeners();
  }
}
