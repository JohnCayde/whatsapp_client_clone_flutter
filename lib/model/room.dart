const String tableName = "messages";

class FieldNames {
  static const id = "_id";
  static const name = "name";
  static const profileImage = "profile_image";
  static const description = "description";
  static const lastUpdated = "last_updated";

  static final List<String> values = [
    id,
    name,
    profileImage,
    description,
    lastUpdated
  ];
}

class Room {
  final int? id;
  final String name;
  final String profileImage;
  final String description;
  final DateTime lastUpdated;

  const Room(
      {this.id,
      required this.name,
      required this.profileImage,
      required this.description,
      required this.lastUpdated});

  Room copy({
    int? id,
    String? name,
    String? profileImage,
    String? description,
    DateTime? lastUpdated,
  }) =>
      Room(
          id: id ?? this.id,
          name: name ?? this.name,
          profileImage: profileImage ?? this.profileImage,
          description: description ?? this.description,
          lastUpdated: lastUpdated ?? this.lastUpdated);

  Map<String, Object?> toJson() => {
        FieldNames.id: id,
        FieldNames.name: name,
        FieldNames.profileImage: profileImage,
        FieldNames.description: description,
        FieldNames.lastUpdated: lastUpdated.toIso8601String()
      };

  static Room fromJson(Map<String, Object?> json) => Room(
      id: json[FieldNames.id] as int,
      name: json[FieldNames.name] as String,
      profileImage: json[FieldNames.profileImage] as String,
      description: json[FieldNames.description] as String,
      lastUpdated: DateTime.parse(json[FieldNames.lastUpdated] as String));
}
