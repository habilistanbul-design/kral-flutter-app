import 'package:flutter/material.dart';
import 'theme/app_theme.dart';
import 'screens/onboarding_screen.dart';

void main() {
  runApp(const KralApp());
}

class KralApp extends StatelessWidget {
  const KralApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'KRAL Barbershop',
      theme: AppTheme.theme,
      debugShowCheckedModeBanner: false,
      home: const OnboardingScreen(),
    );
  }
}
