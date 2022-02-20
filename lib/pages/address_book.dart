import 'package:flutter/material.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:todoapp/model/friend.dart';
import 'package:todoapp/model/member.dart';
import 'package:todoapp/model/room.dart';
import '../database/friend.dart';
import '../database/room.dart';
import '../database/member.dart';

enum ContactOptionValues { inviteFriend, contact, refresh, help, unknown }

class AddressBook extends StatefulWidget {
  const AddressBook({Key? key}) : super(key: key);

  @override
  _ContactState createState() => _ContactState();
}

class _ContactState extends State<AddressBook> {
  List<Friend> contactMembers = [];

  @override
  void initState() {
    super.initState();
    getExistingContact();
  }

  void getExistingContact() async {
    List<Friend> storedMember = await FriendDb.instance.findAll();
    setState(() {
      contactMembers = storedMember;
    });
    refreshContact();
  }

  Future<void> refreshContact() async {
    List<Contact> contacts = await ContactsService.getContacts();
    List<int> cachedIdentifiers = contactMembers.map((e) => e.phoneId).toList();
    List<Contact> newFriends = contacts
        .where((member) => !cachedIdentifiers.contains(member.hashCode))
        .toList();

    if (newFriends.isNotEmpty) {
      // print("new friend");
      for (var i = 0; i < newFriends.length; i++) {
        await FriendDb.instance.create(Friend(
            phoneId: newFriends[i].hashCode,
            name: newFriends[i].givenName ?? "unknown",
            phone: newFriends[i].phones?[0].value ?? "1234567890",
            description: ""));
      }
      getExistingContact();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(children: const [
          Text("Select contact"),
          Text(
            "Select contact",
            textScaleFactor: 0.8,
          )
        ]),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () => {},
          ),
          PopupMenuButton<ContactOptionValues>(
              onSelected: (ContactOptionValues option) {
                switch (option) {
                  case ContactOptionValues.inviteFriend:
                    break;
                  case ContactOptionValues.contact:
                    break;
                  case ContactOptionValues.refresh:
                    refreshContact();
                    break;
                  case ContactOptionValues.help:
                    Navigator.of(context).pushNamed("/help");
                    break;
                  default:
                    Navigator.of(context).pushNamed("/error");
                  // print(option);
                }
              },
              itemBuilder: (BuildContext context) =>
                  const <PopupMenuEntry<ContactOptionValues>>[
                    PopupMenuItem<ContactOptionValues>(
                      value: ContactOptionValues.inviteFriend,
                      child: Text("Invite a friend"),
                    ),
                    PopupMenuItem<ContactOptionValues>(
                      value: ContactOptionValues.contact,
                      child: Text("Contacts"),
                    ),
                    PopupMenuItem<ContactOptionValues>(
                      value: ContactOptionValues.refresh,
                      child: Text("Refresh"),
                    ),
                    PopupMenuItem<ContactOptionValues>(
                      value: ContactOptionValues.help,
                      child: Text("Help"),
                    )
                  ])
        ],
      ),
      body: ListView(
        children: [
          ListTile(
            leading: ClipOval(
              child: Image.asset('assets/images/avatar.png'),
            ),
            title: const Text("New group"),
            subtitle: const Text(""),
            onTap: () {},
          ),
          ListTile(
            leading: ClipOval(
              child: Image.asset('assets/images/avatar.png'),
            ),
            title: const Text("New contact"),
            subtitle: const Text(""),
            trailing: const Icon(Icons.qr_code),
            onTap: () {},
          ),
          for (var contactMember in contactMembers)
            MemberTile(member: contactMember)
        ],
      ),
    );
  }
}

class MemberTile extends StatefulWidget {
  final Friend member;

  const MemberTile({Key? key, required this.member}) : super(key: key);

  @override
  _MemberTileState createState() => _MemberTileState();
}

class _MemberTileState extends State<MemberTile> {
  // final Friend member;
  // _MemberTileState({required this.member});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: ClipOval(
        child: Image.asset('assets/images/avatar.png'),
      ),
      title: Text(widget.member.name),
      subtitle: Text(widget.member.description),
      onTap: () async {
        // print("generate room");
        // print(widget.member.id);

        bool isExist = await MemberDb.instance.isExist(widget.member.id!);
        if (isExist) {
          // print("exist");
          return Navigator.pop(context);
        }

        Room newRoom = await RoomDb.instance.create(Room(
            name: widget.member.name,
            profileImage: "assets/images/avatar.png",
            description: widget.member.description,
            lastUpdated: DateTime.now()));

        await MemberDb.instance.create(Member(
            roomId: newRoom.id!, memberId: widget.member.id!, status: 2));

        return Navigator.pop(context);
      },
    );
  }
}
