import 'package:blog/core/theme/theme.dart';
import 'package:blog/features/auth/presentation/pages/login_page.dart';
import 'package:flutter/material.dart';

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
      debugShowCheckedModeBanner: false,
      title: 'My Blog',
      theme: AppTheme.darkThemeMode,
      home: const LoginPagePage(),
    );
  }
}
