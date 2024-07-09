import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import '../detailed_recipe.dart';

class SearchResultCard extends StatefulWidget {
  final String imageUrl;
  final String title;
  final String recipeUrl;

  const SearchResultCard({
    Key? key,
    required this.imageUrl,
    required this.title,
    required this.recipeUrl,
  }) : super(key: key);

  @override
  _SearchResultCardState createState() => _SearchResultCardState();
}

class _SearchResultCardState extends State<SearchResultCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  bool _loading = true; // Track whether the image is still loading

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails details) {
    _animationController.forward();
  }

  void _onTapUp(TapUpDetails details) {
    _animationController.reverse();
  }

  void _onTapCancel() {
    _animationController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return DetailedRecipe(
            url: widget.recipeUrl,
            title: widget.title,
          );
        })
        );
      },
      child: ScaleTransition(
        scale: Tween(begin: 1.0, end: 0.95).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Curves.easeInOut,
          ),
        ),
        child: Card(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Stack(
              children: [
                // Placeholder widget while loading
                SizedBox(
                  width: double.infinity,
                  height: 200,
                  //color: Colors.grey[300],
                  child: Center(
                    child: Lottie.asset('assets/image_loading.json',
                        width: 100, height: 100), // Loading indicator
                  ),
                ),
                // Actual image when loaded
                Image.network(
                  widget.imageUrl,
                  width: double.infinity,
                  height: 300,
                  fit: BoxFit.cover,
                  loadingBuilder: (BuildContext context, Widget child,
                      ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) {
                      _loading = false; // Image loaded
                      return child;
                    } else {
                      _loading = true; // Image still loading
                      return Center(
                        child: Lottie.asset('assets/image_loading.json',
                            width: 100, height: 100), // Loading indicator
                      );
                    }
                  },
                  // errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                  //   _loading = false; // Image failed to load
                  //   return Image.asset('assets/placeholder_image.png'); // Placeholder image on error
                  // },
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Container(
                    margin: const EdgeInsets.all(10.0),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 2.0),
                    color: Colors.grey.withOpacity(0.3),
                    child: Text(
                      widget.title,
                      style: GoogleFonts.roboto(
                        fontSize: 20.0,
                        color: Colors.white,
                        //fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
