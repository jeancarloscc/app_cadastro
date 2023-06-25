import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Login com e-mail e senha
  Future<User?> signInWithEmailAndPassword(String email, String password) async {
    try {
      final UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } catch (e) {
      print('Erro durante o login: $e');
      return null;
    }
  }

  // Criar usuário com e-mail e senha
  Future<User?> createUserWithEmailAndPassword(String email, String password) async {
    try {
      final UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } catch (e) {
      print('Erro durante a criação do usuário: $e');
      return null;
    }
  }

  // Atualizar senha do usuário
  Future<void> updatePassword(String newPassword) async {
    try {
      final User? user = _auth.currentUser;
      if (user != null) {
        await user.updatePassword(newPassword);
      }
    } catch (e) {
      print('Erro durante a atualização da senha: $e');
    }
  }

  // Redefinir senha do usuário (enviar e-mail de redefinição de senha)
  Future<void> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      print('Erro durante a redefinição de senha: $e');
    }
  }

  // Enviar e-mail de verificação a um usuário
  Future<void> sendEmailVerification() async {
    try {
      final User? user = _auth.currentUser;
      if (user != null && !user.emailVerified) {
        await user.sendEmailVerification();
      }
    } catch (e) {
      print('Erro durante o envio do e-mail de verificação: $e');
    }
  }

  // Manter o estado da autenticação
  Stream<User?> get authStateChanges => _auth.authStateChanges();
}
