import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'screens/login_screen.dart';
import 'screens/main_screen.dart';
import 'firebase_options.dart';
import '/screens/theme_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp()); // Added const here
}

class MyApp extends StatelessWidget {
  const MyApp({super.key}); // Added const constructor

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ThemeProvider>(
      create: (_) => ThemeProvider(),
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            title: 'TaskMate',
            themeMode: themeProvider.themeMode,
            theme: themeProvider.lightTheme, // Use themes from ThemeProvider
            darkTheme: themeProvider.darkTheme,   // Use themes from ThemeProvider
            debugShowCheckedModeBanner: false,
            home: StreamBuilder(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return MainScreen(); // Added const here
                } else {
                  return LoginScreen();
                }
              },
            ),
            routes: {
              '/login': (context) => LoginScreen(),
              '/main': (context) => MainScreen(), // Added const here
            },
          );
        },
      ),
    );
  }
}