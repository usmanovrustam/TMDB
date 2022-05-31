import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:tmdb/bloc/base/simple_get.dart';
import 'package:tmdb/model/cast.dart';
import 'package:tmdb/repositories/cast.dart';

class CastState extends SimpleGetState<Cast> {
  CastState({
    bool fetching = false,
    Cast? cast,
    Exception? exception,
  }) : super(fetching: fetching, data: cast, exception: exception);
}

class CastBloc extends Cubit<CastState> {
  final client = http.Client();

  CastBloc() : super(CastState());

  Future<void> fetchCast(int id) async {
    emit(CastState(fetching: true, cast: state.data));

    try {
      final cast = await CastRepository.fetchCast(client, id: id);
      emit(CastState(cast: cast));
    } on Exception catch (exp) {
      emit(CastState(exception: exp, cast: state.data));
    }
  }

  @override
  Future<void> close() {
    client.close();
    return super.close();
  }
}
