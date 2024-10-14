import 'package:flutter/material.dart';

class PasswordField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;

  const PasswordField({
    super.key,
    required this.controller,
    required this.hintText,
  });

  @override
  _PasswordFieldState createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _isObscured = true;

  void _toggleVisibility() {
    setState(() {
      _isObscured = !_isObscured;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: TextField(
        controller: widget.controller,
        obscureText: _isObscured,
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
                color: Color.fromRGBO(141, 188, 252, 1), width: 6),
            borderRadius: const BorderRadius.all(Radius.circular(50.0)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide:
                const BorderSide(color: Color.fromRGBO(141, 188, 252, 1)),
            borderRadius: const BorderRadius.all(Radius.circular(50.0)),
          ),
          fillColor: Color.fromRGBO(141, 188, 252, 1),
          filled: true,
          hintText: widget.hintText,
          hintStyle: TextStyle(
            color: Color.fromRGBO(80, 72, 82, 1),
            
            fontSize: 15,
          ),
          contentPadding: EdgeInsets.symmetric(
              vertical: 20.0), // Adjust the vertical padding as needed
          prefixIcon: Padding(
            padding: const EdgeInsets.only(
                left: 80), // Adjust the left padding as needed
            child: Container(
              width:
                  10, // Set the width of the invisible widget to create space
            ),
          ),
          suffixIcon: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 20), // Adjust the padding as needed
            child: IconButton(
              icon: Icon(
                _isObscured ? Icons.visibility : Icons.visibility_off,
                color:
                    Color.fromRGBO(0, 0, 0, 0.6), // Adjust icon color if needed
              ),
              onPressed: _toggleVisibility,
            ),
          ),
        ),
      ),
    );
  }
}
