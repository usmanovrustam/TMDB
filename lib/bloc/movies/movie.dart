import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:tmdb/bloc/base/simple_get.dart';
import 'package:tmdb/model/movie.dart';
import 'package:tmdb/repositories/movie.dart';

class MovieDetailsState extends SimpleGetState<Movie> {
  MovieDetailsState({
    bool fetching = false,
    Movie? movie,
    Exception? exception,
  }) : super(fetching: fetching, data: movie, exception: exception);
}

class MovieDetailsBloc extends Cubit<MovieDetailsState> {
  final client = http.Client();

  MovieDetailsBloc() : super(MovieDetailsState());

  Future<void> fetchMovie(int id) async {
    emit(MovieDetailsState(fetching: true, movie: state.data));

    try {
      final movie = await MovieRepository.fetchMovie(client, id: id);

      emit(MovieDetailsState(movie: movie));
    } on Exception catch (exp) {
      emit(MovieDetailsState(exception: exp, movie: state.data));
    }
  }

  @override
  Future<void> close() {
    client.close();
    return super.close();
  }
}
