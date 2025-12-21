import 'package:flutter/material.dart';

class AppColors {
  // Primary palette - warm cream/milk tones
  static const Color cream = Color(0xFFFDF6E3);
  static const Color warmWhite = Color(0xFFFFFBF5);
  static const Color milkWhite = Color(0xFFF8F4EF);

  // Accent colors - earthy dairy farm vibes
  static const Color barnRed = Color(0xFFB85450);
  static const Color forestGreen = Color(0xFF4A7C59);
  static const Color goldenHay = Color(0xFFD4A853);
  static const Color richBrown = Color(0xFF6B4423);
  static const Color skyBlue = Color(0xFF6B9AC4);

  // Functional colors
  static const Color textPrimary = Color(0xFF2D2416);
  static const Color textSecondary = Color(0xFF6B5B4F);
  static const Color textLight = Color(0xFF9A8B7A);
  static const Color border = Color(0xFFE8DFD5);
  static const Color cardShadow = Color(0x1A6B4423);

  // Gradient colors
  static const List<Color> primaryGradient = [
    Color(0xFFFDF6E3),
    Color(0xFFF5ECD9),
    Color(0xFFEDE3CF),
  ];

  static const List<Color> accentGradient = [
    Color(0xFF4A7C59),
    Color(0xFF3D6649),
  ];
}

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: AppColors.cream,
      colorScheme: ColorScheme.light(
        primary: AppColors.forestGreen,
        secondary: AppColors.goldenHay,
        surface: AppColors.warmWhite,
        error: AppColors.barnRed,
        onPrimary: Colors.white,
        onSecondary: AppColors.textPrimary,
        onSurface: AppColors.textPrimary,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: AppColors.textPrimary),
        titleTextStyle: TextStyle(
          color: AppColors.textPrimary,
          fontSize: 20,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.forestGreen,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.3,
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.warmWhite,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: AppColors.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: AppColors.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: AppColors.forestGreen, width: 2),
        ),
        labelStyle: const TextStyle(
          color: AppColors.textSecondary,
          fontSize: 13,
        ),
        hintStyle: const TextStyle(
          color: AppColors.textLight,
          fontSize: 14,
        ),
      ),
      cardTheme: CardThemeData(
        color: AppColors.warmWhite,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: AppColors.border),
        ),
      ),
    );
  }
}

class AppTextStyles {
  static const TextStyle heading1 = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
    letterSpacing: -0.5,
  );

  static const TextStyle heading2 = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    letterSpacing: -0.3,
  );

  static const TextStyle heading3 = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  static const TextStyle body = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
    height: 1.5,
  );

  static const TextStyle bodyBold = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  static const TextStyle caption = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: AppColors.textLight,
    letterSpacing: 0.3,
  );

  static const TextStyle label = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w500,
    color: AppColors.textSecondary,
  );

  static const TextStyle number = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    fontFeatures: [FontFeature.tabularFigures()],
  );

  static const TextStyle total = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w700,
    color: AppColors.forestGreen,
    fontFeatures: [FontFeature.tabularFigures()],
  );
}

