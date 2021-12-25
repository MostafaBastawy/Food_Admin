import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_admin_interface/cubit/cubit.dart';
import 'package:food_admin_interface/cubit/states.dart';
import 'package:food_admin_interface/modules/menu_screen.dart';
import 'package:food_admin_interface/shared/components/default_button.dart';
import 'package:food_admin_interface/shared/components/navigator.dart';
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
    String smallPrice = '';
    String mediumPrice = '';
    String largePrice = '';

    return BlocConsumer<AppCubit, AppStates>(
      listener: (BuildContext context, state) {
        if (state is AppAddNewProductSuccessState) {
          defaultToast(
            message:
                '${productNameController.text} category added successfully',
            color: Colors.green,
            context: context,
          );
          productNameController.text = '';
          cubit.productImageUrl = '';

          navigateAndFinish(widget: const MenuScreen(), context: context);
        }
        if (state is AppAddNewProductErrorState) {
          defaultToast(
            message: state.error.substring(30),
            color: Colors.red,
            context: context,
          );
          navigateAndFinish(widget: const MenuScreen(), context: context);
        }
      },
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

                      if (productNameController.text != '' ) {
                        cubit.getProductImage(
                          productName: productNameController.text,
                          categoryName: categoryName.toString(),
                        );
                      } else {
                        defaultToast(
                          message: 'product name must be entered first',
                          color: Colors.red,
                          context: context,
                        );
                      }
                    },
                    child: ConditionalBuilder(

                      condition: state is! AppGetProductImageLoadingState,
                      builder: (BuildContext context) =>Padding(
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
                      ), fallback: (BuildContext context) =>SizedBox(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 0.25,
                      child:const Center(child: CircularProgressIndicator(),),

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
                              onChanged: (String? value) {
                                categoryName = value.toString();
                                cubit.emit(AppRefreshState());
                              },
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
                      onChanged: ( value) {
                        smallPrice = value;
                      },
                      onFieldSubmitted: ( value) {},
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
                        onChanged: (value) {mediumPrice = value;},
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
                      onChanged: (value) {largePrice = value;},
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
                  ConditionalBuilder(
                    condition: state is! AppAddNewProductLoadingState,
                    builder: (BuildContext context) => DefaultButton(
                      onPressed: () {

                        if (formKey.currentState!.validate()) {
                          if(cubit.productImageUrl.isNotEmpty){
                            cubit.addNewProduct(
                              productName: productNameController.text,
                              productRecipe: productRecipeController.text,
                              productCategory: categoryName.toString(),
                              productSmallSizePrice:smallPrice.isNotEmpty ? int.parse(smallPrice) : null,
                              productMediumSizePrice:mediumPrice.isNotEmpty ? int.parse(mediumPrice) : null ,
                              productLargeSizePrice:largePrice.isNotEmpty ? int.parse(largePrice) : null ,

                            );
                          }
                        }
                      },
                      labelText: 'Save',
                      color: defaultColor,
                    ),
                    fallback: (BuildContext context) => const Center(
                      child: CircularProgressIndicator(),
                    ),
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
