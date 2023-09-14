import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_apps/screens/auth.dart';
import 'package:flutter_chat_apps/screens/chat.dart';
import 'package:flutter_chat_apps/screens/splash.dart';
import "firebase_options.dart";
import "package:firebase_core/firebase_core.dart";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'FlutterChat',
        theme: ThemeData().copyWith(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
              seedColor: const Color.fromARGB(255, 124, 7, 202)),
        ),
        home: StreamBuilder(
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const SplashScreen();
            }
            if (snapshot.hasData) {
              return const ChatScreen();
            }
            return const AuthScreen();
          },
          stream: FirebaseAuth.instance.authStateChanges(),
        ));
  }
}
