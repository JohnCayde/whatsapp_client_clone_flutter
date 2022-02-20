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

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: ClipOval(
            child: Image.asset('assets/images/avatar.png'),
          ),
          title: const Text("My status"),
          subtitle: const Text("Tap to add status update"),
          onTap: () {},
        ),
        Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.all(10.0),
          child: const Text("Viewed updates"),
        ),
        Expanded(
          child: ListView.builder(
              itemCount: ppl.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  leading: ClipOval(
                    child: Image.asset('assets/images/avatar.png'),
                  ),
                  title: Text(ppl[index]),
                  subtitle: const Text("Yesterday, 10.43pm"),
                  onTap: () {},
                );
              }),
        )
      ],
    );
  }
}
