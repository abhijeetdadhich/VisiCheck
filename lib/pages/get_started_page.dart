import 'package:flutter/material.dart';

class GetStartedPage extends StatelessWidget {
  final VoidCallback onGetStarted;

  const GetStartedPage({super.key, required this.onGetStarted});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(14, 19, 24, 1.000),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 400,
              child: Image.asset(
                'lib/images/nologo.png',
                width: 250,
                height: 100,
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Container(
              width: 250,
              height: 250,
              child: Image.asset(
                'lib/images/welcome_girl_graded 2.png',
              ),
            ),
            SizedBox(height: 90),
            Container(
              width: 300, // Set a fixed width for the button
              child: MaterialButton(
                onPressed: onGetStarted,
                color: Color.fromRGBO(
                    8, 189, 128, 1.000), // Background color of the button
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                      30), // Adjust the radius for the pill shape
                ),
                minWidth:
                    180, // Ensure the minWidth matches the width to prevent stretching
                height: 60,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Get Started',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold // Text color
                      ),
                    ),
                    SizedBox(
                        width: 10), // Adjust the spacing between text and icon
                    Icon(
                      Icons.arrow_forward,
                      color: Colors.black, // Icon color
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
