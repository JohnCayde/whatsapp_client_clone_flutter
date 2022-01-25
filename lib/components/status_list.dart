import 'package:flutter/material.dart';

class StatusList extends StatefulWidget {
  const StatusList({Key? key}) : super(key: key);

  @override
  _StatusListState createState() => _StatusListState();
}

class _StatusListState extends State<StatusList> {
  final List<String> ppl = <String>[
    "John",
    "Steven",
    "Brad",
    "Bradyden",
    "Stevensen"
  ];
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: ppl.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            leading: ClipOval(
              child: Image.asset('assets/images/avatar.png'),
            ),
            title: Text(ppl[index]),
            subtitle: const Text("last updated at"),
            onTap: () {
              setState(() {
                _selectedIndex = index;
              });
            },
          );
        });
  }
}
