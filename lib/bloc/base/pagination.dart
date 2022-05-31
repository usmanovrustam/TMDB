import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tmdb/bloc/base/ajax.dart';
import 'package:tmdb/model/pagination/paginated_request.dart';
import 'package:tmdb/model/pagination/paginated_response.dart';

class PaginatedState<T> extends AjaxState {
  int total = 0;
  int page = 0;
  List<T>? items = [];

  PaginatedRequestBody? request;

  /// Constructors.

  PaginatedState({
    this.total = 0,
    this.page = 0,
    this.request,
    List<T>? items,
    bool fetching = false,
    Exception? exception,
  }) : super(fetching: fetching, exception: exception) {
    this.items = items ?? [];
  }

  PaginatedState.clone(PaginatedState<T> self)
      : this(
          items: self.items,
          page: self.page,
          total: self.total,
          fetching: self.fetching,
          exception: self.exception,
          request: self.request,
        );

  PaginatedState.copy(
    PaginatedState<T> self,
    bool fetching, {
    PaginatedRequestBody? request,
    PaginatedResponse<T>? response,
    Exception? exception,
  }) : this(
          items: _items<T>(self, response),
          page: response?.page ?? self.page,
          total: response?.total ?? self.total,
          fetching: fetching,
          exception: exception,
          request: request ?? self.request,
        );

  /// Getters.

  bool get isEmpty => items == null || items!.isEmpty;
  @override
  bool get hasException => exception != null;
  bool get hasMore => items!.length < total;
  bool get fetchingMore => fetching && !isEmpty;
  bool get fetchingFirst => fetching && isEmpty;
  bool get refreshing => page == 1 && fetchingMore;

  /// Utilities.

  static List<T> _items<T>(
      PaginatedState<T> self, PaginatedResponse<T>? response) {
    if (response == null) return self.items!;

    if (response.page == 1) return response.objects!;

    List<T> items = self.items!;
    int startIndex = (response.page! - 1) * self.request!.limit!;

    // if fetching the same page. Remove last fetched items.
    if (startIndex < items.length) {
      items.removeRange(startIndex, items.length);
    }

    return items + response.objects!;
  }

  PaginatedRequestBody nextPage() {
    if (request != null) {
      int nextPage = request!.page! + 1;
      int availablePages = (total / request!.limit!).ceil();

      if (nextPage <= availablePages) {
        return request!.copyWith(page: nextPage, limit: request!.limit);
      }
    }

    return request!;
  }
}

abstract class PaginatedCubit<T extends PaginatedState> extends Cubit<T> {
  PaginatedCubit(T state) : super(state);

  void fetchItems(PaginatedRequestBody request);

  void retry() {
    fetchItems(state.request!);
  }

  /// Mainly used for Pull to refresh
  void reload() {
    final request = PaginatedRequestBody(
      page: 1,
      filters: state.request!.filters,
      limit: state.request!.limit,
    );

    fetchItems(request);
  }
}
