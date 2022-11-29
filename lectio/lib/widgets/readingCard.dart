import 'package:flutter/material.dart';
import 'package:lectio/models/reading.dart';

class ReadingCard extends StatefulWidget {
  final dynamic reading;
  const ReadingCard(data, {super.key, required this.reading});

  @override
  State<ReadingCard> createState() => _ReadingCardState();
}

class _ReadingCardState extends State<ReadingCard> {
  _updateReading({required int id}) async {
    /* int result = await widget.user.update();

    if (result == 1) {
      // toast
    } else {
      // toast
    } */
  }

  _deleteReading({required int id}) async {}

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.pink,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
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
                    onPressed: () async => await _updateReading(id: 1),
                    child: const Text("Editar")),
                const Padding(padding: EdgeInsets.only(left: 10)),
                ElevatedButton(
                    onPressed: () async => await _deleteReading(id: 1),
                    child: const Text("Excluir")),
              ],
            )
          ],
        ),
      ),
    );
  }
}
