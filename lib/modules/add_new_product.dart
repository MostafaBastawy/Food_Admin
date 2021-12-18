import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_admin_interface/cubit/cubit.dart';
import 'package:food_admin_interface/cubit/states.dart';
import 'package:food_admin_interface/shared/components/default_button.dart';
import 'package:food_admin_interface/shared/components/show_toaster.dart';
import 'package:food_admin_interface/shared/constants.dart';
import 'package:food_admin_interface/shared/design/colors.dart';

class AddNewProduct extends StatelessWidget {
  var productNameController = TextEditingController();
  var productSmallSizePriceController = TextEditingController();
  var productMediumSizePriceController = TextEditingController();
  var productLargeSizePriceController = TextEditingController();
  var productRecipeController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  AddNewProduct({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppCubit cubit = AppCubit.get(context);
    String? categoryName = cubit.categoriesDropList.first;
    return BlocConsumer<AppCubit, AppStates>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, state) => Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Padding(
            padding: EdgeInsetsDirectional.only(start: 30.0),
            child: Text('Add New Product'),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      if (productNameController.text != '') {
                        cubit.getProductImage(
                          productName: productNameController.text,
                        );
                      } else {
                        defaultToast(
                          message: 'product name must be entered first',
                          color: Colors.red,
                          context: context,
                        );
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsetsDirectional.only(top: 20.0),
                      child: Container(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height * 0.25,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          image: DecorationImage(
                            image: cubit.productImageUrl.isNotEmpty
                                ? NetworkImage(cubit.productImageUrl)
                                : const NetworkImage(defaultNewCatPro),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.only(top: 20.0),
                    child: Row(
                      children: [
                        const Text(
                          'Product Category: ',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Spacer(),
                        Container(
                          height: 32.0,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                                color: Colors.grey[400]!, width: 2.0),
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: DropdownButton<String>(
                              style: const TextStyle(color: Colors.black),
                              value: categoryName,
                              underline: Container(
                                height: 0.0,
                              ),
                              onChanged: (String? value) {},
                              items: cubit.categoriesDropList
                                  .map<DropdownMenuItem<String>>(
                                    (String value) => DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    ),
                                  )
                                  .toList(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        border: Border.all(color: Colors.grey, width: 1.0),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: TextFormField(
                        controller: productNameController,
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return '  Required*';
                          }
                        },
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Enter product Name',
                          floatingLabelStyle: TextStyle(color: defaultColor),
                        ),
                        onTap: () {},
                        onChanged: (value) {},
                        onFieldSubmitted: (value) {},
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      border: Border.all(color: Colors.grey, width: 1.0),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: TextFormField(
                      controller: productSmallSizePriceController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Enter product Small Size Price',
                        floatingLabelStyle: TextStyle(color: defaultColor),
                      ),
                      onTap: () {},
                      onChanged: (value) {},
                      onFieldSubmitted: (value) {},
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        border: Border.all(color: Colors.grey, width: 1.0),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: TextFormField(
                        controller: productMediumSizePriceController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Enter product Medium Size Price',
                          floatingLabelStyle: TextStyle(color: defaultColor),
                        ),
                        onTap: () {},
                        onChanged: (value) {},
                        onFieldSubmitted: (value) {},
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      border: Border.all(color: Colors.grey, width: 1.0),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: TextFormField(
                      controller: productLargeSizePriceController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Enter product Large Size Price',
                        floatingLabelStyle: TextStyle(color: defaultColor),
                      ),
                      onTap: () {},
                      onChanged: (value) {},
                      onFieldSubmitted: (value) {},
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        border: Border.all(color: Colors.grey, width: 1.0),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: TextFormField(
                        controller: productRecipeController,
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return '  Required*';
                          }
                        },
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Enter product Recipe',
                          floatingLabelStyle: TextStyle(color: defaultColor),
                        ),
                        onTap: () {},
                        onChanged: (value) {},
                        onFieldSubmitted: (value) {},
                      ),
                    ),
                  ),
                  DefaultButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        cubit.addNewProduct(
                          productName: productNameController.text,
                          productRecipe: productRecipeController.text,
                          productCategory: categoryName,
                          productSmallSizePrice:
                              int.parse(productSmallSizePriceController.text),
                          productMediumSizePrice:
                              int.parse(productMediumSizePriceController.text),
                          productLargeSizePrice:
                              int.parse(productLargeSizePriceController.text),
                        );
                      }
                    },
                    labelText: 'Save',
                    color: defaultColor,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
