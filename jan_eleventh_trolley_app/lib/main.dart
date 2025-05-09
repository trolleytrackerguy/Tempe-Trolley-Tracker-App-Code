/*
import 'package:flutter/material.dart';
// import 'package:jan_eleventh_trolley_app/screens/mainscreen/mainscreen.dart';
import 'package:jan_eleventh_trolley_app/screens/mainscreen/screenlayout.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: ScreenLayout(),
    );
  }
}
*/

/*
import 'package:flutter/material.dart';
import 'package:jan_eleventh_trolley_app/firebase_options.dart';
import 'package:jan_eleventh_trolley_app/screens/mainscreen/screenlayout.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Hides the debug banner
      home: ScreenLayout(),
    );
  }
}

*/

import 'package:flutter/material.dart';
import 'package:jan_eleventh_trolley_app/screens/mainscreen/screenlayout.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // Ensure Flutter bindings are initialized
  await Firebase.initializeApp(); // Initialize Firebase
  runApp(const MyApp()); // Run the main application widget
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Hides the debug banner
      home: ScreenLayout(),
    );
  }
}
