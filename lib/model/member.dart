const String tableName = "members";

class FieldNames {
  static const id = "_id";
  static const roomId = "room_id";
  static const memberId = "member_id";
  static const status = "status";

  static final List<String> values = [id, roomId, memberId, status];
}

class Member {
  final int? id;
  final int roomId;
  final int memberId;
  final int status;

  const Member(
      {this.id,
      required this.roomId,
      required this.memberId,
      required this.status});

  Member copy({int? id, int? roomId, int? memberId, int? status}) => Member(
      id: id ?? this.id,
      roomId: roomId ?? this.roomId,
      memberId: memberId ?? this.memberId,
      status: status ?? this.status);

  Map<String, Object?> toJson() => {
        FieldNames.id: id,
        FieldNames.roomId: roomId,
        FieldNames.memberId: memberId,
        FieldNames.status: status
      };

  static Member fromJson(Map<String, Object?> json) => Member(
      id: json[FieldNames.id] as int,
      roomId: json[FieldNames.roomId] as int,
      memberId: json[FieldNames.memberId] as int,
      status: json[FieldNames.status] as int);
}
