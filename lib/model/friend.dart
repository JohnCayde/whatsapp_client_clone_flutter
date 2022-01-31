const String tableName = "friends";

class FieldNames {
  static const String id = "_id";
  static const String phoneId = "phone_id";
  static const String name = "name";
  static const String phone = "phone";
  static const String description = "description";

  static final List<String> values = [id, phoneId, name, phone, description];
}

class Friend {
  final int? id;
  final int phoneId;
  final String name;
  final String phone;
  final String description;

  const Friend(
      {this.id,
      required this.phoneId,
      required this.name,
      required this.phone,
      required this.description});

  Friend copy({
    int? id,
    int? phoneId,
    String? name,
    String? phone,
    String? description,
  }) =>
      Friend(
          id: id ?? this.id,
          phoneId: phoneId ?? this.phoneId,
          name: name ?? this.name,
          phone: phone ?? this.phone,
          description: description ?? this.description);

  Map<String, Object?> toJson() => {
        FieldNames.id: id,
        FieldNames.phoneId: phoneId,
        FieldNames.name: name,
        FieldNames.phone: phone,
        FieldNames.description: description,
      };

  static Friend fromJson(Map<String, Object?> json) => Friend(
      id: json[FieldNames.id] as int,
      phoneId: json[FieldNames.phoneId] as int,
      name: json[FieldNames.name] as String,
      phone: json[FieldNames.phone] as String,
      description: json[FieldNames.description] as String);
}
