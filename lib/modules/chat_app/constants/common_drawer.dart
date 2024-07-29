import 'package:flutter/material.dart';
import '../exports.dart';

class CommonDrawer extends StatelessWidget {
  const CommonDrawer({super.key});

  void logout() {
    final authServices = Authservices();
    authServices.logout();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: Column(
        children: [
          DrawerHeader(
            child: Center(
              child: Icon(
                Icons.message,
                color: Theme.of(context).colorScheme.primary,
                size: 60,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Column(
            children: [
              //home list tile
              Padding(
                padding: const EdgeInsets.only(left: 24.0),
                child: ListTile(
                  leading: Icon(
                    Icons.home,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  title: const Text(
                    'H O M E',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  onTap: () {
                    //pop context
                    Navigator.pop(context);
                    //open home screen
                    Navigator.pushNamed(context, '/home');
                  },
                ),
              ),
              const SizedBox(height: 18),
              //profile list tile
              Padding(
                padding: const EdgeInsets.only(left: 24.0),
                child: ListTile(
                  leading: Icon(
                    Icons.person,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  title: const Text(
                    'P R O F I L E',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  onTap: () {
                    //pop context
                    Navigator.pop(context);
                    //open profile screen
                    Navigator.pushNamed(context, '/profile');
                  },
                ),
              ),
              const SizedBox(height: 18),
              //settings list tile
              Padding(
                padding: const EdgeInsets.only(left: 24.0),
                child: ListTile(
                  leading: Icon(
                    Icons.settings,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  title: const Text(
                    'S E T T I N G S',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  onTap: () {
                    //pop context
                    Navigator.pop(context);
                    //open settings screen
                    Navigator.pushNamed(context, '/settings');
                  },
                ),
              ),
              const SizedBox(height: 18),
            ],
          ),
          const Spacer(),
          //logout list tile
          Padding(
            padding: const EdgeInsets.only(
              left: 24.0,
              bottom: 24.0,
            ),
            child: ListTile(
              leading: Icon(
                Icons.logout,
                color: Theme.of(context).colorScheme.primary,
              ),
              title: const Text(
                'L O G O U T',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                ),
              ),
              onTap: () {
                //pop context
                Navigator.pop(context);
                //logout
                logout();
              },
            ),
          ),
        ],
      ),
    );
  }
}
