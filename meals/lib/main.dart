import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:meals/screens/tabs.dart';

final theme = ThemeData(
  colorScheme: ColorScheme.fromSeed(
      seedColor: const Color.fromARGB(255, 16, 79, 103),
      brightness: Brightness.dark),
  textTheme: GoogleFonts.ralewayTextTheme(),
);

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(context) {
    return MaterialApp(
      home: const TabsScreen(),
      theme: theme,
    );
  }
}
