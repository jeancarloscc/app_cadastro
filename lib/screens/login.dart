import 'package:app_cadastro/screens/home.dart';
import 'package:flutter/material.dart';

import '../services/login.dart';
import 'cadastroAdmin.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  final AuthService _authService = AuthService();

  bool isEntrando = true;

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
                  Text("Acessar Conta", style: TextStyle(
                    color: Color(0xFFB4007E),
                    fontSize: 40,
                  ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 70,),
                  TextFormField(
                    keyboardType: TextInputType.text,
                    obscureText: false,
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: "Usuária",
                      border: OutlineInputBorder(),
                      icon: Icon(Icons.person),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, insira o e-mail';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 40,),
                  TextFormField(
                    keyboardType: TextInputType.text,
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
                  SizedBox(height: 100,),
                  FilledButton(
                    onPressed: () {
                      botaoEnviarClicado();
                    },
                    child: Text("ENTRAR"),
                  ),
                  OutlinedButton(onPressed: (){
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => CadastroAdmin(),
                      ),
                    );
                  },
                      child: Text("CADASTRO"))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void botaoEnviarClicado() async {
    if (_formKey.currentState!.validate()) {
      final String email = _emailController.text;
      final String senha = _senhaController.text;

      if (isEntrando) {
        // Chamar o método de login do AuthService
        final user = await _authService.signInWithEmailAndPassword(email, senha);
        if (user != null) {
          // Login bem-sucedido
          // Navegar para a próxima tela ou realizar outras ações necessárias
          String adminId = user.uid;
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (_) => HomeScreen(adminId: adminId),
            ),
          );
        } else {
          // Login falhou
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              action: SnackBarAction(
                label: 'OK',
                onPressed: () {
                  // Code to execute.
                },
              ),
              content: Text('Usuário ou senha inválida'),
              duration: const Duration(milliseconds: 3000),
              width: 280.0,
              padding: const EdgeInsets.symmetric(
                horizontal: 8.0,
              ),
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
          );
        }
      }
    }
  }
}
