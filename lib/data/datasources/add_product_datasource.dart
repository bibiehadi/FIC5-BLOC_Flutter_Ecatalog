import 'package:dartz/dartz.dart';
import 'package:flutter_ecatalog/data/model/request/add_product_request_model.dart';
import 'package:flutter_ecatalog/data/model/response/add_product_response_model.dart';
import 'package:http/http.dart' as http;

class AddProductDatasource {
  Future<Either<String, AddProductResponseModel>> addProduct(
      AddProductRequestModel requestModel) async {
    final response = await http.post(
      Uri.parse(
        'https://api.escuelajs.co/api/v1/products/',
      ),
      body: requestModel.toJson(),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 201) {
      print(response.body);
      return Right(AddProductResponseModel.fromJson(response.body));
    } else {
      return const Left('Add Product Failed');
    }
  }
}
