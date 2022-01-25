import 'package:flutter/material.dart';

class CallList extends StatefulWidget {
  const CallList({Key? key}) : super(key: key);

  @override
  _CallListState createState() => _CallListState();
}

class _CallListState extends State<CallList> {
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
            trailing: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.video_camera_front_rounded)),
            onTap: () {
              setState(() {
                _selectedIndex = index;
              });
            },
          );
        });
  }
}
