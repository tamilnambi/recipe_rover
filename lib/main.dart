import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_rover/helpers/api_helper.dart';
import 'package:recipe_rover/helpers/unsplash_provider.dart';
import 'package:recipe_rover/pages/home_page.dart';
import 'dart:convert';

import 'package:recipe_rover/recipe.dart';
import 'package:recipe_rover/utils/constant.dart';

void main() {
  runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => ApiHelper()),
          ChangeNotifierProvider(create: (_) => UnsplashProvider()),
        ],
        child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Recipe Rover',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.yellow),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key});
//
//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//
//   final TextEditingController _ingredientController = TextEditingController();
//   List<Map<String, dynamic>> recipes = [];
//   bool isLoading = false; // Added loading indicator state
//
//   Future<void> _searchRecipes(String ingredient) async {
//
//     try {
//       setState(() {
//         isLoading = true; // show loading indicator
//       });
//       final response = await http.get(
//           Uri.parse('$endpoint?q=$ingredient&app_id=$appId&app_key=$appKey'));
//       if (response.statusCode == 200) {
//         final data = json.decode(response.body);
//         if (data['hits'] != null) {
//           final hits = data['hits'];
//           final recipeData = hits.map<Map<String, dynamic>>((hit) {
//             final recipe = hit['recipe'];
//             return {
//               'label': recipe['label'],
//               'image': recipe['image'],
//               'uri': recipe['uri'],
//             };
//           }).toList();
//
//           setState(() {
//             recipes = recipeData;
//           });
//         }
//       } else {
//         print('Failed to fetch recipes');
//       }
//     }
//     catch (e) {
//       print('error occurred + $e');
//     } finally {
//       setState(() {
//         isLoading = false; //hide loading indicator
//       });
//     }
//   }
//
//     @override
//     Widget build(BuildContext context) {
//       return Scaffold(
//         body: Center(
//           child: Column(
//             children: <Widget>[
//               const SizedBox(
//                 height: 50.0,
//               ),
//               Padding(padding: const EdgeInsets.all(20.0),
//                 child: TextField(
//                   controller: _ingredientController,
//                   decoration: const InputDecoration(
//                       labelText: 'Enter your ingredient'),
//                 ),),
//               const SizedBox(
//                 height: 10.0,
//               ),
//               ElevatedButton(onPressed: () {
//                 _searchRecipes(_ingredientController.text);
//               },
//                   child: const Text("Search for Recipes")),
//               if (isLoading)
//                 const CircularProgressIndicator() // Show loading indicator while fetching data
//               else
//                 if (recipes.isNotEmpty)
//                   Expanded(
//                       child: ListView.builder(
//                           itemCount: recipes.length,
//                           itemBuilder: (context, index) {
//                             final recipe = recipes[index];
//                             return ListTile(
//                               title: Text(recipe['label']),
//                               subtitle: Image.network(recipe['image']),
//                               onTap: () {
//                                 Navigator.push(context,
//                                     MaterialPageRoute(builder: (context)=> RecipeDetails(uri : recipe['uri'])));
//                               },
//                             );
//                           })),
//             ],
//           ),
//         ),
//       );
//     }
//   }
//
