import 'package:flutter/material.dart';

/// Modern color manager with support for animated theme switching.
class AppColors {
  // Define your seed / base color
  static const Color _seed = Colors.deepPurple;

  /// Light Theme
  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(seedColor: _seed, brightness: Brightness.light),
    scaffoldBackgroundColor: Colors.grey.shade50,
    appBarTheme: const AppBarTheme(
      elevation: 0,
      backgroundColor: Colors.transparent,
      foregroundColor: Colors.black,
      centerTitle: true,
    ),
  );

  /// Dark Theme
  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(seedColor: _seed, brightness: Brightness.dark),
    scaffoldBackgroundColor: const Color(0xff0d0d0d),
    appBarTheme: const AppBarTheme(
      elevation: 0,
      backgroundColor: Colors.transparent,
      foregroundColor: Colors.white,
      centerTitle: true,
    ),
  );
}

/// A widget that smoothly animates color changes based on theme.
class AnimatedColorBackground extends StatelessWidget {
  final Widget child;

  const AnimatedColorBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
      color: scheme.surface,
      child: child,
    );
  }
}
