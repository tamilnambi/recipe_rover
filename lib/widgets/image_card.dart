import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../pages/search_results.dart';

class ImageCard extends StatefulWidget {
  final String imageUrl;
  final String title;
  const ImageCard({super.key, required this.imageUrl, required this.title});

  @override
  _ImageCardState createState() => _ImageCardState();
}

class _ImageCardState extends State<ImageCard> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 100),
      vsync: this,
    );
    _animation = Tween<double>(begin: 1.0, end: 0.95).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails details) {
    _controller.forward();
  }

  void _onTapUp(TapUpDetails details) {
    _controller.reverse();
  }

  void _onTapCancel() {
    _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        //Navigate to SearchResults page with arugument ingredient
        Navigator.push(context, MaterialPageRoute(builder: (context) => SearchResults(ingredient: widget.title)));
      },
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return Transform.scale(
            scale: _animation.value,
            child: Column(
              children: [
                Card(
                  color: Colors.white,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0), // Adjust the value as needed
                    child: Image.asset(
                      widget.imageUrl,
                      height: 100,
                      width: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 10.0),
                Text(
                  widget.title,
                  style: GoogleFonts.roboto(
                    fontSize: 15.0,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
