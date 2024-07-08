import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
          child: Container(
            width: size.width,
        color: Colors.white,
        child:  Column(
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
                      Text('Find Your Next',
                          style: GoogleFonts.roboto(
                              fontSize: 30.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white
                          ),
                      ),
                      const SizedBox(height: 10.0,),
                      Text('Meal!',
                          style: GoogleFonts.roboto(
                              fontSize: 30.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white
                          ),
                      ),
                      const SizedBox(height: 10.0,),
                      Text('One cannot think well, love well, sleep well, \nif one has not dined well.\nVirginia Woolf',
                          style: GoogleFonts.roboto(
                              fontSize: 15.0,
                              color: Colors.white
                          ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      )),
    );
  }
}
