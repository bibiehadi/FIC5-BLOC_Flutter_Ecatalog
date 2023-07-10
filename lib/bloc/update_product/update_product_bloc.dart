// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecatalog/data/datasources/update_product_datasource.dart';
import 'package:flutter_ecatalog/data/model/request/update_product_request_model.dart';
import 'package:flutter_ecatalog/data/model/response/products_response_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_product_bloc.freezed.dart';
part 'update_product_event.dart';
part 'update_product_state.dart';

class UpdateProductBloc extends Bloc<UpdateProductEvent, UpdateProductState> {
  final UpdateProductDatasource datasource;
  UpdateProductBloc(
    this.datasource,
  ) : super(const _Initial()) {
    on<_DoUpdated>((event, emit) async {
      emit(const _Loading());
      final result = await datasource.editProduct(event.id, event.requestModel);
      result.fold((l) => emit(_Error(l)), (r) => emit(_Success(r)));
    });
  }
}
