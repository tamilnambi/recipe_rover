import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp( MyApp());
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

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  TextEditingController _ingredientController = TextEditingController();
  List<Map<String,dynamic>> recipes = [];

  Future<void> _searchRecipes(String ingredient) async{

    final appId = '1f05a08d';
    final appKey = 'a614fb15c7618687c8cd2382d7a980a9';
    final endpoint = 'https://api.edamam.com/search';

    print("fetching data");
    try{
      final response = await http.get(Uri.parse('$endpoint?q=$ingredient&app_id=$appId&app_key=$appKey'));
      print("data fetched");
      if(response.statusCode == 200){
        final data = json.decode(response.body);
        if(data['hits'] != null){
          final hits = data['hits'];
          final recipeData = hits.map<Map<String,dynamic>>((hit){
            final recipe = hit['recipe'];
            return {
              'label': recipe['label'],
              'image': recipe['image'],
              'url': recipe['url'],
              'ingredients': recipe['ingredientLines'],
            };
          }).toList();

          setState(() {
            recipes = recipeData;
          });
        }
      } else {
        print('Failed to fetch recipes');
      }
    }
    catch(e){
      print('error occured + $e');
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            const SizedBox(
              height: 50.0,
            ),
            Padding(padding: EdgeInsets.all(20.0),
            child: TextField(
              controller: _ingredientController,
              decoration: const InputDecoration(labelText: 'Enter your ingredient'),
            ),),
            const SizedBox(
              height: 10.0,
            ),
            ElevatedButton(onPressed: (){
              print("Button clicked");
              _searchRecipes(_ingredientController.text);
            },
                child: const Text("Search for Recipes")),
            Expanded(
                child: ListView.builder(
                    itemCount: recipes.length,
                    itemBuilder: (context,index){
                      final recipe = recipes[index];
                      return ListTile(
                        title: Text(recipe['label']),
                        subtitle: Image.network(recipe['image']),
                        onTap: (){},
                      );
                    })),
          ],
        ),
      ),
    );
  }
}
