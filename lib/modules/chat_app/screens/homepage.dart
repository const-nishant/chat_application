import 'package:flutter/material.dart';
import '../exports.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.grey,
        title: const Text(
          'Home',
          style: TextStyle(
              // color: Colors.white,
              ),
        ),
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
