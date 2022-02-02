import 'package:flutter/material.dart';
import '../components/chat_list.dart';
import '../components/call_list.dart';
import '../components/status_list.dart';

class TabSwitch extends StatefulWidget {
  const TabSwitch({Key? key}) : super(key: key);

  @override
  _TabSwitchState createState() => _TabSwitchState();
}

enum ChatOptionValues {
  newGroup,
  newBroadcast,
  linkedDevice,
  starredMessage,
  settings,
  statusPrivacy,
  clearCallLog,
  unknown
}

class ChatOptionsType {
  ChatOptionValues value = ChatOptionValues.unknown;
  String displayText = "";
  ChatOptionsType(this.value, this.displayText);
}

class _TabSwitchState extends State<TabSwitch>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _selectedIndex = 1;

  final List<String> friends = <String>[
    "John",
    "Steven",
    "Brad",
    "Bradyden",
    "Stevensen"
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(initialIndex: 1, length: 4, vsync: this);
    _tabController.addListener(() {
      setState(() {
        _selectedIndex = _tabController.index;
        // print(_selectedIndex);
        switch (_selectedIndex) {
          case 1:
            options = chatOptions;
            break;
          case 2:
            options = statusOptions;
            break;
          case 3:
            options = callOptions;
            break;

          default:
            options = [];
        }
      });
    });

    options = chatOptions;
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  List<ChatOptionsType> options = [];

  final List<ChatOptionsType> chatOptions = [
    ChatOptionsType(ChatOptionValues.newGroup, "New Group"),
    ChatOptionsType(ChatOptionValues.newBroadcast, "New broadcast"),
    ChatOptionsType(ChatOptionValues.linkedDevice, "Linked devices"),
    ChatOptionsType(ChatOptionValues.starredMessage, "Starred messages"),
    ChatOptionsType(ChatOptionValues.settings, "Settings"),
  ];

  final List<ChatOptionsType> statusOptions = [
    ChatOptionsType(ChatOptionValues.statusPrivacy, "Status Privacy"),
    ChatOptionsType(ChatOptionValues.settings, "Settings"),
  ];

  final List<ChatOptionsType> callOptions = [
    ChatOptionsType(ChatOptionValues.clearCallLog, "Clear Call Log"),
    ChatOptionsType(ChatOptionValues.settings, "Settings"),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      initialIndex: 1,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(controller: _tabController, tabs: const [
            Tab(icon: Icon(Icons.camera_alt)),
            Tab(text: "CHATS"),
            Tab(text: "STATUS"),
            Tab(text: "CALLS"),
          ]),
          title: const Text("WhatsApp"),
          actions: [
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () => {},
            ),
            PopupMenuButton<ChatOptionValues>(
                onSelected: (ChatOptionValues option) {
                  switch (option) {
                    case ChatOptionValues.starredMessage:
                      Navigator.of(context).pushNamed("/starred_message");
                      break;
                    case ChatOptionValues.statusPrivacy:
                      Navigator.of(context).pushNamed("/status_privacy");
                      break;
                    case ChatOptionValues.linkedDevice:
                      Navigator.of(context).pushNamed("/linked_device");
                      break;
                    case ChatOptionValues.settings:
                      Navigator.of(context).pushNamed("/setting");
                      break;
                    default:
                      Navigator.of(context).pushNamed("/error");
                    // print(option);
                  }
                },
                itemBuilder: (BuildContext context) =>
                    <PopupMenuEntry<ChatOptionValues>>[
                      for (var item in options)
                        PopupMenuItem<ChatOptionValues>(
                          value: item.value,
                          child: Text(item.displayText),
                        )
                    ])
          ],
        ),
        body: TabBarView(
          controller: _tabController,
          children: const [
            Icon(Icons.directions_car),
            ChatList(),
            StatusList(),
            CallList()
          ],
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.message_rounded),
          onPressed: () {
            Navigator.of(context)
                .pushNamed("/contact")
                .then((value) => setState(() {}));
          },
        ),
      ),
    );
  }
}
