// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:flutter_ecatalog/data/datasources/product_datasource.dart';
import 'package:flutter_ecatalog/data/model/response/product_response_model.dart';

part 'product_bloc.freezed.dart';
part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductDatasource datasource;
  ProductBloc(
    this.datasource,
  ) : super(const _Initial()) {
    on<ProductEvent>((event, emit) async {
      try {
        emit(const ProductState.loading());
        final result = await datasource.getProduct(event.id);
        result.fold((l) => emit(ProductState.failed(l)), (r) {
          print('success bloc');
          emit(ProductState.success(r));
        });
      } catch (e) {
        emit(ProductState.error('error message: ${e.toString()}'));
      }
    });
  }
}
