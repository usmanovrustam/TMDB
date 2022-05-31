import 'dart:convert';

import 'package:http/http.dart' as http;

/// Constants.
const String _defaultMessage = "An unexpected error occurred";
const Map<String, dynamic> _defaultError = {};

/// Utility class to simplify the use of HTTP errors returned by the backend.
class RepositoryException implements Exception {
  http.Response? raw;
  DateTime creation = DateTime.now();
  String message = _defaultMessage;
  Map<String, dynamic> errors = _defaultError;
  int? status;
  int? errorNumber;

  RepositoryException(http.Response errorResponse) {
    raw = errorResponse;

    if (errorResponse.body.isNotEmpty) {
      status = errorResponse.statusCode;
      try {
        // Parse response's body.
        Map<String, dynamic> data = json.decode(errorResponse.body);
        errorNumber = errorResponse.statusCode;
        message =
            data.containsKey('message') ? data['message'] : _defaultMessage;
        errors = data.containsKey('errors') ? data['errors'] : _defaultError;
      } catch (e) {
        // If the body wasn't a JSON object, then must be a plain text error.
        message =
            errorResponse.body.isEmpty ? _defaultMessage : errorResponse.body;
      }
    }
  }

  RepositoryException.err(Exception exp) {
    // Mainly two types of exceptions may occur here:
    // 1. ClientException: Connection closed before full header was received.
    // 2. TypeError: type '(HttpException) => Null' is not a subtype of type '(dynamic) => dynamic'.
    // In both cases we are only interested on the message, not on the full object.
    message = exp.toString();
  }

  bool unauthorized() {
    return status == 401 || status == 400;
  }

  @override
  String toString() => message;
}
