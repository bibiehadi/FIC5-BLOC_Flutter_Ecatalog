part of 'register_bloc.dart';

abstract class RegisterEvent {}

class DoRegisterEvent extends RegisterEvent {
  final RegisterRequestModel request;

  DoRegisterEvent({required this.request});
}
