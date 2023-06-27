import 'package:app_cadastro/screens/informacao_revendedor.dart';
import 'package:app_cadastro/services/FirebaseDatabaseService.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

import 'form_usuario.dart';
import 'login.dart';

class HomeScreen extends StatefulWidget {
  final String adminId;

  const HomeScreen({Key? key, required this.adminId}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map<String, dynamic>> usersData = [];
  List<Map<String, dynamic>> filteredUsersData = [];

  String? adminNome;

  void initState() {
    super.initState();
    getAdminId();
    fetchResellersData();
    getAdminName();
  }

  FirebaseAuth auth = FirebaseAuth.instance;

  void getAdminId() {
    User? user = auth.currentUser;
    if (user != null) {
      String adminId = user.uid;
      String? adminEmail = user.email;
      print('Admin ID: $adminId');
      print('Email do admin: $adminEmail');
    } else {
      print('Usuário não autenticado');
    }
  }

  Future<void> getAdminName() async {
    String adminId = widget.adminId;

    DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
        .instance
        .collection('admins')
        .doc(adminId)
        .get();

    if (snapshot.exists) {
      setState(() {
        adminNome = snapshot.data()?['nome'];
      });
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
        filteredUsersData =
            List.from(usersData); // Inicializar a pesquisa por revendedor
      });
    }
  }

  void deleteReseller(String resellerId) async {
    await FirestoreService.deleteReseller(widget.adminId, resellerId);
    setState(() {
      usersData.removeWhere((user) => user['id'] == resellerId);
      filteredUsersData.removeWhere((user) => user['id'] == resellerId);
    });
  }

  void filterResellers(String query) {
    setState(() {
      filteredUsersData = usersData
          .where((user) =>
              user['nome'].toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lista de Revendedores"),
      ),
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
                accountName: Text("Olá, ${adminNome}"),
                accountEmail: Text("${auth.currentUser?.email}")),
            ListTile(
              leading: Icon(Icons.exit_to_app, color: Color(0xFFBA1A1A)),
              title: Text('Sair da conta',
                  style: TextStyle(color: Color(0xFFBA1A1A))),
              onTap: () {
                // Implemente a lógica para a opção 1 do menu
                _signOut();
              },
              tileColor: Color(0xFFFFDAD6),
              // shape: RoundedRectangleBorder(
              //   borderRadius: BorderRadius.circular(10.0),
              // ),
            ),
            ListTile(
              title: GestureDetector(
                child: Text(
                  'Política de Privacidade',
                ),
              ),
              onTap: () {
                launchUrlString('https://www.youtube.com/watch?v=nqRftnLIEfI');
              },
            ),
            ListTile(
              title: Text("Sobre o aplicativo"),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Sobre o aplicativo'),
                      content: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('Diário da Erinalda', style: TextStyle(fontWeight: FontWeight.bold)),
                          Text('Versão: 1.0.0'),
                          SizedBox(height: 16),
                          Text('Desenvolvido por: Jean Carlos'),
                          Text('Email: jeancc.costa@gmail.com'),
                        ],
                      ),
                      actions: [
                        TextButton(
                          child: Text('Fechar'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
              },
            )
          ],
        ),
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
                filterResellers(value);
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredUsersData.length,
              itemBuilder: (context, index) {
                Map<String, dynamic> userData = filteredUsersData[index];
                return InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => InformacaoRevendedor(userData: userData,)));
                  },
                  child: Card(
                    elevation: 1,
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
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text('Confirmação'),
                                      content: Text(
                                          'Tem certeza que deseja excluir o revendedor?'),
                                      actions: <Widget>[
                                        TextButton(
                                          child: Text('Cancelar'),
                                          onPressed: () {
                                            Navigator.of(context)
                                                .pop(); // Fecha o diálogo
                                          },
                                        ),
                                        TextButton(
                                          child: Text('Excluir'),
                                          onPressed: () async {
                                            Navigator.of(context)
                                                .pop(); // Fecha o diálogo
                                            deleteReseller(userData[
                                                'id']); // Exclui o revendedor
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
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

  void _signOut() async {
    await auth.signOut(); // Faz logout do usuário atual
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
          builder: (_) => LoginScreen()), // Navega para a tela de login
    );
  }
}
