import 'package:tmdb/settings.dart';
import 'package:tmdb/utils/constants.dart';

class Movie {
  int? id;
  String? title;
  double? voteAverage;
  int? voteCount;
  String? releaseDate;
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
    this.voteAverage,
    this.voteCount,
    this.releaseDate,
    this.posterPath,
    this.popularity,
    this.overview,
    this.originalTitle,
    this.originalLanguage,
    this.genreIds,
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

  String get backdropImage => "${Settings.imageUrl}$backdropPath";

  String get posterImage => "${Settings.imageUrl}$posterPath";

  factory Movie.fromJson(Map<String, dynamic> json) => Movie(
        id: json["id"],
        title: json["title"],
        voteAverage: json["vote_average"],
        voteCount: json["vote_count"],
        releaseDate: json["release_date"],
        posterPath: json["poster_path"],
        popularity: json["popularity"],
        overview: json["overview"],
        originalTitle: json["original_title"],
        originalLanguage: json["original_language"],
        genreIds: List<int>.from(json["genre_ids"]),
        backdropPath: json["backdrop_path"],
        adult: json["adult"],
        video: json["video"],
      );
}
