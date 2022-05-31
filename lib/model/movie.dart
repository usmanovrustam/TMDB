import 'package:tmdb/settings.dart';
import 'package:tmdb/utils/constants.dart';

class Movie {
  int? id;
  String? title;
  double? voteAverage;
  int? voteCount;
  int? budget;
  int? revenue;
  int? runtime;
  String? releaseDate;
  String? homepage;
  String? posterPath;
  double? popularity;
  String? overview;
  String? originalTitle;
  String? originalLanguage;
  List<int>? genreIds;
  String? backdropPath;
  bool? adult;
  bool? video;

  Movie({
    this.id,
    this.title,
    this.budget,
    this.homepage,
    this.voteAverage,
    this.voteCount,
    this.releaseDate,
    this.posterPath,
    this.popularity,
    this.overview,
    this.originalTitle,
    this.originalLanguage,
    this.genreIds,
    this.runtime,
    this.revenue,
    this.backdropPath,
    this.adult,
    this.video,
  });

  List<String> get genres {
    List<Map<String, dynamic>> data = [];
    for (var element1 in genreIds!) {
      data.addAll(
        List<Map<String, dynamic>>.from(
          GENRES.where((element) => element1 == element["id"]),
        ).toList(),
      );
    }

    return List<String>.generate(
      genreIds!.length,
      (index) => data[index]["name"],
    );
  }

  int get hour => runtime! ~/ 60;

  int get minutes => runtime! % 60;

  String get displayRunTime =>
      hour > 0 ? "$hour Hour $displayMinute" : "$minutes Minute";

  String get displayMinute => minutes != 0 ? "$minutes Minute" : "";

  String get nameWithDate =>
      "$originalTitle (${releaseDate!.isNotEmpty ? DateTime.parse(releaseDate!).year : ""})";

  String get voteAvgWithCount => '$voteAverage ($voteCount)';

  String get backdropImage => "${Settings.imageUrl}$backdropPath";

  String get posterImage => "${Settings.imageUrl}$posterPath";

  factory Movie.fromJson(Map<String, dynamic> json) => Movie(
        id: json["id"],
        title: json["title"],
        voteAverage: json["vote_average"] is int
            ? (json["vote_average"] as int).toDouble()
            : json["vote_average"],
        voteCount: json["vote_count"],
        releaseDate: json["release_date"],
        posterPath: json["poster_path"],
        popularity: json["popularity"],
        overview: json["overview"],
        homepage: json["homepage"] ?? "",
        originalTitle: json["original_title"],
        budget: json["budget"],
        revenue: json["revenue"],
        runtime: json["runtime"],
        originalLanguage: json["original_language"],
        genreIds: json["genre_ids"] != null
            ? List<int>.from(json["genre_ids"])
            : null,
        backdropPath: json["backdrop_path"],
        adult: json["adult"],
        video: json["video"],
      );
}
