import 'package:cpf_cnpj_validator/cpf_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';

import '../models/Revendedor.dart';
import '../services/FirebaseDatabaseService.dart';

import 'home.dart';

class CadastroReseller extends StatefulWidget {
  final String adminId;
  const CadastroReseller({Key? key, required this.adminId}) : super(key: key);

  @override
  _CadastroResellerState createState() => _CadastroResellerState();
}

class _CadastroResellerState extends State<CadastroReseller> {
  final _cpfController = MaskedTextController(mask: '000.000.000-00');
  final _dataNascimentoController = MaskedTextController(mask: '00/00/0000');
  final _formKey = GlobalKey<FormState>();
  late Revendedor _reseller;

  @override
  void initState() {
    super.initState();
    _reseller = Revendedor();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro de Revendedor'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                CircleAvatar(
                  radius: 60,
                  child: Icon(
                    Icons.person_add,
                    size: 75,
                  ),
                ),
                SizedBox(height: 8),
                TextFormField(
                  keyboardType: TextInputType.text,
                  obscureText: false,
                  onChanged: (value) {
                    _reseller.nome = value;
                  },
                  validator: (value) => validateTextField(value, 'Nome'),
                  decoration: InputDecoration(
                    labelText: 'Nome',
                    border: OutlineInputBorder(),
                    icon: Icon(Icons.person),
                  ),
                ),
                SizedBox(height: 8),
                TextFormField(
                  keyboardType: TextInputType.number,
                  obscureText: false,
                  onChanged: (value) {
                    _reseller.numRegistro = int.tryParse(value);
                  },
                  validator: (value) => validateTextField(value, 'NumRegistro'),

                  decoration: InputDecoration(
                    labelText: 'Registro Avon',
                    border: OutlineInputBorder(),
                    icon: Icon(Icons.assignment_ind_outlined),
                  ),
                ),
                SizedBox(height: 8),
                TextFormField(
                  keyboardType: TextInputType.text,
                  obscureText: true,
                  onChanged: (value) {
                    _reseller.senha = value;
                  },
                  validator: (value) => validateTextField(value, 'Senha'),
                  decoration: InputDecoration(
                    labelText: 'Senha',
                    border: OutlineInputBorder(),
                    icon: Icon(Icons.key_outlined),
                  ),
                ),
                SizedBox(height: 8),
                TextFormField(
                  controller: _cpfController,
                  keyboardType: TextInputType.number,
                  obscureText: false,
                  onChanged: (value) {
                    _reseller.cpf = value;
                  },
                  validator: (value) => validateTextField(value, 'CPF'),
                  decoration: InputDecoration(
                    labelText: 'CPF',
                    border: OutlineInputBorder(),
                    icon: Icon(Icons.assignment_outlined),
                  ),
                ),
                SizedBox(height: 8),
                TextFormField(
                  keyboardType: TextInputType.number,
                  obscureText: false,
                  onChanged: (value) {
                    _reseller.rg = int.tryParse(value);
                  },
                  validator: (value) => validateTextField(value, 'RG'),

                  decoration: InputDecoration(
                    labelText: 'Identidade',
                    border: OutlineInputBorder(),
                    icon: Icon(Icons.badge_outlined),
                  ),
                ),
                SizedBox(height: 8),
                TextFormField(
                  controller: _dataNascimentoController,
                  keyboardType: TextInputType.datetime,
                  obscureText: false,
                  onChanged: (value) {
                    _reseller.dataNascimento = value;
                  },
                  validator: (value) => validateTextField(value, 'DataNascimento'),
                  decoration: InputDecoration(
                    labelText: 'Data de Nascimento',
                    border: OutlineInputBorder(),
                    icon: Icon(Icons.cake_outlined),
                  ),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      final novoRevendedor = Revendedor(
                        numRegistro: _reseller.numRegistro,
                        cpf: _reseller.cpf,
                        rg: _reseller.rg,
                        nome: _reseller.nome,
                        senha: _reseller.senha,
                        dataNascimento: _reseller.dataNascimento,
                      );
                      FirestoreService.saveReseller(widget.adminId, novoRevendedor);
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (_) => HomeScreen(adminId: widget.adminId)),
                            (route) => false,
                      );
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          action: SnackBarAction(
                            label: 'OK',
                            onPressed: () {},
                          ),
                          content: Text('Salvo com Sucesso'),
                          duration: const Duration(milliseconds: 3000),
                          width: 280.0,
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          behavior: SnackBarBehavior.floating,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      );
                    }
                  },
                  child: Text('SALVAR'),
                ),
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

    return null;
  }
}
