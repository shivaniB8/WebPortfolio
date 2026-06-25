import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Background
  static const Color background = Color(0xFF080B1A);
  static const Color surfaceDark = Color(0xFF0D1128);
  static const Color surfaceMid = Color(0xFF111530);

  // Primary brand
  static const Color purple = Color(0xFF7C3AED);
  static const Color cyan = Color(0xFF06B6D4);
  static const Color purpleLight = Color(0xFF9D6EFA);
  static const Color cyanLight = Color(0xFF38D4E8);

  // Text
  static const Color textPrimary = Color(0xFFF1F5F9);
  static const Color textSecondary = Color(0xFF94A3B8);
  static const Color textMuted = Color(0xFF64748B);

  // Glass
  static const Color glassWhite = Color(0x14FFFFFF); // ~8% white
  static const Color glassBorder = Color(0x1FFFFFFF); // ~12% white
  static const Color glassHover = Color(0x1AFFFFFF); // ~10% white

  // Category colors for skills
  static const Color catMobile = Color(0xFF7C3AED);
  static const Color catState = Color(0xFF0EA5E9);
  static const Color catBackend = Color(0xFF10B981);
  static const Color catPayments = Color(0xFFF59E0B);
  static const Color catDevOps = Color(0xFFEF4444);
  static const Color catArch = Color(0xFFEC4899);
  static const Color catTesting = Color(0xFF8B5CF6);
  static const Color catOther = Color(0xFF06B6D4);

  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [purple, cyan],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  static const LinearGradient primaryGradientDiag = LinearGradient(
    colors: [purple, cyan],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient heroGradient = LinearGradient(
    colors: [Color(0xFF0D0420), Color(0xFF080B1A), Color(0xFF001020)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient cardTopBar = LinearGradient(
    colors: [purple, cyan],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  static BoxDecoration glassDecoration({
    double borderRadius = 16,
    Color? borderColor,
    List<BoxShadow>? shadows,
  }) {
    return BoxDecoration(
      color: glassWhite,
      borderRadius: BorderRadius.circular(borderRadius),
      border: Border.all(
        color: borderColor ?? glassBorder,
        width: 1,
      ),
      boxShadow: shadows ??
          [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 20,
              spreadRadius: 0,
              offset: const Offset(0, 8),
            ),
          ],
    );
  }

  static BoxDecoration glowDecoration({
    Color glowColor = purple,
    double borderRadius = 16,
  }) {
    return BoxDecoration(
      color: glassWhite,
      borderRadius: BorderRadius.circular(borderRadius),
      border: Border.all(color: glassBorder, width: 1),
      boxShadow: [
        BoxShadow(
          color: glowColor.withOpacity(0.25),
          blurRadius: 30,
          spreadRadius: 2,
        ),
        BoxShadow(
          color: Colors.black.withOpacity(0.3),
          blurRadius: 20,
          spreadRadius: 0,
          offset: const Offset(0, 8),
        ),
      ],
    );
  }
}
