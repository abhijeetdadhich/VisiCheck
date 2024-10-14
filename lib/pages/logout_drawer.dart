import 'package:flutter/material.dart';

class LogoutDrawer extends StatelessWidget {
  const LogoutDrawer({super.key, required this.onLogOut});

  final void Function() onLogOut;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: Column(
        children: [
          DrawerHeader(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
            ),
            child: Row(
              children: [
                Icon(
                  Icons.home,
                  size: 50,
                  color: Theme.of(context).colorScheme.onBackground,
                ),
                const SizedBox(
                  width: 16,
                ),
                Text(
                  'Home',
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15, left: 25),
            child: GestureDetector(
              onTap: () {
                onLogOut();
              },
              child: Row(
                children: [
                  Icon(
                    Icons.login_outlined,
                    size: 25,
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
                  const SizedBox(
                    width: 25,
                  ),
                  Text(
                    'Sign out',
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.onBackground,
                        fontSize: 18,
                        fontWeight: FontWeight.normal),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
