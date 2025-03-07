import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

/// Classe que define a tipografia do aplicativo
class AppTypography {
  // Estilos base com Google Fonts
  static final _baseTextStyle = GoogleFonts.montserrat();
  
  // Títulos
  static final TextStyle h1 = _baseTextStyle.copyWith(
    fontSize: 32,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
    height: 1.2,
    letterSpacing: -0.5,
  );
  
  static final TextStyle h2 = _baseTextStyle.copyWith(
    fontSize: 28,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
    height: 1.2,
    letterSpacing: -0.5,
  );
  
  static final TextStyle h3 = _baseTextStyle.copyWith(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    height: 1.3,
    letterSpacing: -0.25,
  );
  
  static final TextStyle h4 = _baseTextStyle.copyWith(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    height: 1.3,
  );
  
  static final TextStyle h5 = _baseTextStyle.copyWith(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    height: 1.4,
  );
  
  // Corpo de texto
  static final TextStyle bodyLarge = _baseTextStyle.copyWith(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: AppColors.textPrimary,
    height: 1.5,
  );
  
  static final TextStyle bodyLargeSecondary = _baseTextStyle.copyWith(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: AppColors.textSecondary,
    height: 1.5,
  );
  
  static final TextStyle bodyMedium = _baseTextStyle.copyWith(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: AppColors.textPrimary,
    height: 1.5,
  );
  
  static final TextStyle bodyMediumSecondary = _baseTextStyle.copyWith(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: AppColors.textSecondary,
    height: 1.5,
  );
  
  static final TextStyle bodySmall = _baseTextStyle.copyWith(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    color: AppColors.textPrimary,
    height: 1.5,
  );
  
  static final TextStyle bodySmallSecondary = _baseTextStyle.copyWith(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    color: AppColors.textSecondary,
    height: 1.5,
  );
  
  // Botões e labels
  static final TextStyle buttonLarge = _baseTextStyle.copyWith(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    height: 1.4,
    letterSpacing: 0.5,
  );
  
  static final TextStyle buttonMedium = _baseTextStyle.copyWith(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    height: 1.4,
    letterSpacing: 0.5,
  );
  
  static final TextStyle buttonSmall = _baseTextStyle.copyWith(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    height: 1.4,
    letterSpacing: 0.5,
  );
  
  static final TextStyle labelLarge = _baseTextStyle.copyWith(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary,
    height: 1.4,
  );
  
  static final TextStyle labelMedium = _baseTextStyle.copyWith(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary,
    height: 1.4,
  );
  
  static final TextStyle labelSmall = _baseTextStyle.copyWith(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary,
    height: 1.4,
  );
  
  // Estilos especiais
  static final TextStyle caption = _baseTextStyle.copyWith(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    color: AppColors.textSecondary,
    height: 1.4,
    letterSpacing: 0.4,
  );
  
  static final TextStyle overline = _baseTextStyle.copyWith(
    fontSize: 10,
    fontWeight: FontWeight.w500,
    color: AppColors.textSecondary,
    height: 1.4,
    letterSpacing: 1.5,
  );
  
  // Estilos para fitness
  static final TextStyle timerDisplay = _baseTextStyle.copyWith(
    fontSize: 48,
    fontWeight: FontWeight.w700,
    color: AppColors.primary,
    height: 1.1,
    letterSpacing: -0.5,
  );
  
  static final TextStyle metricValue = _baseTextStyle.copyWith(
    fontSize: 24,
    fontWeight: FontWeight.w700,
    color: AppColors.secondary,
    height: 1.2,
  );
  
  static final TextStyle metricLabel = _baseTextStyle.copyWith(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: AppColors.textSecondary,
    height: 1.2,
    letterSpacing: 0.5,
  );
  
  static final TextStyle workoutTitle = _baseTextStyle.copyWith(
    fontSize: 18,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
    height: 1.3,
  );
  
  static final TextStyle workoutSubtitle = _baseTextStyle.copyWith(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.secondary,
    height: 1.3,
  );
  
  // Variantes
  static TextStyle get h1Primary => h1.copyWith(color: AppColors.primary);
  static TextStyle get h2Primary => h2.copyWith(color: AppColors.primary);
  static TextStyle get h3Primary => h3.copyWith(color: AppColors.primary);
  static TextStyle get h4Primary => h4.copyWith(color: AppColors.primary);
  
  static TextStyle get bodyLargeSecondary => bodyLarge.copyWith(color: AppColors.textSecondary);
  static TextStyle get bodyMediumSecondary => bodyMedium.copyWith(color: AppColors.textSecondary);
  
  static TextStyle get labelLargePrimary => labelLarge.copyWith(color: AppColors.primary);
  static TextStyle get labelMediumPrimary => labelMedium.copyWith(color: AppColors.primary);
  static TextStyle get labelSmallPrimary => labelSmall.copyWith(color: AppColors.primary);
} 