import 'package:dartz/dartz.dart';
import 'package:flutter_ecatalog/data/model/request/update_product_request_model.dart';
import 'package:flutter_ecatalog/data/model/response/products_response_model.dart';
import 'package:http/http.dart' as http;

class UpdateProductDatasource {
  Future<Either<String, ProductsResponseModel>> editProduct(
      int id, UpdateRequestModel requestModel) async {
    final response = await http.put(
      Uri.parse(
        'https://api.escuelajs.co/api/v1/products/$id',
      ),
      headers: {'Content-Type': 'application/json'},
      body: requestModel.toRawJson(),
    );

    if (response.statusCode == 200) {
      return Right(ProductsResponseModel.fromJson(response.body));
    } else {
      return Left('Update Product Failed : ${response.body}');
    }
  }
}
