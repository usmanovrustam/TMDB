class PaginatedResponse<T> {
  final List<T>? objects;
  final int? total;
  final int? page;

  PaginatedResponse({
    this.objects,
    this.total,
    this.page,
  });

  factory PaginatedResponse.fromJson(
    Map<String, dynamic> json,
    Function objectParser,
  ) {
    List<T> parsedObjects = [];
    for (var object in json["results"]) {
      parsedObjects.add(objectParser(object));
    }

    return PaginatedResponse(
      objects: parsedObjects,
      total: json["total_pages"],
      page: json["page"],
    );
  }
}
