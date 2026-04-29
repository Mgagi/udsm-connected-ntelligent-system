import 'package:flutter/material.dart';

const ucisBlue = Color(0xFF315EDB);
const ucisBlueDark = Color(0xFF2348B8);
const ucisInk = Color(0xFF101828);
const ucisMuted = Color(0xFF667085);
const ucisLine = Color(0xFFE4E7EC);
const ucisCanvas = Color(0xFFF4F6FB);
const ucisGold = Color(0xFFF4B740);
const ucisGreen = Color(0xFF12A66A);
const ucisRed = Color(0xFFE33B4A);

ThemeData buildUcisTheme() {
  final scheme = ColorScheme.fromSeed(
    seedColor: ucisBlue,
    primary: ucisBlue,
    secondary: ucisGold,
    tertiary: ucisGreen,
    error: ucisRed,
    surface: Colors.white,
    brightness: Brightness.light,
  );

  return ThemeData(
    useMaterial3: true,
    colorScheme: scheme,
    scaffoldBackgroundColor: ucisCanvas,
    fontFamily: 'Roboto',
    textTheme: const TextTheme(
      headlineSmall: TextStyle(fontSize: 19, fontWeight: FontWeight.w900, color: ucisInk),
      titleLarge: TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: ucisInk),
      titleMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: ucisInk),
      bodyMedium: TextStyle(fontSize: 12, color: ucisMuted),
      labelLarge: TextStyle(fontSize: 12, fontWeight: FontWeight.w800),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: ucisLine),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: ucisLine),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: ucisBlue, width: 1.4),
      ),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        backgroundColor: ucisBlue,
        foregroundColor: Colors.white,
        minimumSize: const Size.fromHeight(46),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        textStyle: const TextStyle(fontWeight: FontWeight.w900, fontSize: 13),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: ucisInk,
        side: const BorderSide(color: ucisLine),
        minimumSize: const Size.fromHeight(44),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        textStyle: const TextStyle(fontWeight: FontWeight.w900, fontSize: 13),
      ),
    ),
  );
}
