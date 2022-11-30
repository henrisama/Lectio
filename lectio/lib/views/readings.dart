// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:lectio/models/reading.dart';
import 'package:lectio/views/profile.dart';

class Readings extends StatefulWidget {
  final int userId;
  const Readings({super.key, required this.userId});

  @override
  State<Readings> createState() => _ReadingsState();
}

class _ReadingsState extends State<Readings> {
  TextEditingController titleController = TextEditingController();
  TextEditingController authorController = TextEditingController();
  TextEditingController statusController =
      TextEditingController(text: "to read");

  Future<List<Reading>> _getReadings(int userId) async {
    return await Reading.getReadingsByUserId(userId);
  }

  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(value: "to read", child: Text("To Read")),
      const DropdownMenuItem(value: "reading", child: Text("Reading")),
      const DropdownMenuItem(value: "read", child: Text("Read")),
    ];
    return menuItems;
  }

  _navigateToProfile() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Profile(
                  userId: widget.userId,
                )));
  }

  _createReading() async {
    final String title = titleController.text;
    final String author = authorController.text;
    final String status = statusController.text;
    final int reader = widget.userId;

    if (title.isEmpty) {
      return null;
    }

    if (author.isEmpty) {
      return null;
    }

    Reading reading =
        Reading(title, author, status, DateTime.now.toString(), reader);

    int result = await reading.create();

    if (result != 0) {
      _closePopUp(context);
      setState(() {});
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
        "Leitura Adicionada",
        textAlign: TextAlign.center,
      )));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content:
              Text("Erro ao Adicionar Leitura", textAlign: TextAlign.center)));
    }
  }

  _updateReading(Reading? reading, BuildContext context) async {
    if (reading != null) {
      reading.setTitle(titleController.text);
      reading.setAuthor(authorController.text);
      reading.setStatus(statusController.text);

      int result = await reading.update();

      if (result != 0) {
        _closePopUp(context);
        setState(() {});
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text(
          "Leitura Alterada",
          textAlign: TextAlign.center,
        )));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text(
          "Erro ao Alterar Leitura",
          textAlign: TextAlign.center,
        )));
      }
    }
  }

  _deleteReading(Reading reading) async {
    int result = await reading.delete();

    if (result != 0) {
      setState(() {});
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
        "Leitura Apagada",
        textAlign: TextAlign.center,
      )));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content:
              Text("Erro ao Apagar Leitura", textAlign: TextAlign.center)));
    }
  }

  _closePopUp(BuildContext context) {
    Navigator.pop(context);
    titleController.text = "";
    authorController.text = "";
    statusController.text = "to read";
  }

  _createOrUpdatePopUp({Reading? reading}) async {
    if (reading != null) {
      titleController.text = reading.getTitle;
      authorController.text = reading.getAuthor;
      statusController.text = reading.getStatus;
    }

    return showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: ((context, setState) {
            return AlertDialog(
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: titleController,
                    decoration: const InputDecoration(hintText: "Title"),
                  ),
                  TextFormField(
                    controller: authorController,
                    decoration: const InputDecoration(hintText: "Author"),
                  ),
                  DropdownButton(
                    value: statusController.text,
                    items: dropdownItems,
                    onChanged: (String? status) {
                      setState(() {
                        statusController.text = status ??= "to read";
                        //debugPrint(statusController.text);
                      });
                    },
                    isExpanded: true,
                  )
                ],
              ),
              actions: [
                ElevatedButton(
                    onPressed: () async => reading != null
                        ? await _updateReading(reading, context)
                        : await _createReading(),
                    child: reading != null
                        ? const Text("Salvar")
                        : const Text("Criar")),
                ElevatedButton(
                    onPressed: () => _closePopUp(context),
                    child: const Text("Fechar"))
              ],
            );
          }));
        });
  }

  Widget readindCard(Reading reading) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
      child: Card(
        color: Colors.pink,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(reading.getTitle),
              Text(reading.getAuthor),
              Text(reading.getStatus),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  ElevatedButton(
                      onPressed: () async =>
                          await _createOrUpdatePopUp(reading: reading),
                      child: const Text("Editar")),
                  const Padding(padding: EdgeInsets.only(left: 10)),
                  ElevatedButton(
                      onPressed: () async => await _deleteReading(reading),
                      child: const Text("Excluir")),
                ],
              )
            ],
          ),
        ),
      ),
    );
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
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  if (snapshot.hasError) {
                    return const Center(child: Text('Erro ao carregar dados'));
                  } else {
                    if (snapshot.data != null) {
                      return ListView.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, index) {
                            return readindCard(snapshot.data[index]);
                          });
                    } else {
                      return const Center(child: Text('Dados vazios'));
                    }
                  }
                }
              })),
      floatingActionButton: FloatingActionButton(
        onPressed: _createOrUpdatePopUp,
        child: const Icon(Icons.add),
      ),
    );
  }
}
