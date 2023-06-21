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
  // late Future<Login> _loadLogin;
  // late Login _login;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Center(
            child: Form(
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
                    decoration: InputDecoration(
                      labelText: "Senha",
                      border: OutlineInputBorder(),
                      icon: Icon(Icons.lock),
                    ),
                  ),
                  SizedBox(height: 200,),
                  FilledButton(
                      onPressed: () {},
                      child: Text("ENTRAR"))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
