import 'package:flutter/material.dart';
import 'package:technews/pages/home.dart';
import 'package:technews/utils/color.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isDark = true; // Default theme mode

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Tech News",
      debugShowCheckedModeBanner: false,
      theme: AppColors.lightTheme,
      darkTheme: AppColors.darkTheme,
      themeMode: isDark ? ThemeMode.dark : ThemeMode.light,
      home: Home(
      ),
    );
  }
}
