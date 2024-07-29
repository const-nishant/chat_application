import 'package:flutter/material.dart';
import '../exports.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  void logout() {
    final authServices = Authservices();
    authServices.logout();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        iconTheme:
            IconThemeData(color: Theme.of(context).colorScheme.secondary),
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: const Text(
          'Home',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            onPressed: logout,
            icon: const Icon(
              Icons.logout,
            ),
          ),
        ],
        centerTitle: true,
      ),
      drawer: const CommonDrawer(),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: const UserList(),
      ),
    );
  }
}
