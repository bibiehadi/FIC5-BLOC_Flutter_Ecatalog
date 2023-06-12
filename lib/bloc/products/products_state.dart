// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'products_bloc.dart';

abstract class ProductsState {}

class ProductsStateInitial extends ProductsState {}

class ProductsStateLoading extends ProductsState {}

class ProductsStateSuccess extends ProductsState {
  List<ProductsResponseModel> listProduct;
  ProductsStateSuccess({
    required this.listProduct,
  });
}

class ProductsStateError extends ProductsState {
  final String message;
  ProductsStateError({
    required this.message,
  });
}
