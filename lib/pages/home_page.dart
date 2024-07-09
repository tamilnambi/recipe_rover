import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:recipe_rover/widgets/image_card.dart';
import 'package:recipe_rover/widgets/search_field.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Stack(
                    children: [
                      Image.asset(
                        'assets/header_image.png',
                        height: size.height * 0.3,
                        width: size.width,
                        fit: BoxFit.cover,
                      ),
                      Positioned(
                        left: 20.0,
                        top: 35.0,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Find Your Next',
                              style: GoogleFonts.caveat(
                                  fontSize: 40.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            Text(
                              'Meal!',
                              style: GoogleFonts.caveat(
                                  fontSize: 40.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            Text(
                              'One cannot think well, love well, sleep well, \nif one has not dined well.\nVirginia Woolf',
                              style: GoogleFonts.roboto(
                                  fontSize: 15.0, color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: SearchField()),
                  const SizedBox(
                    height: 20.0,
                  ),
                   Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Most Searched Recipes',
                        style: GoogleFonts.roboto(
                            fontSize: 20.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const Padding(padding: EdgeInsets.all(10.0),
                    child: Wrap(
                      spacing: 20.0,
                      runSpacing: 20.0,
                      children:[
                        ImageCard(
                          imageUrl: 'assets/chicken.jpg',
                          title: 'Chicken',
                        ),
                        ImageCard(
                          imageUrl: 'assets/garlic.jpg',
                          title: 'Garlic',
                        ),
                        ImageCard(
                          imageUrl: 'assets/tomatoes.jpg',
                          title: 'Tomatoes',
                        ),
                        ImageCard(
                          imageUrl: 'assets/pasta.jpg',
                          title: 'Pasta',
                        ),
                        ImageCard(
                          imageUrl: 'assets/cheese.jpg',
                          title: 'Cheese',
                        ),
                        ImageCard(
                          imageUrl: 'assets/salmon.jpg',
                          title: 'Salmon',
                        ),
                        ImageCard(
                          imageUrl: 'assets/potatoes.jpg',
                          title: 'Potatoes',
                        ),
                        ImageCard(
                          imageUrl: 'assets/rice.jpg',
                          title: 'Rice',
                        ),
                        ImageCard(
                          imageUrl: 'assets/chocolate.jpg',
                          title: 'Chocolate',
                        ),
                      ]
                    ),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
