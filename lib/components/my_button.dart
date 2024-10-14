import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final void Function()? onTap;
  final String text;
  final Color borderColor;
  final double borderWidth;

  const MyButton({
    super.key,
    required this.onTap,
    required this.text,
    this.borderColor = Colors.transparent,
    this.borderWidth = 1.0,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.symmetric(
          horizontal: 25,
        ),
        decoration: BoxDecoration(
          color: const Color.fromRGBO(8, 189, 128, 1.0),
          borderRadius: BorderRadius.all(Radius.circular(50.0)),
          border: Border.all(
            color: borderColor,
            width: borderWidth,
          ),
        ),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
