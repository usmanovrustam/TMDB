import 'package:flutter/foundation.dart';
import 'package:tmdb/utils/constants.dart';

class PaginatedRequestBody {
  final int? page;
  final int? limit;
  final Map<String, dynamic>? filters;

  PaginatedRequestBody({
    this.page,
    this.limit = DEFAULT_PAGE_LIMIT,
    this.filters,
  });

  PaginatedRequestBody.clone(PaginatedRequestBody body)
      : this(
          page: body.page,
          limit: body.limit,
          filters: body.filters,
        );

  PaginatedRequestBody copyWith({
    int? page,
    String? view,
    int? limit,
    Map<String, dynamic>? filters,
  }) =>
      PaginatedRequestBody(
        page: page ?? this.page,
        filters: filters ?? this.filters,
        limit: limit ?? this.limit,
      );

  Map<String, dynamic> get queryParams => {
        "page": page,
        "limit": limit,
        if (filters != null) ...?filters,
      };

  @override
  int get hashCode {
    int hashCode = page.hashCode + limit.hashCode;

    if (filters != null) {
      filters!.forEach((key, value) =>
          hashCode += filters![key].hashCode + filters![value].hashCode);
    }

    return hashCode;
  }

  @override
  bool operator ==(Object other) =>
      other is PaginatedRequestBody &&
      mapEquals(queryParams, other.queryParams);
}
