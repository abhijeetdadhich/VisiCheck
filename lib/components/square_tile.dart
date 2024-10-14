import 'package:flutter/material.dart';

class SquareTile extends StatelessWidget {
  //it is circle avatar not a conatiner any
  final String imagePath;
  final Function()? onTap;
  final double radius;

  const SquareTile({
    super.key,
    required this.imagePath,
    required this.onTap,
    this.radius = 25.0, // Default radius set to 30.0
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: CircleAvatar(
        radius: radius,
        backgroundColor: Colors.grey[200],
        child: CircleAvatar(
          radius: radius - 10, // Adjust to create padding effect
          backgroundColor: Colors.transparent,
          backgroundImage: AssetImage(imagePath),
        ),
      ),
    );
  }
}
