import 'package:flutter/material.dart';
import 'package:todoapp/database/member.dart';
import 'package:todoapp/database/message.dart';
import 'package:todoapp/model/member.dart';
import 'package:todoapp/model/message.dart';
import 'package:todoapp/model/room.dart';

enum OptionValues { viewContact, media, search, mute, wallpaper, more }
enum MoreOptionValues { report, block, clearChat, exportChart, shortCut }

class ChatRoom extends StatefulWidget {
  final Room room;
  const ChatRoom({Key? key, required this.room}) : super(key: key);

  @override
  _ChatRoomState createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  final TextEditingController _controller = TextEditingController();
  bool isTextInput = false;
  int messageCount = 0;
  late List<Message> messages = [];

  @override
  void initState() {
    super.initState();
    refreshMessage(widget.room.id);
  }

  void refreshMessage(roomId) async {
    List<Message> storedMessages =
        await MessageDb.instance.findAll(widget.room.id!);
    setState(() {
      messages = storedMessages;
      messageCount = storedMessages.length;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Hero(
          tag: "chatDetails",
          child: ClipOval(
            child: Image.asset(widget.room.profileImage),
          ),
        ),
        title: ListTile(
          title: const Text("test"),
          onTap: () {
            Navigator.of(context).pushNamed("/room_details");
          },
        ),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.videocam)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.call)),
          PopupMenuButton<OptionValues>(
            onSelected: (OptionValues option) {
              switch (option) {
                case OptionValues.more:
                  break;

                default:
                  Navigator.of(context).pushNamed("/error");
                // print(option);
              }
            },
            itemBuilder: (BuildContext context) =>
                <PopupMenuEntry<OptionValues>>[
              const PopupMenuItem<OptionValues>(
                value: OptionValues.viewContact,
                child: Text("View Contact"),
              ),
              const PopupMenuItem<OptionValues>(
                value: OptionValues.media,
                child: Text("Media, links, and docs"),
              ),
              const PopupMenuItem<OptionValues>(
                value: OptionValues.search,
                child: Text("Search"),
              ),
              const PopupMenuItem<OptionValues>(
                value: OptionValues.mute,
                child: Text("Mute Notification"),
              ),
              const PopupMenuItem<OptionValues>(
                value: OptionValues.wallpaper,
                child: Text("Wallpaper"),
              ),
              PopupMenuItem<OptionValues>(
                value: OptionValues.more,
                child: PopupMenuButton<MoreOptionValues>(
                  child: Row(
                    children: const [
                      Text("More"),
                      Icon(
                        Icons.arrow_right,
                        color: Colors.black,
                      )
                    ],
                  ),
                  onSelected: (MoreOptionValues option) {
                    switch (option) {
                      case MoreOptionValues.report:
                        break;

                      default:
                        Navigator.of(context).pushNamed("/error");
                      // print(option);
                    }
                  },
                  itemBuilder: (BuildContext context) =>
                      const <PopupMenuEntry<MoreOptionValues>>[
                    PopupMenuItem<MoreOptionValues>(
                      value: MoreOptionValues.report,
                      child: Text("Report"),
                    ),
                    PopupMenuItem<MoreOptionValues>(
                      value: MoreOptionValues.block,
                      child: Text("Block"),
                    ),
                    PopupMenuItem<MoreOptionValues>(
                      value: MoreOptionValues.clearChat,
                      child: Text("Clear Chat"),
                    ),
                    PopupMenuItem<MoreOptionValues>(
                      value: MoreOptionValues.exportChart,
                      child: Text("Export Chat"),
                    ),
                    PopupMenuItem<MoreOptionValues>(
                      value: MoreOptionValues.shortCut,
                      child: Text("Add shortcut"),
                    ),
                  ],
                ),
              )
            ],
          )
        ],
      ),
      body: Column(children: [
        Expanded(
          child: Column(
            children: [
              for (var message in messages)
                Container(
                  padding: const EdgeInsets.only(
                      left: 14, right: 14, top: 10, bottom: 0),
                  child: Align(
                    alignment: message.sender == 0
                        ? Alignment.topRight
                        : Alignment.topLeft,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: message.sender == 0
                            ? Colors.blue.shade50
                            : Colors.grey.shade200,
                      ),
                      padding: const EdgeInsets.all(16),
                      child: Text(message.message,
                          style: const TextStyle(fontSize: 15)),
                    ),
                  ),
                )
            ],
          ),
        ),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: _controller,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  prefixIcon: IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.emoji_emotions),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                  suffix: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.bookmark),
                        padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
                        constraints: const BoxConstraints(),
                      ),
                      if (!isTextInput)
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.camera_alt),
                          padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
                          constraints: const BoxConstraints(),
                        ),
                    ],
                  ),
                ),
                onChanged: (text) {
                  if (text.isNotEmpty) {
                    setState(() {
                      isTextInput = true;
                    });
                  } else {
                    setState(() {
                      isTextInput = false;
                    });
                  }
                },
              ),
            ),
            isTextInput
                ? IconButton(
                    icon: const Icon(Icons.send),
                    onPressed: () async {
                      //send message to database
                      await MessageDb.instance.create(Message(
                          roomId: widget.room.id!,
                          message: _controller.text,
                          sequence: messageCount + 1,
                          sender: 0,
                          status: 2,
                          sentDate: DateTime.now()));
                      messageCount += 1;

                      //custom logic to reply you
                      if (_controller.text.contains("reply")) {
                        List<Member> roomMembers = await MemberDb.instance
                            .getRoomMember(widget.room.id!);

                        for (var i = 0; i < roomMembers.length; i++) {
                          await MessageDb.instance.create(Message(
                              roomId: widget.room.id!,
                              message: "I reply you now",
                              sequence: messageCount + 1,
                              sender: roomMembers[i].memberId,
                              status: 2,
                              sentDate: DateTime.now()));
                          messageCount += 1;
                        }
                      }
                      _controller.clear();
                      refreshMessage(widget.room.id!);
                    },
                  )
                : IconButton(
                    icon: const Icon(Icons.mic),
                    onPressed: () {},
                  )
          ],
        )
      ]),
    );
  }
}
