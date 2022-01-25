import 'package:flutter/material.dart';

class LinkedDevice extends StatefulWidget {
  const LinkedDevice({Key? key}) : super(key: key);

  @override
  _LinkedDeviceState createState() => _LinkedDeviceState();
}

class _LinkedDeviceState extends State<LinkedDevice> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Linked Devices")),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Icon(
              Icons.devices_other,
              size: 140.0,
            ),
            Container(
              padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
              child: const Text(
                "Use WhatsApp on other devices",
                textScaleFactor: 2,
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
                width: 300,
                child: ElevatedButton(
                    onPressed: () {}, child: const Text("LINK A DEVICE"))),
            Container(
              padding: const EdgeInsets.only(top: 20.0),
              child: const ListTile(
                leading: Icon(
                  Icons.device_hub,
                  size: 40,
                ),
                title: Text("Multi-device beta"),
                subtitle: Text(
                    "Use up to 4 devices without keeping your phone online. Tap to learn more."),
              ),
            )
          ],
        ),
      ),
    );
  }
}
