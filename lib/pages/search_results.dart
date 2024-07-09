import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:recipe_rover/helpers/api_helper.dart';
import 'package:recipe_rover/helpers/unsplash_provider.dart';
import 'package:recipe_rover/utils/enums.dart';
import 'package:recipe_rover/widgets/search_result_card.dart';

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

  @override
  dispose() {
    super.dispose();
    clearResults();
  }

  Future<void> getResults() async {
    final apiHelper = Provider.of<ApiHelper>(context, listen: false);
    final unsplashProvider =
        Provider.of<UnsplashProvider>(context, listen: false);
    await apiHelper.fetchRecipes(widget.ingredient);
    await unsplashProvider.fetchHeaderImage(widget.ingredient);
  }

  void clearResults() {
    final apiHelper = Provider.of<ApiHelper>(context, listen: false);
    apiHelper.clearData();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: Container(
      color: Colors.white,
      child: SafeArea(
        child: Consumer<ApiHelper>(
          builder: (context, apiHelper, child) {
            if (apiHelper.state == AuthState.loading) {
              return Center(
                  child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Lottie.asset('assets/loading.json')));
            }
            if (apiHelper.state == AuthState.success) {
              if(apiHelper.recipes.isEmpty){
                return Center(child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Lottie.asset('assets/error.json', width: 200, height: 100),
                    const Text('Sorry! No recipes found!!',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold
                    ),),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                        ),
                        onPressed: (){
                      apiHelper.clearData();
                      Navigator.pop(context);
                    }, child: const Text('Go Back',
                    style: TextStyle(
                      color: Colors.white
                    ),
                    )),
                  ],
                ));
              }
              return SingleChildScrollView(
                child: Wrap(spacing: 20.0, runSpacing: 20.0, children: [
                  Consumer<UnsplashProvider>(
                    builder: (context, provider, child) {
                      if (provider.state == AuthState.loading) {
                        return Center(
                            child: Lottie.asset('assets/cooking.json',
                                width: 200, height: 100));
                      }
                      if (provider.state == AuthState.success) {
                        return Stack(
                          children: [
                            Image.network(
                              provider.headerImageUrl!,
                              height: size.height * 0.3,
                              width: size.width,
                              fit: BoxFit.cover,
                              loadingBuilder: (BuildContext context,
                                  Widget child,
                                  ImageChunkEvent? loadingProgress) {
                                if (loadingProgress == null) {
                                  //_loading = false; // Image loaded
                                  return child;
                                } else {
                                  //_loading = true; // Image still loading
                                  return Center(
                                    child: Lottie.asset('assets/cooking.json',
                                        width: 200,
                                        height: 100), // Loading indicator
                                  );
                                }
                              },
                            ),
                            Positioned(
                              top: 10.0,
                              left: 10.0,
                              child: IconButton(
                                icon: const Icon(
                                  Icons.arrow_back_ios,
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  provider.clearData();
                                  apiHelper.clearData();
                                  Navigator.pop(context);
                                },
                              ),
                            ),
                            Positioned(
                              bottom: 20.0,
                              left: 20.0,
                              child: Text(
                                widget.ingredient,
                                style: GoogleFonts.caveat(
                                    fontSize: 40.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            )
                          ],
                        );
                      }
                      return const SizedBox();
                    },
                  ),
                  GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.7,
                    ),
                    itemCount: apiHelper.recipes.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final recipe = apiHelper.recipes[index];
                      return SearchResultCard(
                        title: recipe['label'],
                        imageUrl: recipe['image'],
                        recipeUrl: recipe['uri'],
                        //onTap: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => RecipeDetails(
                        //       uri: recipe['uri'],
                        //     ),
                        //   ),
                        // );
                        //},
                      );
                    },
                  ),
                ]),
              );
            }
            return const Center(child: Text('Failed to fetch recipes'));
          },
        ),
      ),
    ));
  }
}
