import 'package:flutter/material.dart';

class AppTheme {
  // Primary brand color - iSpeak blue
  static const Color primaryColor = Color(0xFF1D4ED8);
  
  // Secondary colors
  static const Color accentColor = Color(0xFF3B82F6);
  static const Color backgroundColor = Color(0xFFF9FAFB);
  
  // Text colors
  static const Color textPrimary = Color(0xFF1D4ED8);
  static const Color textSecondary = Color(0xFF6B7280);
  static const Color textHint = Color(0xFF9CA3AF);
  
  // Neutral colors
  static const Color errorColor = Color(0xFFEF4444);
  static const Color successColor = Color(0xFF10B981);
  static const Color warningColor = Color(0xFFF59E0B);
  
  // Typography
  static const String fontFamily = 'Inter';
  
  static TextTheme get textTheme {
    return const TextTheme(
      headlineLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, fontFamily: fontFamily, color: textPrimary),
      headlineMedium: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, fontFamily: fontFamily, color: textPrimary),
      headlineSmall: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, fontFamily: fontFamily, color: textPrimary),
      titleLarge: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, fontFamily: fontFamily, color: textPrimary),
      titleMedium: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, fontFamily: fontFamily, color: textPrimary),
      titleSmall: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, fontFamily: fontFamily, color: textPrimary),
      bodyLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, fontFamily: fontFamily, color: textPrimary),
      bodyMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, fontFamily: fontFamily, color: textSecondary),
      bodySmall: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, fontFamily: fontFamily, color: textHint),
      labelLarge: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, fontFamily: fontFamily, color: textPrimary),
      labelMedium: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, fontFamily: fontFamily, color: textPrimary),
      labelSmall: TextStyle(fontSize: 11, fontWeight: FontWeight.w500, fontFamily: fontFamily, color: textSecondary),
    );
  }
}