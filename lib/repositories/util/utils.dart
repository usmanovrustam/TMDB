import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tmdb/repositories/util/exception.dart';
import 'package:tmdb/utils/logger.dart';
import 'package:tmdb/utils/uri.dart';

class RepositoryUtils {
  static Future<Map<String, String>> getHeaders() async {
    Map<String, String> headers = {
      "Accept": "application/json",
      "Content-Type": "application/json",
    };

    return headers;
  }

  static String getUri(
    String endpointUrl,
    Map<String, dynamic>? params,
  ) =>
      UriUtils.makeEncodedUri(endpointUrl, queryParameters: params);

  static bool parametersChanged(
    Map<String, dynamic> newParams,
    Map<String, dynamic> oldParams,
  ) {
    if (newParams.length == oldParams.length) {
      bool allEquals = newParams.keys.every((key) =>
          oldParams.containsKey(key) && newParams[key] == oldParams[key]);
      return !allEquals;
    }
    return true;
  }

  static Future<http.Response> executeRequest(
    http.Client client,
    String endpointUrl, {
    String method = 'get',
    Map<String, dynamic>? data,
  }) async {
    final headers = await getHeaders();
    final uri = Uri.parse(
      getUri(
        endpointUrl,
        (method != 'post' && method != 'put') ? data : null,
      ),
    );
    logger.d(<String, dynamic>{
      'TYPE': 'Request >>>',
      'URL': endpointUrl,
      'HEADER': headers,
      'BODY': data
    });

    http.Response response;
    try {
      switch (method) {
        case 'put':
          response = await client.put(
            uri,
            headers: headers,
            body: json.encode(data),
          );
          break;
        case 'patch':
          response = await client.patch(
            uri,
            headers: headers,
            body: json.encode(data),
          );
          break;
        case 'post':
          response = await client.post(
            uri,
            headers: headers,
            body: json.encode(data),
          );
          break;
        case 'delete':
          response = await client.delete(uri, headers: headers);
          break;
        default:
          response = await client.get(uri, headers: headers);
          break;
      }
      logger.d(<String, dynamic>{
        'TYPE': 'Response <<<',
        'STATUS': response.statusCode,
        'HEADER': response.headers,
        'BODY': json.decode(response.body),
      });
    } on Exception catch (exp) {
      throw RepositoryException.err(exp);
    }

    // Check for client or server errors.
    if (response.body.isNotEmpty && response.statusCode >= 400) {
      throw RepositoryException(response);
    }

    return response;
  }

  static Future<http.Response> fetchData(
    http.Client client,
    String endpointUrl, {
    Map<String, dynamic>? data,
  }) async {
    return executeRequest(
      client,
      endpointUrl,
      method: 'get',
      data: data,
    );
  }

  static Future<http.Response> postData(
    http.Client client,
    String endpointUrl, {
    Map<String, dynamic>? data,
  }) async {
    return executeRequest(
      client,
      endpointUrl,
      method: 'post',
      data: data,
    );
  }

  static Future<http.Response> putData(
    http.Client client,
    String endpointUrl, {
    Map<String, dynamic>? data,
  }) async {
    return executeRequest(
      client,
      endpointUrl,
      method: 'put',
      data: data,
    );
  }

  static Future<http.Response> patchData(
    http.Client client,
    String endpointUrl, {
    Map<String, dynamic>? data,
  }) async {
    return executeRequest(
      client,
      endpointUrl,
      method: 'patch',
      data: data,
    );
  }

  static Future<http.Response> deleteData(
    http.Client client,
    String endpointUrl,
  ) async {
    return executeRequest(
      client,
      endpointUrl,
      method: 'delete',
    );
  }

  static Future<http.Response> uploadData(
    String endpointUrl,
    List<http.MultipartFile> body,
  ) async {
    var uri = Uri.parse(endpointUrl);
    var request = http.MultipartRequest('POST', uri);
    request.headers.addAll(await getHeaders());
    request.files.addAll(body);

    // Execute request.

    http.Response response;
    try {
      var streamedResponse = await request.send();
      response = await http.Response.fromStream(streamedResponse);
    } catch (exp) {
      throw RepositoryException.err(exp as Exception);
    }

    // Check for client or server errors.
    if (response.body.isNotEmpty && response.statusCode >= 400) {
      throw RepositoryException(response);
    }

    return response;
  }
}
