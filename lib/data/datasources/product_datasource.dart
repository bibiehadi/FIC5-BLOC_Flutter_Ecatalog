import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_ecatalog/data/model/request/add_product_request_model.dart';
import 'package:flutter_ecatalog/data/model/response/add_product_response_model.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_ecatalog/data/model/response/products_response_model.dart';

class ProductDatasource {
  Future<Either<String, List<ProductsResponseModel>>> getListProduct() async {
    final response = await http.get(
      Uri.parse('https://api.escuelajs.co/api/v1/products?offset=0&limit=10'),
      headers: {
        "Content-Type": "application/json",
      },
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

  Future<Either<String, List<ProductsResponseModel>>> loadMoreProduct(
      int page, int limit) async {
    final response = await http.get(
      Uri.parse(
          'https://api.escuelajs.co/api/v1/products?offset=$page&limit=$limit'),
      headers: {
        "Content-Type": "application/json",
      },
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
