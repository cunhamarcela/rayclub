import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:ui';
import '../../core/widgets/custom_button.dart';
import '../../providers/auth_provider.dart';
import '../../core/constants.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              theme.colorScheme.primary,
              theme.colorScheme.primary.withOpacity(0.8),
              theme.colorScheme.tertiary.withOpacity(0.6),
            ],
          ),
        ),
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                child: Container(
                  constraints: BoxConstraints(
                    minHeight: constraints.maxHeight,
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: constraints.maxWidth > 600 ? 
                        constraints.maxWidth * 0.2 : 24,
                    vertical: 24,
                  ),
                  child: FadeTransition(
                    opacity: _fadeAnimation,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Logo animado
                        TweenAnimationBuilder(
                          duration: const Duration(milliseconds: 800),
                          tween: Tween<double>(begin: 0, end: 1),
                          builder: (context, double value, child) {
                            return Transform.scale(
                              scale: value,
                              child: Container(
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: theme.colorScheme.secondary.withOpacity(0.1),
                                ),
                                child: Icon(
                                  Icons.sports_basketball,
                                  size: 80,
                                  color: theme.colorScheme.secondary,
                                ),
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 32),
                        
                        // Título com efeito de sombra
                        Text(
                          'RayClub',
                          style: theme.textTheme.displayLarge?.copyWith(
                            color: theme.colorScheme.secondary,
                            shadows: [
                              Shadow(
                                color: Colors.black.withOpacity(0.3),
                                offset: const Offset(2, 2),
                                blurRadius: 4,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 48),
                        
                        // Card com efeito de vidro
                        Card(
                          elevation: 8,
                          shadowColor: Colors.black.withOpacity(0.3),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(24),
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.8),
                                  borderRadius: BorderRadius.circular(24),
                                  border: Border.all(
                                    color: Colors.white.withOpacity(0.2),
                                    width: 1.5,
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(32.0),
                                  child: Form(
                                    key: _formKey,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.stretch,
                                      children: [
                                        // Campos de texto estilizados
                                        _buildTextField(
                                          controller: _emailController,
                                          label: 'Email',
                                          icon: Icons.email,
                                          theme: theme,
                                        ),
                                        const SizedBox(height: 16),
                                        _buildTextField(
                                          controller: _passwordController,
                                          label: 'Senha',
                                          icon: Icons.lock,
                                          isPassword: true,
                                          theme: theme,
                                        ),
                                        const SizedBox(height: 32),
                                        
                                        // Botões com efeitos
                                        Consumer<AuthProvider>(
                                          builder: (context, authProvider, _) {
                                            return CustomButton(
                                              text: 'Entrar',
                                              isLoading: authProvider.isLoading,
                                              onPressed: () {
                                                if (_formKey.currentState!.validate()) {
                                                  authProvider.signInWithEmailPassword(
                                                    _emailController.text,
                                                    _passwordController.text,
                                                  );
                                                }
                                              },
                                              backgroundColor: theme.colorScheme.primary,
                                              elevation: 4,
                                              shadowColor: theme.colorScheme.primary.withOpacity(0.4),
                                            );
                                          },
                                        ),
                                        const SizedBox(height: 16),
                                        CustomButton(
                                          text: 'Entrar com Google',
                                          icon: Icons.g_mobiledata,
                                          backgroundColor: Colors.white,
                                          textColor: Colors.black87,
                                          onPressed: () {
                                            context.read<AuthProvider>().signInWithGoogle();
                                          },
                                          elevation: 2,
                                          border: Border.all(color: Colors.grey.shade300),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        
                        // Links estilizados
                        const SizedBox(height: 24),
                        _buildStyledLink(
                          'Esqueceu sua senha?',
                          onTap: () => Navigator.pushNamed(context, AppConstants.resetPasswordRoute),
                          theme: theme,
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Não tem uma conta?',
                              style: TextStyle(
                                color: theme.colorScheme.secondary,
                                fontSize: 16,
                              ),
                            ),
                            _buildStyledLink(
                              'Registre-se',
                              onTap: () => Navigator.pushNamed(context, AppConstants.registerRoute),
                              theme: theme,
                              isBold: true,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    required ThemeData theme,
    bool isPassword = false,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: isPassword,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(
          icon,
          color: theme.colorScheme.primary,
        ),
        filled: true,
        fillColor: Colors.white.withOpacity(0.9),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: theme.colorScheme.primary.withOpacity(0.2),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: theme.colorScheme.primary,
            width: 2,
          ),
        ),
        labelStyle: TextStyle(
          color: theme.colorScheme.primary.withOpacity(0.8),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Por favor, preencha este campo';
        }
        return null;
      },
    );
  }

  Widget _buildStyledLink(
    String text, {
    required VoidCallback onTap,
    required ThemeData theme,
    bool isBold = false,
  }) {
    return TextButton(
      onPressed: onTap,
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: theme.colorScheme.tertiary,
          fontSize: 16,
          fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }
} 