import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_ecatalog/data/model/response/products_response_model.dart';

class ProductDatasource {
  Future<Either<String, List<ProductsResponseModel>>> getListProduct() async {
    final response = await http.get(
      Uri.parse('https://api.escuelajs.co/api/v1/products/'),
    );

    if (response.statusCode == 200) {
      print(response.body);
      return Right(
        List<ProductsResponseModel>.from(
          jsonDecode(response.body).map(
            (data) => ProductsResponseModel.fromMap(data),
          ),
        ),
      );
    } else {
      return const Left('Get Product Failed');
    }
  }
}
