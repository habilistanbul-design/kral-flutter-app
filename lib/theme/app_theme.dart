import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color primary = Color(0xFF755B00);
  static const Color primaryContainer = Color(0xFFB69121);
  static const Color primaryFixed = Color(0xFFFFDF92);
  static const Color primaryFixedDim = Color(0xFFEBC24F);
  static const Color onPrimary = Color(0xFFFFFFFF);
  static const Color onPrimaryContainer = Color(0xFF3B2C00);

  static const Color secondary = Color(0xFF5F5E5E);
  static const Color secondaryContainer = Color(0xFFE2DFDE);

  static const Color surface = Color(0xFFFDF8F6);
  static const Color surfaceContainer = Color(0xFFF1EDEA);
  static const Color surfaceContainerLow = Color(0xFFF7F3F0);
  static const Color surfaceContainerHigh = Color(0xFFECE7E4);
  static const Color surfaceContainerLowest = Color(0xFFFFFFFF);
  static const Color onSurface = Color(0xFF1C1B1A);
  static const Color onSurfaceVariant = Color(0xFF4D4636);

  static const Color outline = Color(0xFF7F7664);
  static const Color outlineVariant = Color(0xFFD1C5B0);

  static const Color error = Color(0xFFBA1A1A);
  static const Color onError = Color(0xFFFFFFFF);

  static const Color background = Color(0xFFFDF8F6);

  static List<BoxShadow> get luxuryShadow => [
    BoxShadow(
      color: primary.withOpacity(0.05),
      blurRadius: 30,
    ),
  ];

  static ThemeData get theme => ThemeData(
    useMaterial3: true,
    colorScheme: const ColorScheme.light(
      primary: primary,
      onPrimary: onPrimary,
      primaryContainer: primaryContainer,
      onPrimaryContainer: onPrimaryContainer,
      secondary: secondary,
      secondaryContainer: secondaryContainer,
      surface: surface,
      onSurface: onSurface,
      error: error,
      onError: onError,
      outline: outline,
      outlineVariant: outlineVariant,
    ),
    scaffoldBackgroundColor: surface,
    textTheme: GoogleFonts.manropeTextTheme(),
    appBarTheme: AppBarTheme(
      backgroundColor: background,
      foregroundColor: primary,
      elevation: 0,
      centerTitle: true,
    ),
  );
}
