import 'package:tmdb/settings.dart';

class Cast {
  int? id;
  int? gender;
  String? name;
  String? character;
  String? profilePath;
  String? originalName;

  Cast({
    this.id,
    this.gender,
    this.name,
    this.character,
    this.profilePath,
    this.originalName,
  });

  String get profileImage => "${Settings.imageUrl}$profilePath";

  factory Cast.fromJson(Map<String, dynamic> json) => Cast(
        id: json["id"],
        gender: json["gender"],
        name: json["name"],
        character: json["character"],
        profilePath: json["profile_path"],
        originalName: json["original_name"],
      );
}
