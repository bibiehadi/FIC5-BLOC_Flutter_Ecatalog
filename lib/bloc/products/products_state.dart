// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'products_bloc.dart';

abstract class ProductsState {}

class ProductsStateInitial extends ProductsState {}

class ProductsStateLoading extends ProductsState {}

// class ProductsStateSuccess extends ProductsState {
//   List<ProductsResponseModel> listProduct;
//   ProductsStateSuccess({
//     required this.listProduct,
//   });
// }

class ProductsStateSuccess extends ProductsState {
  List<ProductsResponseModel> listProduct;
  int? page = 0;
  int? size = 10;
  bool? hasMore = true;
  ProductsStateSuccess({
    required this.listProduct,
    required this.page,
    required this.size,
    required this.hasMore,
  });

  ProductsStateSuccess copyWith({
    required List<ProductsResponseModel> listProduct,
    int? page,
    int? size,
    bool? hasMore,
  }) {
    return ProductsStateSuccess(
        listProduct: listProduct, page: page, size: size, hasMore: hasMore);
  }
}

class ProductsStateError extends ProductsState {
  final String message;
  ProductsStateError({
    required this.message,
  });
}
