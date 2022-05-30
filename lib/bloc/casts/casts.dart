import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:tmdb/bloc/base/simple_get.dart';
import 'package:tmdb/model/cast.dart';
import 'package:tmdb/repositories/cast.dart';

class CastsState extends SimpleGetState<List<Cast>> {
  CastsState({
    bool fetching = false,
    List<Cast>? casts,
    Exception? exception,
  }) : super(fetching: fetching, data: casts, exception: exception);
}

class CastsBloc extends Cubit<CastsState> {
  final client = http.Client();

  CastsBloc() : super(CastsState());

  Future<void> fetchCasts(int id) async {
    emit(CastsState(fetching: true, casts: state.data));

    try {
      final casts = await CastRepository.fetchCasts(client, id: id);
      emit(CastsState(casts: casts));
    } on Exception catch (exp) {
      emit(CastsState(exception: exp, casts: state.data));
    }
  }

  @override
  Future<void> close() {
    client.close();
    return super.close();
  }
}
