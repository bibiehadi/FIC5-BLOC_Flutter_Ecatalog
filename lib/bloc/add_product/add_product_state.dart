// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'add_product_bloc.dart';

abstract class AddProductState {}

class AddProductStateInitial extends AddProductState {}

class AddProductStateLoading extends AddProductState {}

class AddProductStateSuccess extends AddProductState {
  final AddProductResponseModel responseModel;
  AddProductStateSuccess({
    required this.responseModel,
  });
}

class AddProductStateError extends AddProductState {
  final String message;
  AddProductStateError({
    required this.message,
  });
}
