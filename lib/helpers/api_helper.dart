import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:recipe_rover/utils/enums.dart';
import 'package:http/http.dart' as http;

import '../utils/constant.dart';

class ApiHelper with ChangeNotifier{

  AuthState state = AuthState.loading;
  List<Map<String, dynamic>> _recipes = [];

  Future<void> fetchRecipes(String ingredient) async {
    try {
      final response = await http.get(Uri.parse('$endpoint?q=$ingredient&app_id=$appId&app_key=$appKey'));
            if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['hits'] != null) {
          final hits = data['hits'];
          final recipeData = hits.map<Map<String, dynamic>>((hit) {
            final recipe = hit['recipe'];
            return {
              'label': recipe['label'],
              'image': recipe['image'],
              'uri': recipe['url'],
            };
          }).toList();
          _recipes = recipeData;
          state = AuthState.success;
        }
      } else {
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

  void clearData(){
    _recipes = [];
    state = AuthState.loading;
    notifyListeners();
  }

  List<Map<String, dynamic>> get recipes => _recipes;
  AuthState get authState => state;

}