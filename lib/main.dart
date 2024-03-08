import 'package:flutter/material.dart';
import 'package:sqflite_sample_program/controller/home_screen_controller.dart';
import 'package:sqflite_sample_program/view/home_screen/home_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // function to open database
  await HomeScreenController.initDb();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomeScreen(),
    );
  }
}
