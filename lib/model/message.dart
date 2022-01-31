const String tableName = "messages";

class FieldNames {
  static const id = "_id";
  static const message = "message";
  static const sequence = "sequence";
  static const sender = "sender";
  static const status = "status";
  static const sentDate = "sent_date";

  static const List<String> values = [
    id,
    message,
    sequence,
    sender,
    status,
    sentDate
  ];
}

class Message {
  final int? id;
  final String message;
  final int sequence;
  final int sender;
  final int status;
  final DateTime sentDate;

  const Message(
      {this.id,
      required this.message,
      required this.sequence,
      required this.sender,
      required this.status,
      required this.sentDate});

  Message copy(
          {int? id,
          String? message,
          int? sequence,
          int? sender,
          int? status,
          DateTime? sentDate}) =>
      Message(
          id: id ?? this.id,
          message: message ?? this.message,
          sequence: sequence ?? this.sequence,
          sender: sender ?? this.sender,
          status: status ?? this.status,
          sentDate: sentDate ?? this.sentDate);

  Map<String, Object?> toJson() => {
        FieldNames.id: id,
        FieldNames.message: message,
        FieldNames.sender: sender,
        FieldNames.sequence: sequence,
        FieldNames.status: status,
        FieldNames.sentDate: sentDate
      };

  static Message fromJson(Map<String, Object?> json) => Message(
      id: json[FieldNames.id] as int,
      message: json[FieldNames.message] as String,
      sequence: json[FieldNames.sequence] as int,
      sender: json[FieldNames.sender] as int,
      status: json[FieldNames.status] as int,
      sentDate: json[FieldNames.sentDate] as DateTime);
}
