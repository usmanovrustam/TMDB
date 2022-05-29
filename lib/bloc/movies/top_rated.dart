import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:tmdb/bloc/base/simple_get.dart';
import 'package:tmdb/model/movie.dart';
import 'package:tmdb/model/pagination/paginated_response.dart';
import 'package:tmdb/repositories/movie.dart';

class TopRatedState extends SimpleGetState<PaginatedResponse<Movie>> {
  TopRatedState({
    bool fetching = false,
    PaginatedResponse<Movie>? movies,
    Exception? exception,
  }) : super(fetching: fetching, data: movies, exception: exception);
}

class TopRatedBloc extends Cubit<TopRatedState> {
  final client = http.Client();

  TopRatedBloc() : super(TopRatedState());

  Future<void> fetchMovies(int page) async {
    emit(TopRatedState(fetching: true, movies: state.data));

    try {
      final movies = await MovieRepository.fetchMovies(
        client,
        queryParams: {"page": page},
      );

      if (state.data != null && page != 1) {
        for (var element in state.data!.objects!.reversed) {
          movies.objects!.insert(0, element);
        }
      }

      emit(TopRatedState(movies: movies));
    } on Exception catch (exp) {
      emit(TopRatedState(exception: exp, movies: state.data));
    }
  }

  @override
  Future<void> close() {
    client.close();
    return super.close();
  }
}
