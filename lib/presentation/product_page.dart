// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_ecatalog/bloc/product/product_bloc.dart';
import 'package:flutter_ecatalog/presentation/edit_product_page.dart';

// ignore: must_be_immutable
class ProductPage extends StatefulWidget {
  int id;
  ProductPage({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  bool _isReadMore = false;
  @override
  void initState() {
    context.read<ProductBloc>().add(ProductEvent.doGet(widget.id));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<ProductBloc, ProductState>(
          builder: (context, state) {
            return state.maybeWhen(
              loading: () => const Center(
                child: CircularProgressIndicator(),
              ),
              success: (responseModel) {
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Stack(
                            children: [
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.35,
                                width: MediaQuery.of(context).size.width,
                                child: Image.network(
                                  '${responseModel.images?.last}',
                                  fit: BoxFit.fitWidth,
                                ),
                              ),
                              SafeArea(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      CircleAvatar(
                                        backgroundColor: Colors.black,
                                        child: IconButton(
                                          icon: const Icon(Icons.arrow_back),
                                          color: Colors.white,
                                          onPressed: () =>
                                              Navigator.pop(context),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 10,
                                right: 5,
                                child: CircleAvatar(
                                  child: IconButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => EditPage(
                                              responseModel: responseModel,
                                            ),
                                          ));
                                    },
                                    icon: const Icon(
                                      Icons.edit,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  responseModel.title!,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineSmall
                                      ?.copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                ),
                                Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.star_border_outlined,
                                      size: 20,
                                      color: Colors.amber.shade600,
                                    ),
                                    Text('5',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 5.0,
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            Text(
                              'Price',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium
                                  ?.copyWith(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '\$ ${responseModel.price}',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium
                                  ?.copyWith(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Description : ',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelLarge
                                  ?.copyWith(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            Wrap(
                              children: [
                                Text(
                                  responseModel.description!,
                                  style: Theme.of(context).textTheme.bodyMedium,
                                  maxLines: _isReadMore ? 10 : 2,
                                ),
                                Container(
                                  alignment: Alignment.bottomRight,
                                  padding: const EdgeInsets.all(8.0),
                                  child: InkWell(
                                    child: Text(
                                      _isReadMore ? "Read less" : "Read more",
                                      style:
                                          const TextStyle(color: Colors.blue),
                                    ),
                                    onTap: () {
                                      setState(() {
                                        _isReadMore = !_isReadMore;
                                      });
                                    },
                                  ),
                                )
                              ],
                            ),
                            const Divider(
                              color: Colors.grey,
                              height: 25,
                              thickness: 1,
                              indent: 3,
                              endIndent: 5,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
              orElse: () {
                return Container();
              },
            );
          },
        ),
      ),
    );
  }
}
