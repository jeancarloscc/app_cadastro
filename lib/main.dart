import 'package:app_cadastro/screens/login.dart';
import 'package:app_cadastro/screens/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'color_schemes.g.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  User? user = FirebaseAuth.instance.currentUser;
  String adminId = getAdminId();
  runApp(MyApp(user: user, adminId: adminId));
}

String getAdminId() {
  String? adminId = FirebaseAuth.instance.currentUser?.uid;
  if (adminId == null) {
    return '';
  }

  return adminId;
}

class MyApp extends StatelessWidget {
  final User? user;
  final String adminId;

  const MyApp({Key? key, this.user, required this.adminId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true, colorScheme: lightColorScheme),
      darkTheme: ThemeData(useMaterial3: true, colorScheme: darkColorScheme),
      home: user != null ? HomeScreen(adminId: adminId) : LoginScreen(),
    );
  }
}
