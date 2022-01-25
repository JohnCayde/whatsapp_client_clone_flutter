import 'package:flutter/material.dart';

class Setting extends StatefulWidget {
  const Setting({Key? key}) : super(key: key);

  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Settings")),
        body: ListView(
          children: [
            ListTile(
              leading: ClipOval(
                child: Image.asset('assets/images/avatar.png'),
              ),
              title: const Text("John"),
              subtitle: const Text("Available"),
              trailing: IconButton(
                icon: const Icon(Icons.qr_code),
                onPressed: () {},
              ),
              onTap: () {},
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.vpn_key_rounded),
              title: const Text("Account"),
              subtitle: const Text("Privacy, security, change number"),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.message),
              title: const Text("Chats"),
              subtitle: const Text("Theme, wallpapers, chat history"),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.notifications),
              title: const Text("Notifications"),
              subtitle: const Text("Notification, group & call tones"),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.storage),
              title: const Text("Storage and data"),
              subtitle: const Text("Network usage, auto-download"),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.help_outline_outlined),
              title: const Text("Help"),
              subtitle: const Text("Help centre, contact us, privacy  policy"),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.people),
              title: const Text("Invite a friend"),
              onTap: () {},
            ),
            ListTile(
              title: const Text("from Meta", textAlign: TextAlign.center),
              onTap: () {},
            )
          ],
        ));
  }
}
