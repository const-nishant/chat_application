import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.grey,
        title: const Text(
          'Settings',
        ),
        centerTitle: true,
      ),
      drawer: const CommonDrawer(),
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxHeight: 600),
          child: Column(
            children: [
              //darkmode
              Container(
                padding: const EdgeInsets.all(16.0),
                margin: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //darkmode
                    const Text("Dark Mode"),

                    //switch toogle
                    Switch(
                      activeColor: Colors.white,
                      inactiveThumbColor: Colors.white,
                      inactiveTrackColor: Colors.grey.shade400,
                      trackOutlineColor:
                          const WidgetStatePropertyAll(Colors.transparent),
                      activeTrackColor: Colors.green,
                      value: Provider.of<ThemeProvider>(context).isDarkMode,
                      onChanged: (value) async {
                        final prefs = await SharedPreferences.getInstance();
                        await prefs.setBool('isDarkMode', value);
                        // ignore: use_build_context_synchronously
                        Provider.of<ThemeProvider>(context, listen: false)
                            .toggleTheme();
                      },
                    ),
                  ],
                ),
              ),
              //blocked users
              Container(
                padding: const EdgeInsets.all(16.0),
                margin: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //blocked users
                    const Text(
                      "Blocked Users",
                    ),

                    //button to show blocked users
                    IconButton(
                      icon: const Icon(Icons.chevron_right),
                      onPressed: () =>
                          Navigator.of(context).pushNamed('/blockedusers'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
