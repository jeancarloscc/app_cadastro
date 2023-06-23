import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'form_usuario.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map<String, dynamic>> usersData = [];

  void initState() {
    super.initState();
    fetchUsersData();
  }

  void fetchUsersData() async {
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await FirebaseFirestore.instance.collection('usuarios').get();
    if (snapshot.size > 0) {
      setState(() {
        usersData = snapshot.docs.map((doc) => doc.data()).toList();
      });
    }
  }

  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cadastro"),
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
                // filterPets(value);
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
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            SizedBox(height: 4.0),
                            Text('Registro: ${userData['num_registro']}'),
                            SizedBox(height: 4.0),
                            Text('Senha: ${userData['senha']}'),
                          ],
                        ),
                        //   trailing: Row(
                        //     mainAxisSize: MainAxisSize.min,
                        //     children: [
                        //       // SizedBox(height: 90,),
                        //       IconButton(
                        //         icon: Icon(Icons.edit),
                        //         onPressed: () {},
                        //       ),
                        //       IconButton(
                        //         icon: Icon(Icons.delete),
                        //         onPressed: () {},
                        //       ),
                        //     ],
                        // ),
                      ),
                      ButtonBar(
                        children: <Widget>[
                          ElevatedButton(
                            child: Text('Editar'),
                            onPressed: () {},

                          ),
                          FilledButton(
                            child: Text('Excluir'),
                            onPressed: () {

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
                  builder: (_) => CadastroHome())
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
