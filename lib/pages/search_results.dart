import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_rover/helpers/api_helper.dart';
import 'package:recipe_rover/utils/enums.dart';

class SearchResults extends StatefulWidget {
  final String ingredient;
  const SearchResults({super.key, required this.ingredient});

  @override
  State<SearchResults> createState() => _SearchResultsState();
}

class _SearchResultsState extends State<SearchResults> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getResults();
  }

  Future<void> getResults() async {
    await ApiHelper().fetchRecipes(widget.ingredient);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Consumer<ApiHelper>(
          builder: (context, apiHelper, child) {
            if (apiHelper.state == AuthState.loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView.builder(
              itemCount: apiHelper.recipes.length,
              itemBuilder: (context, index) {
                final recipe = apiHelper.recipes[index];
                return ListTile(
                  title: Text(recipe['label']),
                  subtitle: Text(recipe['source']),
                  leading: Image.network(recipe['image']),
                );
              },
            );
          },
        ),
      )
    );
  }
}
