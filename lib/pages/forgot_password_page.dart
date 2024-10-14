import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:visicheck/components/my_textfield.dart";

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _emailController = TextEditingController();
  // final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future passwordReset() async {
    try {
      print('Attempting to send password reset email...');
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: _emailController.text.trim());
      print('Password reset email sent!');
      showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            content: Text("Password reset email sent! Check you email"),
          );
        },
      );
    } on FirebaseAuthException catch (e) {
      print('FirebaseAuthException caught: ${e.message}');
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text(e.message.toString()),
          );
        },
      );
    } catch (e) {
      print('Unknown error caught: $e');
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text("An unknown error occurred"),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(14, 19, 24, 1.000),
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        iconTheme: IconThemeData(
          color: Theme.of(context).colorScheme.onBackground,
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 50),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Image.asset(
                    'lib/images/forgot_passwrd_graded.png',
                  ),
                ),
                const SizedBox(
                  height: 110,
                ),
                // const SizedBox(height: 10),
                SizedBox(
                  width: 500,
                  child: MyTextField(
                    controller: _emailController,
                    hintText: 'Email',
                    obscureText: false,
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: 340,
                  child: MaterialButton(
                    onPressed: passwordReset,
                    child: Text(
                      'Reset Password',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold), // Ensure text is visible
                    ),
                    color: const Color.fromRGBO(8, 189, 128, 1.000),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          50.0), // Adjust the radius for the pill shape
                    ),
                    // minWidth: 310.0, // Adjust the minimum width as needed
                     height: 64.0, // Adjust the height as needed
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
