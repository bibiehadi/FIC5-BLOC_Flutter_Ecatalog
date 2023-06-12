// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_ecatalog/data/datasources/product_datasource.dart';
import 'package:flutter_ecatalog/data/model/response/products_response_model.dart';

part 'products_event.dart';
part 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  final ProductDatasource datasource;
  ProductsBloc(
    this.datasource,
  ) : super(ProductsStateInitial()) {
    on<GetListProductEvent>((event, emit) async {
      emit(ProductsStateLoading());
      final result = await datasource.getListProduct();
      result.fold(
        (error) => emit(
          ProductsStateError(message: error),
        ),
        (result) => emit(
          ProductsStateSuccess(listProduct: result),
        ),
      );
    });
  }
}
