import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tmdb/api.dart';
import 'package:tmdb/model/movie.dart';
import 'package:tmdb/model/pagination/paginated_response.dart';
import 'package:tmdb/repositories/util/utils.dart';

class MovieRepository {
  static Future<PaginatedResponse<Movie>> fetchTopMovies(
    http.Client client, {
    Map<String, dynamic>? queryParams,
  }) async {
    final response = await RepositoryUtils.fetchData(
      client,
      Api.topRated,
      page: queryParams!["page"],
    );

    // Parse response.
    final pageData = PaginatedResponse<Movie>.fromJson(
      json.decode(response.body),
      (json) => Movie.fromJson(json),
    );

    return pageData;
  }

  static Future<PaginatedResponse<Movie>> fetchPopularMovies(
    http.Client client, {
    Map<String, dynamic>? queryParams,
  }) async {
    final response = await RepositoryUtils.fetchData(
      client,
      Api.popular,
      page: queryParams!["page"],
    );

    // Parse response.
    final pageData = PaginatedResponse<Movie>.fromJson(
      json.decode(response.body),
      (json) => Movie.fromJson(json),
    );

    return pageData;
  }

  static Future<PaginatedResponse<Movie>> fetchUpcomingMovies(
    http.Client client, {
    Map<String, dynamic>? queryParams,
  }) async {
    final response = await RepositoryUtils.fetchData(
      client,
      Api.upcoming,
      page: queryParams!["page"],
    );

    // Parse response.
    final pageData = PaginatedResponse<Movie>.fromJson(
      json.decode(response.body),
      (json) => Movie.fromJson(json),
    );

    return pageData;
  }
}
