import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/usuario.dart';

class FirebaseUtils {
  static FirebaseFirestore db = FirebaseFirestore.instance;

  static Future<void> salvarUsuario(Usuario usuario) async {
    try {
      DocumentReference docRef = db.collection('usuarios').doc();
      await docRef.set(usuario.toMap());
    } catch (e) {
      print('Erro ao salvar usuário: $e');
    }
  }
}
