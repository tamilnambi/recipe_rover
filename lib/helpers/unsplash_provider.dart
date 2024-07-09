import 'dart:convert';

import 'package:flutter/material.dart';

import '../utils/constant.dart';
import '../utils/enums.dart';
import 'package:http/http.dart' as http;

class UnsplashProvider with ChangeNotifier{

  AuthState state = AuthState.loading;
  String? _headerImageUrl;

  Future<void> fetchHeaderImage(String text) async{
    try {
      final response = await http.get(Uri.parse('$unsplashUrl/photos/random?query=$text&client_id=$unsplashAccessKey'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        _headerImageUrl = data['urls']['regular'];
        print('Header Image URL: $_headerImageUrl');
        state = AuthState.success;
      }
      else {
        print('Failed to fetch recipes');
        state = AuthState.failed;
      }
    }
    catch(e){
      print('error occurred + $e');
      state = AuthState.failed;
    }
    notifyListeners();
  }

  String? get headerImageUrl => _headerImageUrl;
  AuthState get authState => state;

  void clearData(){
    _headerImageUrl = null;
    state = AuthState.loading;
    notifyListeners();
  }
}