import 'package:app_cadastro/services/FirebaseDatabaseService.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'form_usuario.dart';

class HomeScreen extends StatefulWidget {
  final String adminId;

  const HomeScreen({Key? key, required this.adminId}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map<String, dynamic>> usersData = [];

  void initState() {
    super.initState();
    getAdminId();
    fetchResellersData();
  }

  FirebaseAuth auth = FirebaseAuth.instance;

  void getAdminId() {
    User? user = auth.currentUser;
    if (user != null) {
      String adminId = user.uid;
      print('Admin ID: $adminId');
    } else {
      print('Usuário não autenticado');
    }
  }

  Future<void> fetchResellersData() async {
    String adminId = widget.adminId;

    QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
        .instance
        .collection('admins')
        .doc(adminId)
        .collection('resellers')
        .get();
    if (snapshot.size > 0) {
      setState(() {
        usersData = snapshot.docs.map((doc) {
          Map<String, dynamic> userData = doc.data();
          userData['id'] = doc.id; // Adiciona o campo 'id' ao mapa userData
          return userData;
        }).toList();
      });
    }
  }

  void deleteReseller(String resellerId) async {
    await FirestoreService.deleteReseller(widget.adminId, resellerId);
    setState(() {
      usersData.removeWhere((user) => user['id'] == resellerId);
    });
  }

  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lista de Revendedores"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Pesquisar',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              onChanged: (value) {
                // Implemente a função filterResellers para filtrar a lista de revendedores
                // de acordo com o valor digitado no TextField de pesquisa.
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: usersData.length,
              itemBuilder: (context, index) {
                Map<String, dynamic> userData = usersData[index];
                return Card(
                  elevation: 4.0,
                  margin: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 16.0),
                  child: Column(
                    children: [
                      ListTile(
                        leading: CircleAvatar(
                            // backgroundImage: NetworkImage(photoUrl),
                            ),
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Nome: ${userData['nome']}',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 4.0),
                            Text('Registro: ${userData['numRegistro']}'),
                            SizedBox(height: 4.0),
                            Text('Senha: ${userData['senha']}'),
                          ],
                        ),
                      ),
                      ButtonBar(
                        children: <Widget>[
                          OutlinedButton(
                            child: Text('Editar'),
                            onPressed: () {
                              // Implemente a lógica para editar o revendedor
                            },
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Color(0xFFFCF1F3))),
                          ),
                          FilledButton(
                            child: Text('Excluir'),
                            onPressed: () async {
                              // userData['id'];
                              // print("ID Revendedor: ${userData['id']}");
                              // await FirestoreService.deleteReseller(
                              //     widget.adminId, userData['id']);
                              // await fetchResellersData();
                              deleteReseller(userData['id']);
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => CadastroReseller(adminId: widget.adminId),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
