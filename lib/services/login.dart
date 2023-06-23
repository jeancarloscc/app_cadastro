// import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_auth/firebase_auth.dart';
//
// import '../models/admin.dart';
//
// class FirebaseLogin {
//   FirebaseAuth auth = FirebaseAuth.instance;
//
//   static Future<void> CriarAdmin(Admin admin) async {
//     /* Criando usuário com e-mail e senha */
//     String email = admin.email;
//     String senha = admin.senha;
//
//     try {
//       final UserCredential userCredential = await FirebaseAuth.instance
//           .createUserWithEmailAndPassword(
//         email: email,
//         password: senha,
//       );
//
//       // // Acesso ao usuário criado
//       // final User? user = userCredential.user;
//       //
//       // // Resto do código...
//
//     } on FirebaseAuthException catch (e) {
//       if (e.code == 'weak-password') {
//         print('The password provided is too weak.');
//       } else if (e.code == 'email-already-in-use') {
//         print('The account already exists for that email.');
//       }
//     } catch (e) {
//       print(e);
//     }
//   }
// }