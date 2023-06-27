import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/Revendedor.dart';

class FirestoreService {
  static Future<void> saveReseller(String adminId, Revendedor revendedor
      ) async {
    try {
      await FirebaseFirestore.instance
          .collection('admins')
          .doc(adminId)
          .collection('resellers')
          .add({
        'numRegistro': revendedor.numRegistro,
        'cpf': revendedor.cpf,
        'rg': revendedor.rg,
        'nome': revendedor.nome,
        'senha': revendedor.senha,
        'dataNascimento': revendedor.dataNascimento,
      });
    } catch (error) {
      throw error;
    }
  }

  static Future<void> updateReseller(
      String adminId,
      String resellerId,
      int numRegistro,
      String cpf,
      int rg,
      String nome,
      String senha,
      String dataNascimento,
      ) async {
    try {
      await FirebaseFirestore.instance
          .collection('admins')
          .doc(adminId)
          .collection('resellers')
          .doc(resellerId)
          .update({
        'numRegistro': numRegistro,
        'cpf': cpf,
        'rg': rg,
        'nome': nome,
        'senha': senha,
        'dataNascimento': dataNascimento,
      });
    } catch (error) {
      throw error;
    }
  }

  static Future<void> deleteReseller(String adminId, String resellerId) async {
    try {
      await FirebaseFirestore.instance
          .collection('admins')
          .doc(adminId)
          .collection('resellers')
          .doc(resellerId)
          .delete();
    } catch (error) {
      throw error;
    }
  }

  static Stream<QuerySnapshot> getResellers(String adminId) {
    try {
      return FirebaseFirestore.instance
          .collection('admins')
          .doc(adminId)
          .collection('resellers')
          .snapshots();
    } catch (error) {
      throw error;
    }
  }

  //Cadastro de novo usuário, mas aqui apenas salva o nome do admin
  static Future<void> saveAdminName(String adminId, String nome) async {
    await FirebaseFirestore.instance
        .collection('admins')
        .doc(adminId)
        .set({'nome': nome}, SetOptions(merge: true));
  }

  // Verificar a existência de um e-mail cadastrado
  static Future<bool> isEmailAlreadyRegistered(String email) async {
    QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance
        .collection('admins')
        .where('email', isEqualTo: email)
        .limit(1)
        .get();

    return snapshot.size > 0;
  }

}
