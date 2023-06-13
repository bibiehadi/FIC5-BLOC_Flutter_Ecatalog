// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecatalog/data/datasources/add_product_datasource.dart';

// import 'package:flutter_ecatalog/data/datasources/product_datasource.dart';
import 'package:flutter_ecatalog/data/model/request/add_product_request_model.dart';
import 'package:flutter_ecatalog/data/model/response/add_product_response_model.dart';

part 'add_product_event.dart';
part 'add_product_state.dart';

class AddProductBloc extends Bloc<AddProductEvent, AddProductState> {
  final AddProductDatasource datasource;
  AddProductBloc(
    this.datasource,
  ) : super(AddProductStateInitial()) {
    on<DoAddProductEvent>(
      (event, emit) async {
        emit(AddProductStateLoading());
        final resultAdd = await datasource.addProduct(event.requestModel);
        resultAdd.fold((error) => emit(AddProductStateError(message: error)),
            (result) => emit(AddProductStateSuccess(responseModel: result)));
      },
    );
  }
}
