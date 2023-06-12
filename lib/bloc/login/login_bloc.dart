// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_ecatalog/data/datasources/auth_datasource.dart';
import 'package:flutter_ecatalog/data/model/request/login_request_model.dart';
import 'package:flutter_ecatalog/data/model/response/login_response_model.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthDatasource authDatasource;
  LoginBloc(this.authDatasource) : super(LoginStateInitial()) {
    on<DoLoginEvent>((event, emit) async {
      emit(LoginStateLoading());
      final result = await authDatasource.login(event.requestModel);
      result.fold((error) => emit(LoginStateError(message: error)),
          (result) => emit(LoginStateSuccess(responseModel: result)));
    });
  }
}
