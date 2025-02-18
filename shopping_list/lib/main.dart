import 'package:flutter/material.dart';
import 'package:shopping_list/widgets/grocery_list.dart';

import 'package:google_fonts/google_fonts.dart';

final theme = ThemeData.dark().copyWith(
  colorScheme: ColorScheme.fromSeed(
    seedColor: const Color.fromARGB(255, 147, 229, 250),
    brightness: Brightness.dark,
    surface: const Color.fromARGB(255, 42, 51, 59),
  ),
  scaffoldBackgroundColor: const Color.fromARGB(255, 50, 58, 60),
  textTheme: GoogleFonts.ralewayTextTheme(
    TextTheme().copyWith(
      bodySmall: TextStyle(
          color: const Color.fromARGB(
              227, 240, 236, 220)), // Small body text style
      bodyMedium: TextStyle(color: Colors.white), // Medium body text style
      bodyLarge: TextStyle(color: Colors.white), // Large body text style

      headlineSmall: TextStyle(color: Colors.white), // Small headline style
      headlineMedium: TextStyle(color: Colors.white), // Medium headline style
      headlineLarge: TextStyle(color: Colors.white), // Large headline style

      titleSmall: TextStyle(color: Colors.white), // Small title style
      titleMedium: TextStyle(color: Colors.white), // Medium title style
      titleLarge: TextStyle(color: Colors.white), // Large title style
    ),
  ),
);
void main() {
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const GroceryList(),
      theme: theme,
    );
  }
}
