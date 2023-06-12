// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'login_bloc.dart';

abstract class LoginState {}

class LoginStateInitial extends LoginState {}

class LoginStateLoading extends LoginState {}

class LoginStateSuccess extends LoginState {
  LoginResponseModel responseModel;
  LoginStateSuccess({
    required this.responseModel,
  });
}

class LoginStateError extends LoginState {
  final String message;
  LoginStateError({
    required this.message,
  });
}
