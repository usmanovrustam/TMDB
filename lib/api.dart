import 'package:tmdb/settings.dart';

class Api {
  static String get baseURL => Settings.baseUrl;
  static String get socketUrl => Settings.imageUrl;
  static String get topRated => "${Settings.baseUrl}/top_rated";
  static String get popular => "${Settings.baseUrl}/popular";
  static String get upcoming => "${Settings.baseUrl}/upcoming";
}
