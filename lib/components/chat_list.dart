import 'package:flutter/material.dart';
import 'package:todoapp/model/room.dart';
import 'package:intl/intl.dart';

class ChatList extends StatefulWidget {
  final List<Room> chatRoom;
  const ChatList({Key? key, required this.chatRoom}) : super(key: key);

  @override
  _ChatListState createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: widget.chatRoom.length,
        itemBuilder: (BuildContext context, int index) {
          return RoomTile(room: widget.chatRoom[index]);
        });
  }
}

class RoomTile extends StatefulWidget {
  final Room room;
  const RoomTile({Key? key, required this.room}) : super(key: key);

  @override
  _RoomTileState createState() => _RoomTileState();
}

class _RoomTileState extends State<RoomTile> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: ClipOval(
        child: Image.asset(widget.room.profileImage),
      ),
      title: Text(widget.room.name),
      subtitle: Text(widget.room.description),
      trailing: Text(DateFormat.yMd("en_Us").format(widget.room.lastUpdated)),
      onTap: () {
        Navigator.of(context).pushNamed("/room", arguments: widget.room);
      },
    );
  }
}
