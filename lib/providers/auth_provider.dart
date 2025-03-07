import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/auth_service.dart';
import '../core/constants.dart';
import 'user_provider.dart';
import '../main.dart'; // Para acessar o navigatorKey
import 'package:provider/provider.dart';

class AuthProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();
  User? _user;
  bool _isLoading = false;
  String? _error;

  User? get user => _user;
  bool get isLoading => _isLoading;
  String? get error => _error;

  AuthProvider() {
    _authService.authStateChanges.listen((User? user) {
      _user = user;
      if (user != null) {
        _handleAuthSuccess(user);
      }
      notifyListeners();
    });
  }

  Future<void> signInWithGoogle() async {
    try {
      _error = null;
      _isLoading = true;
      notifyListeners();
      
      final credential = await _authService.signInWithGoogle();
      if (credential?.user != null) {
        await _handleAuthSuccess(credential!.user!);
      }
    } on AuthException catch (e) {
      _error = e.message;
    } catch (e) {
      _error = AppConstants.errorGeneric;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> registerWithEmailPassword(String email, String password) async {
    try {
      _error = null;
      _isLoading = true;
      notifyListeners();
      
      final credential = await _authService.registerWithEmailPassword(email, password);
      if (credential.user != null) {
        await _handleAuthSuccess(credential.user!);
      }
    } on AuthException catch (e) {
      _error = e.message;
    } catch (e) {
      _error = AppConstants.errorGeneric;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> signInWithEmailPassword(String email, String password) async {
    try {
      _error = null;
      _isLoading = true;
      notifyListeners();
      
      final credential = await _authService.signInWithEmailPassword(email, password);
      if (credential.user != null) {
        await _handleAuthSuccess(credential.user!);
      }
    } on AuthException catch (e) {
      _error = e.message;
    } catch (e) {
      _error = AppConstants.errorGeneric;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> resetPassword(String email) async {
    try {
      _error = null;
      _isLoading = true;
      notifyListeners();
      
      await _authService.resetPassword(email);
    } on AuthException catch (e) {
      _error = e.message;
    } catch (e) {
      _error = AppConstants.errorGeneric;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> signOut() async {
    try {
      _error = null;
      _isLoading = true;
      notifyListeners();
      
      await _authService.signOut();
    } on AuthException catch (e) {
      _error = e.message;
    } catch (e) {
      _error = AppConstants.errorGeneric;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }

  Future<void> _handleAuthSuccess(User user) async {
    try {
      if (navigatorKey.currentContext != null) {
        final userProvider = Provider.of<UserProvider>(
          navigatorKey.currentContext!,
          listen: false,
        );
        
        // Carregar dados do usuário
        await userProvider.loadUser(user.uid);
        
        // Iniciar monitoramento de mudanças
        userProvider.startListeningToUser(user.uid);
        
        // Verificar expiração premium (apenas se o usuário já estiver carregado)
        if (userProvider.user != null) {
          userProvider.checkPremiumExpiry(user.uid);
        }
      }
    } catch (e) {
      print('Erro ao carregar dados do usuário: $e');
    }
  }
} 