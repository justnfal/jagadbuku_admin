import 'package:flutter/material.dart';

class Splashlog extends StatelessWidget{
  final String imagePath;
  const Splashlog({
    super.key,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image.asset(
        imagePath,
        height: 200,
      ),
    );
  }


}