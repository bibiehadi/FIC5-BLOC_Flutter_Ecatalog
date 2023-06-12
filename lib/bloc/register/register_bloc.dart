// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_ecatalog/data/datasources/auth_datasource.dart';
import 'package:flutter_ecatalog/data/model/request/register_request_model.dart';
import 'package:flutter_ecatalog/data/model/response/register_response_model.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final AuthDatasource datasource;
  RegisterBloc(
    this.datasource,
  ) : super(RegisterStateInitial()) {
    on<DoRegisterEvent>((event, emit) async {
      emit(RegisterStateLoading());
      final result = await datasource.register(event.request);
      result.fold((error) => emit(RegisterStateError(message: error)),
          (result) => emit(RegisterStateSuccess(result: result)));
    });
  }
}
