import 'package:flutter/material.dart';
import 'package:todolist_app/core/constants/app_pallete.dart';
import 'package:todolist_app/features/home/presentation/pages/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To Do List',
      theme: ThemeData(scaffoldBackgroundColor: AppPalette.scaffoldBg),
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
