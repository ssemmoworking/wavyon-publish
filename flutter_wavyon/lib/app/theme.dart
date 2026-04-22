import 'package:flutter/material.dart';

class WavyonColors {
  static const Color navy = Color(0xFF1E3A8A);
  static const Color blue = Color(0xFF2563EB);
  static const Color sky = Color(0xFF06B6D4);
  static const Color pink = Color(0xFFEC4899);
  static const Color red = Color(0xFFDC2626);
  static const Color amber = Color(0xFFF59E0B);
  static const Color ink = Color(0xFF0F172A);
  static const Color canvas = Color(0xFFF7F8FC);
  static const Color card = Colors.white;
  static const Color line = Color(0xFFE8ECF4);
  static const Color text = Color(0xFF0F172A);
  static const Color muted = Color(0xFF64748B);
}

ThemeData buildWavyonTheme() {
  final base = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: WavyonColors.blue,
      primary: WavyonColors.blue,
      surface: Colors.white,
    ),
    useMaterial3: true,
  );

  return base.copyWith(
    scaffoldBackgroundColor: WavyonColors.canvas,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      foregroundColor: WavyonColors.text,
      centerTitle: false,
    ),
    textTheme: base.textTheme.copyWith(
      headlineLarge: const TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.w900,
        color: WavyonColors.text,
      ),
      headlineMedium: const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w900,
        color: WavyonColors.text,
      ),
      titleLarge: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w800,
        color: WavyonColors.text,
      ),
      titleMedium: const TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w800,
        color: WavyonColors.text,
      ),
      bodyLarge: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: WavyonColors.text,
      ),
      bodyMedium: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        color: WavyonColors.muted,
      ),
    ),
    cardTheme: CardThemeData(
      color: WavyonColors.card,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(26)),
      margin: EdgeInsets.zero,
    ),
  );
}
