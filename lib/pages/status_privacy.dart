import 'package:flutter/material.dart';

enum Privacy { all, except, only }

class StatusPrivacy extends StatefulWidget {
  const StatusPrivacy({Key? key}) : super(key: key);

  @override
  _StatusPrivacyState createState() => _StatusPrivacyState();
}

class _StatusPrivacyState extends State<StatusPrivacy> {
  Privacy? _character = Privacy.all;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Status Privacy")),
        body: Column(
          children: <Widget>[
            Expanded(
                child: Column(children: [
              const ListTile(
                subtitle: Text('Who can see my status updates'),
              ),
              RadioListTile<Privacy>(
                title: const Text('My contacts'),
                value: Privacy.all,
                groupValue: _character,
                onChanged: (Privacy? value) {
                  setState(() {
                    _character = value;
                  });
                },
              ),
              RadioListTile<Privacy>(
                title: const Text('My contacs except ...'),
                value: Privacy.except,
                groupValue: _character,
                onChanged: (Privacy? value) {
                  setState(() {
                    _character = value;
                  });
                },
              ),
              RadioListTile<Privacy>(
                title: const Text('Only Share with ...'),
                value: Privacy.only,
                groupValue: _character,
                onChanged: (Privacy? value) {
                  setState(() {
                    _character = value;
                  });
                },
              ),
              const ListTile(
                subtitle: Text(
                    "Changes to your privacy settings won't affect status update that you've sent already"),
              ),
            ])),
            ElevatedButton(
              onPressed: () {},
              child: const Text("Done"),
            )
          ],
        ));
  }
}
