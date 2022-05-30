import 'package:tmdb/settings.dart';

class Api {
  static String get baseURL => Settings.baseUrl;
  static String get socketUrl => Settings.imageUrl;
  static String get movie => "${Settings.baseUrl}/movie";
  static String get topRated => "${Settings.baseUrl}/movie/top_rated";
  static String get popular => "${Settings.baseUrl}/movie/popular";
  static String get upcoming => "${Settings.baseUrl}/movie/upcoming";
}
