import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';

import '../models/usuario.dart';
import '../services/FirebaseDatabaseService.dart';

class CadastroHome extends StatelessWidget {
  CadastroHome({super.key});

  final _cpfController = MaskedTextController(mask: '000.000.000-00');
  FirebaseDatabase _database = FirebaseDatabase.instance;

  FirebaseDatabaseService databaseService = FirebaseDatabaseService();

  DatabaseReference ref = FirebaseDatabase.instance.ref("users");

  Usuario? usuario;
  // Usuario usuario = Usuario();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cadastro de Usuáio"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              // Container(
              //   width: 150,
              //   height: 150,
              //   decoration: BoxDecoration(
              //     shape: BoxShape.circle,
              //     image: DecorationImage(
              //       image: AssetImage('caminho/para/a/imagem.png'),
              //       fit: BoxFit.cover,
              //     ),
              //   ),
              // ),
              CircleAvatar(
                radius: 60,
                child: Icon(
                  Icons.person_add,
                  size: 75,
                ),
              ),
              SizedBox(height: 8,),
              TextField(
                keyboardType: TextInputType.text,
                obscureText: false,
                onChanged: (value){
                  usuario?.nome = value;
                },
                decoration: InputDecoration(
                  labelText: "Nome",
                  border: OutlineInputBorder(),
                  icon: Icon(Icons.person),
                ),
              ),
              SizedBox(height: 8,),
              TextField(
                keyboardType: TextInputType.number,
                obscureText: false,
                onChanged: (value){
                  usuario?.num_registro = value as int;
                },
                decoration: InputDecoration(
                  labelText: "Registro Avon",
                  border: OutlineInputBorder(),
                  icon: Icon(Icons.assignment_ind_outlined),
                ),
              ),
              SizedBox(height: 8,),
              TextField(
                keyboardType: TextInputType.text,
                obscureText: false,
                onChanged: (value){
                  usuario?.senha = value;
                },
                decoration: InputDecoration(
                  labelText: "Senha",
                  border: OutlineInputBorder(),
                  icon: Icon(Icons.key_outlined),
                ),
              ),
              SizedBox(height: 8,),
              TextField(
                controller: _cpfController,
                keyboardType: TextInputType.number,
                obscureText: false,
                onChanged: (value){
                  usuario?.cpf = value as int;
                },
                decoration: InputDecoration(
                  labelText: "CPF",
                  border: OutlineInputBorder(),
                  icon: Icon(Icons.assignment_outlined),
                ),
              ),
              SizedBox(height: 8,),
              TextField(
                keyboardType: TextInputType.number,
                obscureText: false,
                onChanged: (value){
                  usuario?.rg = value as int;
                },
                decoration: InputDecoration(
                  labelText: "Identidade",
                  border: OutlineInputBorder(),
                  icon: Icon(Icons.badge_outlined),
                ),
              ),
              SizedBox(height: 8,),
              TextField(
                keyboardType: TextInputType.datetime,
                obscureText: false,
                onChanged: (value){
                  usuario?.data_nascimento = value;
                },
                decoration: InputDecoration(
                  labelText: "Data de Nascimento",
                  border: OutlineInputBorder(),
                  icon: Icon(Icons.cake_outlined),
                ),
              ),
              SizedBox(height: 10,),
              FilledButton(
                  onPressed: () {
                    if (usuario != null){
                      saveFormData(usuario!);
                    }
                  },
                  child: Text("SALVAR"))
            ],
          ),
        ),
      ),
    );
  }

  void saveFormData(Usuario usuario) async {
    try {
      await databaseService.writeData('users', {
        'nome': usuario.nome,
        'registroAvon': usuario.num_registro,
        'senha': usuario.senha,
        'cpf': usuario.cpf,
        'identidade': usuario.rg,
        'dataNascimento': usuario.data_nascimento,
      });
      print('Dados salvos com sucesso!');
    } catch (error) {
      print('Erro ao salvar os dados: $error');
    }
  }
}
