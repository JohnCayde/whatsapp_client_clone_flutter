import 'package:flutter/material.dart';

class Help extends StatelessWidget {
  const Help({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Contacts help"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: const [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "If some of your frineds don't appear in the contacts list, we recommend the following steps:",
                textScaleFactor: 1.17,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "• Make sure that your friend's phone number is in your address book",
                textScaleFactor: 1.17,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "• Make sure that your friend is using WhatsApp Messager",
                textAlign: TextAlign.start,
                textScaleFactor: 1.17,
              ),
            )
          ],
        ),
      ),
    );
  }
}
