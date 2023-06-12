// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'register_bloc.dart';

abstract class RegisterState {}

class RegisterStateInitial extends RegisterState {}

class RegisterStateLoading extends RegisterState {}

class RegisterStateSuccess extends RegisterState {
  final RegisterResponseModel result;

  RegisterStateSuccess({required this.result});
}

class RegisterStateError extends RegisterState {
  final String message;
  RegisterStateError({
    required this.message,
  });
}
