import 'package:flutter/material.dart';

class StarredMessage extends StatefulWidget {
  const StarredMessage({Key? key}) : super(key: key);

  @override
  _StarredMessageState createState() => _StarredMessageState();
}

class _StarredMessageState extends State<StarredMessage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Starred messages")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const [
          Icon(
            Icons.stars,
            size: 250,
          ),
          Padding(
            padding: EdgeInsets.only(left: 100, right: 100, top: 30),
            child: Text(
                "Tap and hold on any message in any chat to star it, so you can easily find it later",
                textAlign: TextAlign.center,
                textScaleFactor: 1.4),
          )
        ],
      ),
    );
  }
}
