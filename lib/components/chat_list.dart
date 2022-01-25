import 'package:flutter/material.dart';

class ChatList extends StatefulWidget {
  const ChatList({Key? key}) : super(key: key);

  @override
  _ChatListState createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> {
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
            subtitle: const Text("loren lotus"),
            trailing: const Text("Date"),
            onTap: () {
              setState(() {
                _selectedIndex = index;
              });
            },
          );
        });
  }
}
