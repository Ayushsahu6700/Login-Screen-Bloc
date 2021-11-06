import 'package:flutter/material.dart';
import 'package:bouncing_widget/bouncing_widget.dart';
import 'package:show_up_animation/show_up_animation.dart';

class Heading extends StatelessWidget {
  double size;
  String text;
  Heading({required this.size, required this.text});
  @override
  Widget build(BuildContext context) {
    return ShowUpAnimation(
      delayStart: Duration(seconds: 1),
      animationDuration: Duration(seconds: 1),
      curve: Curves.bounceIn,
      direction: Direction.horizontal,
      offset: 0.5,
      child: Padding(
        padding: const EdgeInsets.only(left: 15.0),
        child: Text(
          text,
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.w700, fontSize: size),
        ),
      ),
    );
  }
}

class RoundedButton extends StatelessWidget {
  RoundedButton(
      {required this.colour, required this.title, required this.onPressed});
  final Color colour;
  final String title;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return BouncingWidget(
      duration: Duration(milliseconds: 100),
      scaleFactor: 1.5,
      onPressed: onPressed,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 16.0),
        child: Material(
          elevation: 5.0,
          color: colour,
          borderRadius: BorderRadius.circular(30.0),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            child: Text(
              title,
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
