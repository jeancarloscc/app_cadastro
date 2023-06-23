import 'package:cpf_cnpj_validator/cpf_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:intl/intl.dart';

import '../models/usuario.dart';
import '../services/FirebaseDatabaseService.dart';
import 'home.dart';

class CadastroHome extends StatelessWidget {
  CadastroHome({super.key});

  final _cpfController = MaskedTextController(mask: '000.000.000-00');
  final _dataNascimentoController = MaskedTextController(mask: '00/00/0000');
  Usuario usuario = Usuario();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cadastro de Usuáio"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
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
                SizedBox(
                  height: 8,
                ),
                TextFormField(
                  keyboardType: TextInputType.text,
                  obscureText: false,
                  onChanged: (value) {
                    usuario.nome = value;
                  },
                  validator: (value) => validateTextField(value, 'Nome'),
                  decoration: InputDecoration(
                    labelText: "Nome",
                    border: OutlineInputBorder(),
                    icon: Icon(Icons.person),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  obscureText: false,
                  onChanged: (value) {
                    usuario.numRegistro = int.parse(value);
                  },
                  validator: (value) => validateTextField(value, 'NumRegistro'),
                  decoration: InputDecoration(
                    labelText: "Registro Avon",
                    border: OutlineInputBorder(),
                    icon: Icon(Icons.assignment_ind_outlined),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                TextFormField(
                  keyboardType: TextInputType.text,
                  obscureText: false,
                  onChanged: (value) {
                    usuario.senha = value;
                  },
                  validator: (value) => validateTextField(value, 'Senha'),
                  decoration: InputDecoration(
                    labelText: "Senha",
                    border: OutlineInputBorder(),
                    icon: Icon(Icons.key_outlined),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                TextFormField(
                  controller: _cpfController,
                  keyboardType: TextInputType.number,
                  obscureText: false,
                  onChanged: (value) {
                    usuario.cpf = value;
                  },
                  validator: (value) => validateTextField(value, 'CPF'),
                  decoration: InputDecoration(
                    labelText: "CPF",
                    border: OutlineInputBorder(),
                    icon: Icon(Icons.assignment_outlined),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  obscureText: false,
                  onChanged: (value) {
                    usuario.rg = int.parse(value);
                  },
                  validator: (value) => validateTextField(value, 'RG'),
                  decoration: InputDecoration(
                    labelText: "Identidade",
                    border: OutlineInputBorder(),
                    icon: Icon(Icons.badge_outlined),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                TextFormField(
                  controller: _dataNascimentoController,
                  keyboardType: TextInputType.datetime,
                  obscureText: false,
                  onChanged: (value) {
                    usuario.dataNascimento = value;
                  },
                  validator: (value) =>
                      validateTextField(value, 'DataNascimento'),
                  decoration: InputDecoration(
                    labelText: "Data de Nascimento",
                    border: OutlineInputBorder(),
                    icon: Icon(Icons.cake_outlined),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                FilledButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        Usuario novoUsuario = Usuario(
                          numRegistro: usuario.numRegistro,
                          cpf: usuario.cpf,
                          rg: usuario.rg,
                          nome: usuario.nome,
                          senha: usuario.senha,
                          dataNascimento: usuario.dataNascimento,
                        );
                        FirebaseUtils.salvarUsuario(novoUsuario);
                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (_) => HomeScreen()),
                          (route) => false,
                        );
                        // if (pet != null) {
                        //   service.editPet(pet.id, newPet);
                        // } else {
                        //   service.addPet(newPet);
                        // }
                        // _usuariosRef.push().set(novoUsuario.toMap());

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            action: SnackBarAction(
                              label: 'OK',
                              onPressed: () {
                                // Code to execute.
                              },
                            ),
                            content: Text('Salvo com Sucesso'),
                            duration: const Duration(milliseconds: 3000),
                            width: 280.0,
                            // Width of the SnackBar.
                            padding: const EdgeInsets.symmetric(
                              horizontal:
                                  8.0, // Inner padding for SnackBar content.
                            ),
                            behavior: SnackBarBehavior.floating,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        );
                      }
                      ;
                    },
                    child: Text("SALVAR"))
              ],
            ),
          ),
        ),
      ),
    );
  }

  String? validateTextField(dynamic value, String fieldName) {
    if (value == null || value.toString().isEmpty) {
      return 'Campo obrigatório';
    }

    // Validação específica para cada campo
    if (fieldName == 'NumRegistro') {
      if (int.tryParse(value) == null) {
        return 'Número de registro inválido';
      }
    } else if (fieldName == 'CPF') {
      if (!CPFValidator.isValid(value)) {
        return 'CPF inválido';
      }
    } else if (fieldName == 'RG') {
      if (int.tryParse(value) == null) {
        return 'RG inválido';
      }
    } else if (fieldName == 'Nome') {
      if (value is! String) {
        return 'Nome inválido';
      }
    } else if (fieldName == 'Senha') {
      if (value is! String || value.length < 6) {
        return 'A senha deve ter no mínimo 6 caracteres';
      }
    } else if (fieldName == 'DataNascimento') {
      if (value is! String) {
        return 'Data de nascimento inválida';
      }
      // Adicione aqui as suas regras de validação específicas para a data de nascimento
    }

    return null; // A validação passou
  }
}
