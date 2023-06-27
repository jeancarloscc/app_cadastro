import 'package:app_cadastro/screens/home.dart';
import 'package:flutter/material.dart';

import '../services/FirebaseDatabaseService.dart';
import '../services/login.dart';
import 'home.dart';

class CadastroAdmin extends StatefulWidget {
  @override
  _CadastroAdminState createState() => _CadastroAdminState();
}

class _CadastroAdminState extends State<CadastroAdmin> {
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Center(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 100,),
                  Text(
                    "Cadastro de Administrador",
                    style: TextStyle(
                      color: Color(0xFFB4007E),
                      fontSize: 40,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 70,),
                  TextFormField(
                    keyboardType: TextInputType.text,
                    controller: _nomeController,
                    decoration: InputDecoration(
                      labelText: "Nome",
                      border: OutlineInputBorder(),
                      icon: Icon(Icons.person),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, insira o nome';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20,),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: "E-mail",
                      border: OutlineInputBorder(),
                      icon: Icon(Icons.email),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, insira o e-mail';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20,),
                  TextFormField(
                    obscureText: true,
                    controller: _senhaController,
                    decoration: InputDecoration(
                      labelText: "Senha",
                      border: OutlineInputBorder(),
                      icon: Icon(Icons.lock),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, insira a senha';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 80,),
                  FilledButton(
                    onPressed: () {
                      botaoCadastrarClicado();
                    },
                    child: Text("CADASTRAR"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void showAlertDialog(BuildContext context, String title, String content) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop(); // Fecha o diálogo
              },
            ),
          ],
        );
      },
    );
  }

  void botaoCadastrarClicado() async {
    if (_formKey.currentState!.validate()) {
      final String nome = _nomeController.text;
      final String email = _emailController.text;
      final String senha = _senhaController.text;

      final user = await _authService.createUserWithEmailAndPassword(email, senha);

      if (user != null) {
        String adminId = user.uid;
        FirestoreService.saveAdminName(adminId, nome);
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => HomeScreen(adminId: adminId),
          ),
        );
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Falha ao criar um novo Administrador'),
              content: Text('E-mail já está cadastrado!.'),
              actions: <Widget>[
                TextButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop(); // Fechar o diálogo
                  },
                ),
              ],
            );
          },
        );
      }
    }
  }
}
