import 'package:flutter/material.dart';

/// Classe que define as cores do aplicativo
class AppColors {
  // Cores primárias
  static const Color primary = Color(0xFF3D5A80);      // Azul profundo
  static const Color primaryLight = Color(0xFF98C1D9); // Azul claro
  static const Color primaryDark = Color(0xFF293241);  // Azul escuro
  
  // Cores secundárias
  static const Color secondary = Color(0xFFEE6C4D);    // Coral
  static const Color secondaryLight = Color(0xFFF7A58B); // Coral claro
  static const Color secondaryDark = Color(0xFFD64325);  // Coral escuro
  
  // Cores de fundo
  static const Color background = Color(0xFFF8F9FA);   // Cinza muito claro
  static const Color surface = Color(0xFFFFFFFF);      // Branco
  static const Color surfaceVariant = Color(0xFFE9ECEF); // Cinza claro
  
  // Cores de texto
  static const Color textPrimary = Color(0xFF212529);  // Quase preto
  static const Color textSecondary = Color(0xFF6C757D); // Cinza médio
  static const Color textDisabled = Color(0xFFADB5BD);  // Cinza claro
  static const Color textOnPrimary = Color(0xFFFFFFFF); // Branco
  static const Color textOnSecondary = Color(0xFFFFFFFF); // Branco
  
  // Cores de estado
  static const Color success = Color(0xFF40916C);      // Verde
  static const Color warning = Color(0xFFFFB703);      // Amarelo
  static const Color error = Color(0xFFE63946);        // Vermelho
  static const Color info = Color(0xFF457B9D);         // Azul info
  
  // Cores de gradiente
  static const List<Color> primaryGradient = [primaryLight, primary];
  static const List<Color> secondaryGradient = [secondaryLight, secondary];
  
  // Cores de sombra
  static const Color shadow = Color(0x40000000);
  
  // Cores de overlay
  static const Color overlay = Color(0x80000000);
  
  // Cores específicas de componentes
  static const Color divider = Color(0xFFDEE2E6);
  static const Color cardBackground = Color(0xFFFFFFFF);
  static const Color shimmerBase = Color(0xFFE9ECEF);
  static const Color shimmerHighlight = Color(0xFFF8F9FA);
  
  // Cores específicas para fitness
  static const Color energy = Color(0xFFFB8500);       // Laranja energia
  static const Color calm = Color(0xFF8ECAE6);         // Azul calmo
  static const Color intensity = Color(0xFFE76F51);    // Vermelho intensidade
  static const Color achievement = Color(0xFFFFD166);  // Amarelo conquista
} 