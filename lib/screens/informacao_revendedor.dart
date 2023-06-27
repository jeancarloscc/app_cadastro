import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class InformacaoRevendedor extends StatelessWidget {
  final Map<String, dynamic> userData;

  const InformacaoRevendedor({super.key, required this.userData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dados do Revendedor'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CircleAvatar(
                radius: 60,
                child: Icon(
                  Icons.person,
                  size: 75,
                ),
              ),
              SizedBox(height: 8),
              Card(
                elevation: 0,
                color: Theme.of(context).colorScheme.surfaceVariant,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      leading: Icon(Icons.person), // Ícone de usuário
                      title: Text(
                        'Nome: ${userData['nome']}',
                      ),
                    ),
                    ListTile(
                      leading: Icon(Icons.assignment_ind_outlined),
                      title: Text(
                        'Registro Avon: ${userData['numRegistro']}',
                      ),
                    ),
                    ListTile(
                      leading: Icon(Icons.key_outlined),
                      title: Text(
                        'Senha: ${userData['senha']}',
                      ),
                    ),
                    ListTile(
                      leading: Icon(Icons.assignment_outlined),
                      title: Text(
                        'CPF: ${userData['cpf']}',
                      ),
                    ),
                    ListTile(
                      leading: Icon(Icons.badge_outlined),
                      title: Text(
                        'RG: ${userData['rg']}',
                      ),
                    ),
                    ListTile(
                      leading: Icon(Icons.cake_outlined),
                      title: Text(
                        'Data de Nascimento: ${userData['dataNascimento']}',
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
