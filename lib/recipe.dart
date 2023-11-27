import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:recipe_rover/constant.dart';


class RecipeDetails extends StatefulWidget {
  final uri;
  const RecipeDetails({super.key, required this.uri});

  @override
  State<RecipeDetails> createState() => _RecipeDetailsState();
}

class _RecipeDetailsState extends State<RecipeDetails> {

  bool isLoading = false;
  String title = '';
  String image = '';
  List<dynamic> ingredients = [];
  String url='';


  @override
  void initState(){
    super.initState();
    _getRecipe();
  }

  Future<void> _getRecipe() async {
    try{
      setState(() {
        isLoading = true;
      });
      //final response = await http.get(
      //    Uri.parse('$endpoint?r=${widget.uri}&app_id=$appId&app_key=$appKey'));
      final response = await http.get(
        Uri.https('api.edamam.com', '/search', {
          'r': widget.uri,
          'app_id': appId,
          'app_key': appKey,
        }),
      );
      if (response.statusCode == 200){
        final data = json.decode(response.body);
        final recipe = data[0];
        title = recipe['label'];
        image = recipe['image'];
        recipe['ingredientLines'].forEach((item){
          ingredients.add(item);
        });

      }
    }
    catch(e){
      print('error occurred + $e');
    }
    finally{
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
        body: Column(
          children: [

            if(isLoading)
              Center(child: CircularProgressIndicator())
            else
              Expanded(
                child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(title,style: const TextStyle(fontSize: 40,fontWeight: FontWeight.bold,),),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.network(image),
                        ),
                        const Text('Ingredients',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),),
                        ListView.builder(
                          shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: ingredients.length,
                            itemBuilder: (context,index){
                              return ListTile(
                                title: Text(ingredients[index]),
                              );
                            }),
                      ],
                    )),
              )
          ],
        ),
    ));
  }
}


