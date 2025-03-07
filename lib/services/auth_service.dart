import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../core/constants.dart';
import '../core/utils/connection_checker.dart';
import '../models/user_model.dart';
import 'user_service.dart';

class AuthException implements Exception {
  final String message;
  AuthException(this.message);
}

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    clientId: dotenv.env['GOOGLE_CLIENT_ID'],
  );
  final UserService _userService = UserService();

  // Stream para monitorar mudanças no estado de autenticação
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  Future<UserCredential?> signInWithGoogle() async {
    if (!await ConnectionChecker.hasConnection()) {
      throw AuthException('Sem conexão com a internet');
    }
    
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      
      if (googleUser == null) {
        throw AuthException('Login cancelado pelo usuário');
      }

      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth = 
          await googleUser.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Once signed in, return the UserCredential
      return await _auth.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      throw AuthException(_getErrorMessage(e.code));
    } catch (e) {
      if (e is AuthException) rethrow;
      throw AuthException(AppConstants.errorAuth);
    }
  }

  Future<void> signOut() async {
    try {
      await Future.wait([
        _auth.signOut(),
        _googleSignIn.signOut(),
      ]);
    } catch (e) {
      throw AuthException('Erro ao fazer logout');
    }
  }

  // Registro com email/senha
  Future<UserCredential> registerWithEmailPassword(String email, String password) async {
    if (!await ConnectionChecker.hasConnection()) {
      throw AuthException('Sem conexão com a internet');
    }

    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      
      // Criar usuário no Firestore
      if (userCredential.user != null) {
        final user = UserModel(
          id: userCredential.user!.uid,
          email: email,
          name: null,
          photoUrl: null,
          isPremium: false,
        );
        await _userService.createUser(user);
      }
      
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw AuthException(_getErrorMessage(e.code));
    } catch (e) {
      throw AuthException(AppConstants.errorAuth);
    }
  }

  // Login com email/senha
  Future<UserCredential> signInWithEmailPassword(String email, String password) async {
    if (!await ConnectionChecker.hasConnection()) {
      throw AuthException('Sem conexão com a internet');
    }

    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw AuthException(_getErrorMessage(e.code));
    } catch (e) {
      throw AuthException(AppConstants.errorAuth);
    }
  }

  // Recuperação de senha
  Future<void> resetPassword(String email) async {
    if (!await ConnectionChecker.hasConnection()) {
      throw AuthException('Sem conexão com a internet');
    }

    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw AuthException(_getErrorMessage(e.code));
    } catch (e) {
      throw AuthException(AppConstants.errorAuth);
    }
  }

  String _getErrorMessage(String code) {
    switch (code) {
      case 'account-exists-with-different-credential':
        return 'Esta conta existe com um método de login diferente';
      case 'invalid-credential':
        return 'Credencial inválida';
      case 'operation-not-allowed':
        return 'Operação não permitida';
      case 'user-disabled':
        return 'Usuário desabilitado';
      case 'user-not-found':
        return 'Usuário não encontrado';
      case 'email-already-in-use':
        return 'Este email já está em uso';
      case 'invalid-email':
        return 'Email inválido';
      case 'weak-password':
        return 'Senha muito fraca';
      case 'wrong-password':
        return 'Senha incorreta';
      default:
        return AppConstants.errorGeneric;
    }
  }
} 