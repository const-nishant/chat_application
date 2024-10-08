import 'package:chat_application/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'modules/chat_app/exports.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(ChangeNotifierProvider(
    create: (context) => ThemeProvider(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chat App',
      debugShowCheckedModeBanner: false,
      theme: Provider.of<ThemeProvider>(context).themeData,
      routes: {
        '/authgate': (context) => const AuthGate(),
        '/home': (context) => const Homepage(),
        '/profile': (context) => const ProfileScreen(),
        '/settings': (context) => const SettingScreen(),
        '/blockedusers': (context) => const BlockedUsers(),
        '/loginorregister': (context) => const LoginOrRegister(),
        // '/login':(context)=>const LoginScreen(),
        // '/register':(context)=>const RegisterScreen(),
        // '/chatscreen':(context)=>const ChatScreen(),
        '/userlist': (context) => const UserList(),
      },
      home: const AuthGate(),
    );
  }
}
