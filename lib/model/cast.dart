import 'package:tmdb/settings.dart';

class Cast {
  int? id;
  int? gender;
  String? name;
  List<String>? aka;
  String? biography;
  String? birthday;
  String? deathday;
  String? hometown;
  double? popularity;
  String? character;
  String? profilePath;
  String? originalName;

  Cast({
    this.id,
    this.gender,
    this.name,
    this.aka,
    this.biography,
    this.birthday,
    this.deathday,
    this.hometown,
    this.popularity,
    this.character,
    this.profilePath,
    this.originalName,
  });

  String get profileImage => "${Settings.imageUrl}$profilePath";

  String get birthYear =>
      "(${DateTime.parse(birthday!).year} - ${deathday != null ? DateTime.parse(deathday!).year : 'N/A'})";

  factory Cast.fromJson(Map<String, dynamic> json) => Cast(
        id: json["id"],
        gender: json["gender"],
        name: json["name"],
        aka: json["also_known_as"] != null
            ? List<String>.from(json["also_known_as"])
            : null,
        biography: json["biography"],
        birthday: json["birthday"],
        deathday: json["deathday"],
        hometown: json["place_of_birth"] ?? "",
        popularity: json["popularity"],
        character: json["character"],
        profilePath: json["profile_path"],
        originalName: json["original_name"],
      );
}
