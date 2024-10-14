import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:visicheck/components/my_button.dart';
import 'package:visicheck/components/my_textfield.dart';
import 'package:visicheck/components/password_field.dart';
import 'package:visicheck/components/square_tile.dart';
import 'package:visicheck/pages/forgot_password_page.dart';
import 'package:visicheck/services/auth_service.dart';

class LogInPage extends StatefulWidget {
  const LogInPage({super.key, required this.onTap});

  final Function()? onTap;

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void signUserIn() async {
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation(Color.fromRGBO(8,189,128,1.000)),
          ),
        );
      },
    );

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      if (mounted) {
        Navigator.pop(context); // Pop the loading circle
      }
    } on FirebaseAuthException catch (e) {
      if (mounted) {
        Navigator.pop(context); // Pop the loading circle
        showErrorMessage(e.message ?? "An error occurred");
      }
    } catch (e) {
      if (mounted) {
        Navigator.pop(context); // Pop the loading circle
        showErrorMessage("An unknown error occurred");
      }
    }
  }

  void showErrorMessage(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).colorScheme.onBackground,
          title: Center(
            child: Text(
              message,
              style: const TextStyle(color: Color.fromRGBO(22, 22, 22, 1)),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 70),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 70),
                  child: Image.asset('lib/images/aayushlogonewtext.png'),
                ),
                const SizedBox(height: 70),
                MyTextField(
                  controller: emailController,
                  hintText: 'Email',
                  obscureText: false,
                ),
                const SizedBox(height: 10),
                PasswordField(
                  controller: passwordController,
                  hintText: 'Password',
                ),
                const SizedBox(height: 10),
                const SizedBox(height: 0.5),
                MyButton(
                  onTap: signUserIn,
                  text: 'Sign In',
                  // borderWidth: 6,
                  // borderColor: Color.fromRGBO(45,129,247,1.000),
                  // backgroundImage: 'lib/images/bluebackground.png',
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 113.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return const ForgotPasswordPage();
                              },
                            ),
                          );
                        },
                        child: const Padding(
                          padding: EdgeInsets.fromLTRB(2,0,0,10),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              'Forgot Password?',
                              style: TextStyle(
                                color: Color.fromRGBO(255, 254, 254, 1),
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 55),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SquareTile(
                      imagePath: 'lib/images/google.png',
                      onTap: () async {
                        UserCredential? userCredential =
                            await AuthService().signInWithGoogle();
                        if (userCredential == null) {
                          // Handle the case when the user cancels the Google sign-in
                          showErrorMessage(
                              "Google sign-in was canceled or failed");
                        }
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 45),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text(
                        'Not a member?',
                        style: TextStyle(
                          color: Color.fromRGBO(255, 254, 254, 1),
                          fontSize: 15,
                        ),
                      ),
                    ),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: Text(
                        'Register Now',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
