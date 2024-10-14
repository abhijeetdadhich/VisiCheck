import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:visicheck/components/home_screen_button.dart';
import 'package:visicheck/pages/activity.dart';
import 'package:visicheck/pages/autocheck.dart';
import 'package:visicheck/pages/check_in_out.dart';
import 'package:visicheck/pages/logout_drawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  User? user;

  @override
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.currentUser;
  }

  // Sign user out method
  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;
    final screenHeight = screenSize.height;
    final isWidthGreater = (screenWidth > screenHeight);
    final buttonSpacing =
        isWidthGreater ? (screenHeight * 0.06) : (screenWidth * 0.06);
    final devicePadding =
        isWidthGreater ? (screenHeight * 0.06) : (screenWidth * 0.06);

    final emailPrefix = user?.email?.split('@').first ?? 'User';

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: Icon(
                Icons.menu,
                color: Theme.of(context).colorScheme.onBackground,
              ),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
        title: Text(
          'Home',
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.onBackground,
              ),
        ),
      ),
      drawer: LogoutDrawer(
        onLogOut: signUserOut,
      ),
      body: Padding(
        padding: EdgeInsets.all(devicePadding),
        child: Column(
          children: [
            Row(
              children: [
                const CircleAvatar(
                  radius: 39,
                  backgroundImage: AssetImage('lib/images/circular-avatar.jpg'),
                  // child: Image.asset('lib/images/circular-avatar.jpg'),
                ),
                const SizedBox(
                  width: 20,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Hi ',
                          style: TextStyle(
                              fontSize: 15,
                              color:
                                  Theme.of(context).colorScheme.onBackground),
                        ),
                        Text(
                          emailPrefix, // for just before @
                          // user?.email ?? 'User',    // for whole mail id
                          style: TextStyle(
                              fontSize: 15,
                              color: Theme.of(context).colorScheme.secondary),
                        ),
                        Text(
                          ',',
                          style: TextStyle(
                            fontSize: 15,
                            color: Theme.of(context).colorScheme.onBackground,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          'Welcome back to ',
                          style: TextStyle(
                              fontSize: 15,
                              color:
                                  Theme.of(context).colorScheme.onBackground),
                        ),
                        Text(
                          'Visi',
                          style: TextStyle(
                              fontSize: 15,
                              color: Theme.of(context).colorScheme.secondary),
                        ),
                        Text(
                          'Check',
                          style: TextStyle(
                            fontSize: 15,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                        Text(
                          '.',
                          style: TextStyle(
                              fontSize: 15,
                              color:
                                  Theme.of(context).colorScheme.onBackground),
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
            const SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const HomeScreenButton(
                  buttonIcon: Icons.location_history_rounded,
                  buttonTitle: 'Manual \n Check-in/out',
                ),
                SizedBox(
                  width: buttonSpacing,
                ),
                const HomeScreenButton(
                  buttonIcon: Icons.autorenew,
                  buttonTitle: 'Automatic \n Check-in/out',
                ),
              ],
            ),
            // const SizedBox(
            //   height: 10,
            // ),
            // MaterialButton(
            //   onPressed: () {
            //     Navigator.of(context).push(
            //         MaterialPageRoute(builder: (ctx) => const CheckInOut()));
            //   },
            //   color: Colors.amber,
            // ),
            // SizedBox(
            //   height: 10,
            // ),
            // MaterialButton(
            //   onPressed: () {
            //     Navigator.of(context).push(MaterialPageRoute(
            //         builder: (ctx) => const AutoCheckInOut()));
            //   },
            //   color: const Color.fromARGB(255, 0, 200, 255),
            // ),
            // SizedBox(
            //   height: 20,
            // ),
            // MaterialButton(
            //   onPressed: () {
            //     Navigator.of(context).push(
            //         MaterialPageRoute(builder: (ctx) => const Activity()));
            //   },
            //   color: const Color.fromARGB(255, 0, 200, 255),
            // ),
            const Spacer(),
            SizedBox(
              height: 100,
              width: 100,
              child: Image.asset(
                'lib/images/aayushlogonewtext.png',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
