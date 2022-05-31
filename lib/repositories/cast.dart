import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tmdb/api.dart';
import 'package:tmdb/model/cast.dart';
import 'package:tmdb/repositories/util/utils.dart';

class CastRepository {
  static Future<List<Cast>> fetchCasts(
    http.Client client, {
    int? id,
  }) async {
    final response = await RepositoryUtils.fetchData(
      client,
      "${Api.movie}/$id/casts",
    );

    // Parse response.
    final body = json.decode(response.body);

    List<Cast> casts = [];

    for (var cast in body["cast"]) {
      casts.add(Cast.fromJson(cast));
    }

    return casts;
  }

  static Future<Cast> fetchCast(
    http.Client client, {
    int? id,
  }) async {
    final response = await RepositoryUtils.fetchData(
      client,
      "${Api.person}/$id",
    );

    // Parse response.
    final body = json.decode(response.body);

    return Cast.fromJson(body);
  }
}
