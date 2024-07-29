import 'package:flutter/material.dart';

import '../exports.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme:
            IconThemeData(color: Theme.of(context).colorScheme.secondary),
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: const Text(
          'Settings',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      drawer: const CommonDrawer(),
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Container(),
    );
  }
}
