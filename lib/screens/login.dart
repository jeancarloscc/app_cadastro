import 'package:app_cadastro/models/admin.dart';
import 'package:app_cadastro/models/usuario.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


import '../services/login.dart';


class LoginScreen extends StatefulWidget {
  // int idLogin;
  // String senhaUsuario;

  // LoginScreen({required this.idLogin, required this.senhaUsuario});
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();
  final TextEditingController _confirmaController = TextEditingController();
  final TextEditingController _nomeController = TextEditingController();

  bool isEntrando = true;

  final _formKey = GlobalKey<FormState>();

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
                  SizedBox(height: 100,),
                  TextField(
                    keyboardType: TextInputType.text,
                    obscureText: false,
                    controller: _nomeController,
                    // onChanged: (value){
                    //   email = value;
                    // },
                    decoration: InputDecoration(
                        labelText: "Usuária",
                        border: OutlineInputBorder(),
                      icon: Icon(Icons.person),
                    ),
                  ),
                  SizedBox(height: 40,),
                  TextField(
                    keyboardType: TextInputType.text,
                    obscureText: true,
                    controller: _senhaController,
                    // onChanged: (value){
                    //   senha = value;
                    // },
                    decoration: InputDecoration(
                      labelText: "Senha",
                      border: OutlineInputBorder(),
                      icon: Icon(Icons.lock),
                    ),
                  ),
                  SizedBox(height: 200,),
                  FilledButton(
                      onPressed: () {
                        botaoEnviarClicado();
                      },
                      child: Text("ENTRAR"))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  botaoEnviarClicado() {
    String email = _emailController.text;
    String senha = _senhaController.text;
    String nome = _nomeController.text;

    if (_formKey.currentState!.validate()) {
      if (isEntrando) {
        _entrarUsuario(email: email, senha: senha);
      } else {
        _criarUsuario(email: email, senha: senha, nome: nome);
      }
    }
  }

  _entrarUsuario({required String email, required String senha}) {
    print("Entrar usuário $email, $senha");
  }

  _criarUsuario(
      {required String email, required String senha, required String nome}) {
    print("Criar usuário $email, $senha, $nome");
  }
}

