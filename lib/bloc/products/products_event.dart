// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'products_bloc.dart';

abstract class ProductsEvent {}

class GetListProductEvent extends ProductsEvent {}

class LoadMoreProductEvent extends ProductsEvent {
  List<ProductsResponseModel> listProduct;
  int? page, limit;
  LoadMoreProductEvent({
    required this.listProduct,
    required this.page,
    required this.limit,
  });
}
