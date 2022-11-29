import 'package:flutter/material.dart';
import 'package:lectio/models/reading.dart';
import 'package:lectio/views/profile.dart';
import 'package:lectio/widgets/readingCard.dart';

class Readings extends StatefulWidget {
  final int userId;
  const Readings({super.key, required this.userId});

  @override
  State<Readings> createState() => _ReadingsState();
}

class _ReadingsState extends State<Readings> {
  Future<List<Reading>> _getReadings(int userId) async {
    return await Reading.getReadingsByUserId(userId);
  }

  _createReading() async {}

  _createPopUp() async {
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
                  onPressed: () async => await _createReading(),
                  child: const Text("Criar")),
              ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Fechar"))
            ],
          );
        });
  }

  _navigateToProfile() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const Profile()));
  }

  @override
  void initState() {
    _getReadings(widget.userId);
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
          color: Colors.grey,
          child: FutureBuilder(
              future: _getReadings(widget.userId),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  if (snapshot.hasError) {
                    return const Center(child: Text('Erro ao carregar dados'));
                  } else {
                    //print(snapshot.data);
                    return const Center(
                      child: Text('Teste'),
                    );
                  }
                }
              })),
      floatingActionButton: FloatingActionButton(
        onPressed: _createPopUp,
        child: const Icon(Icons.add),
      ),
    );
  }
}
