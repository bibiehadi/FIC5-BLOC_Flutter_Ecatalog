import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_ecatalog/bloc/update_product/update_product_bloc.dart';
import 'package:flutter_ecatalog/data/model/request/add_product_request_model.dart';
import 'package:flutter_ecatalog/data/model/request/update_product_request_model.dart';
import 'package:flutter_ecatalog/data/model/response/product_response_model.dart';

// ignore: must_be_immutable
class EditPage extends StatefulWidget {
  ProductResponseModel responseModel;
  EditPage({
    Key? key,
    required this.responseModel,
  }) : super(key: key);

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  TextEditingController titleController = TextEditingController();

  TextEditingController priceController = TextEditingController();

  TextEditingController descController = TextEditingController();

  @override
  void initState() {
    titleController.text = widget.responseModel.title!;
    priceController.text = widget.responseModel.price.toString();
    descController.text = widget.responseModel.description!;
    super.initState();
  }

  @override
  void dispose() {
    titleController.dispose();
    priceController.dispose();
    descController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Update Product'),
        ),
        body: SafeArea(
          child: BlocConsumer<UpdateProductBloc, UpdateProductState>(
            listener: (context, state) {
              state.maybeWhen(
                orElse: () {},
                success: (responseModel) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content:
                          Text('Update Product ${responseModel.title} Success'),
                      backgroundColor: Colors.blue,
                    ),
                  );
                  Navigator.of(context).pop();
                },
                error: (message) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(message),
                      backgroundColor: Colors.red,
                    ),
                  );
                },
                loading: () => const Center(
                  child: CircularProgressIndicator(),
                ),
              );
            },
            builder: (context, state) {
              state.maybeWhen(
                orElse: () {},
                loading: () => const CircularProgressIndicator(),
              );
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      decoration: const InputDecoration(labelText: 'Title'),
                      controller: titleController,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    TextField(
                      decoration: const InputDecoration(labelText: 'Price'),
                      controller: priceController,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    TextField(
                      decoration: const InputDecoration(
                        labelText: 'Description',
                      ),
                      maxLines: 4,
                      controller: descController,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              UpdateRequestModel model = UpdateRequestModel(
                                  title: titleController.text,
                                  price: int.parse(priceController.text),
                                  description: descController.text);
                              context.read<UpdateProductBloc>().add(
                                  UpdateProductEvent.doUpdate(
                                      widget.responseModel.id!, model));
                            },
                            child: const Text('Update'),
                          ),
                          const SizedBox(
                            width: 8.0,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('Cancel'),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              );
            },
          ),
        ));
  }
}
