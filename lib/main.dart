import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecatalog/bloc/add_product/add_product_bloc.dart';
import 'package:flutter_ecatalog/bloc/login/login_bloc.dart';
import 'package:flutter_ecatalog/bloc/products/products_bloc.dart';
import 'package:flutter_ecatalog/bloc/register/register_bloc.dart';
import 'package:flutter_ecatalog/data/datasources/add_product_datasource.dart';
import 'package:flutter_ecatalog/data/datasources/auth_datasource.dart';
import 'package:flutter_ecatalog/data/datasources/product_datasource.dart';
import 'package:flutter_ecatalog/presentation/login_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<RegisterBloc>(
          create: (context) => RegisterBloc(AuthDatasource()),
        ),
        BlocProvider<LoginBloc>(
          create: (context) => LoginBloc(AuthDatasource()),
        ),
        BlocProvider<ProductsBloc>(
          create: (context) => ProductsBloc(ProductDatasource()),
        ),
        BlocProvider<AddProductBloc>(
          create: (context) => AddProductBloc(AddProductDatasource()),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.blue,
        ),
        home: const LoginPage(),
      ),
    );
  }
}
