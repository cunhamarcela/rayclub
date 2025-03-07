import 'package:flutter/material.dart';
import '../features/auth/login_screen.dart';
import '../features/auth/register_screen.dart';
import '../features/auth/reset_password_screen.dart';
import '../features/home/home_screen.dart';
import '../presentation/widgets/theme_showcase_widget.dart';
import 'constants.dart';

class AppRoutes {
  static Map<String, WidgetBuilder> getRoutes() {
    return {
      AppConstants.loginRoute: (context) => const LoginScreen(),
      AppConstants.registerRoute: (context) => const RegisterScreen(),
      AppConstants.resetPasswordRoute: (context) => const ResetPasswordScreen(),
      AppConstants.homeRoute: (context) => const HomeScreen(),
      AppConstants.themeShowcaseRoute: (context) => const ThemeShowcaseWidget(),
    };
  }
} 