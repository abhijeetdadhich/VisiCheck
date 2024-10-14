// ignore_for_file: unnecessary_const

// import 'package:auth_app/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:visicheck/components/my_button.dart';
import 'package:visicheck/components/my_textfield.dart';
import 'package:visicheck/components/password_field.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onTap;
  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  //text editing controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  //sign user up method
  void signUserUp() async {
    // show loading circle
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation(Color.fromRGBO(0, 255, 254, 1)),
          ),
        );
      },
    );

    //try creating the user
    try {
      //check if confirm password is same as password.
      if (passwordController.text == confirmPasswordController.text) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: emailController.text, password: passwordController.text);
      } else {
        //show error message, passwords doesnt match
        showErrorMessage("Passwords don't match!");
      }

      // Pop the loading circle after successful sign-in
      // ignore: use_build_context_synchronously
      Navigator.of(context).pop();

      //navigation to authpage handled by auth page
    } on FirebaseAuthException catch (e) {
      // Pop the loading circle before showing the error dialog
      // ignore: use_build_context_synchronously
      Navigator.of(context).pop();

      //show error message
      showErrorMessage(e.code);
    }
  }

  //error message to user.
  void showErrorMessage(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).colorScheme.onBackground,
          title: Center(
            child: Text(
              message,
              style: const TextStyle(color: Colors.black),
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
                const SizedBox(
                  height: 125,
                ),
                //App logo
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 70),
                  child: Image.asset(
                    'lib/images/aayushlogonewtext.png',
                  ),
                ),
                // //welcome
                // Text(
                //   "     Smarten up your Attendance game...  ",
                //   style: TextStyle(
                //     color: const Color.fromRGBO(255, 254, 254, 1),
                //     fontSize: 16,
                //   ),
                // ),
                const SizedBox(height: 100),
                // Email field
                MyTextField(
                  controller: emailController,
                  hintText: 'Email',
                  obscureText: false,
                ),
                const SizedBox(height: 10),
                //password field
                PasswordField(
                  controller: passwordController,
                  hintText: 'Password',
                ),
                const SizedBox(height: 10),

                //Confirm password field
                PasswordField(
                    controller: confirmPasswordController,
                    hintText: 'Confirm Password'),
                const SizedBox(height: 10),

                //sign in button
                MyButton(
                  onTap: signUserUp,
                  text: 'Sign Up',
                ),
                const SizedBox(height: 30),
                //or continue with
                // Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: 25.0),
                //   child: Row(
                //     children: [
                //       Expanded(
                //         child: Divider(
                //           thickness: 0.5,
                //           color: Colors.grey[400],
                //         ),
                //       ),
                // Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: 10.0),
                //   child: Text(
                //     'or Continue with',
                //     style: TextStyle(
                //         color: const Color.fromRGBO(255, 254, 254, 1)),
                //   ),
                // ),
                // Expanded(
                //   child: Divider(
                //     thickness: 0.5,
                //     color: Colors.grey[400],
                //   ),
                // ),
                //     ],
                //   ),
                // ),
                // const SizedBox(
                //   height: 40,
                // ),
                //google + apple sign in button
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     SquareTile(
                //       imagePath: 'lib/images/google.png',
                //       onTap: () async {
                //         UserCredential? userCredential =
                //             await AuthService().signInWithGoogle();
                //         if (userCredential == null) {
                //           // Handle the case when the user cancels the Google sign-in
                //           showErrorMessage(
                //               "Google sign-in was canceled or failed");
                //         }
                //       },
                //     ),
                //   ],
                // ),
                // const SizedBox(
                //   height: 5,
                // ),
                //not a member + register now
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text(
                        'Already have an account?',
                        style: TextStyle(
                            color: const Color.fromRGBO(255, 254, 254, 1),
                            fontSize: 15),
                      ),
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: Text(
                        'Login Now',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
