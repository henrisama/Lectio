import 'package:flutter/material.dart';
import 'package:lectio/views/profile.dart';

class Readings extends StatefulWidget {
  final int userId;
  const Readings({super.key, required this.userId});

  @override
  State<Readings> createState() => _ReadingsState();
}

class _ReadingsState extends State<Readings> {
  _getData(int userId) async {
    return [];
  }

  _readingPopUp({int? id}) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: null,
                ),
                TextFormField(
                  controller: null,
                ),
                TextFormField(
                  controller: null,
                ),
              ],
            ),
            actions: [
              ElevatedButton(
                  onPressed: () async => await _createOrUpdate(id: id),
                  child:
                      id == null ? const Text("Criar") : const Text("Salvar")),
              ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Fechar"))
            ],
          );
        });
  }

  _createOrUpdate({int? id}) async {
    if (id != null) {
      // update
    } else {
      // create
    }
  }

  Widget _showReadings() {
    return Card(
      color: Colors.pink,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text("Title"),
          const Text("Author"),
          const Text("Status"),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(
                  onPressed: () async => await _readingPopUp(id: 1),
                  child: const Text("Editar")),
              const Padding(padding: EdgeInsets.only(left: 10)),
              ElevatedButton(
                  onPressed: () async => await _deleteReading(id: 1),
                  child: const Text("Excluir"))
            ],
          )
        ],
      ),
    );
  }

  _navigateToProfile() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const Profile()));
  }

  _deleteReading({required int id}) async {}

  @override
  void initState() {
    _getData(widget.userId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Leituras"),
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: _navigateToProfile,
              icon: const Icon(
                Icons.person,
                size: 32,
              ))
        ],
      ),
      body: Container(
        child: _showReadings(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async => await _readingPopUp(id: null),
        child: const Icon(Icons.add),
      ),
    );
  }
}
