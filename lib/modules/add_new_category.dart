import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
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

class AddNewCategory extends StatelessWidget {
  var categoryNameController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  AddNewCategory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppCubit cubit = AppCubit.get(context);
    return BlocConsumer<AppCubit, AppStates>(
      listener: (BuildContext context, state) {
        if (state is AppAddNewCategorySuccessState) {
          defaultToast(
            message:
                '${categoryNameController.text} category added successfully',
            color: Colors.green,
            context: context,
          );
          categoryNameController.text = '';
          cubit.categoryImageUrl = '';

          navigateAndFinish(widget: const MenuScreen(), context: context);
        }
        if (state is AppAddNewCategoryErrorState) {
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
            child: Text('Add New Category'),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    if (categoryNameController.text != '') {
                      cubit.getCategoryImage(
                        categoryName: categoryNameController.text,
                      );
                    } else {
                      defaultToast(
                          message: 'category name must be entered first',
                          color: Colors.red,
                          context: context);
                    }
                  },
                  child: ConditionalBuilder(
                    condition: state is! AppGetCategoriesLoadingState,

                    builder: (BuildContext context) =>Padding(
                      padding: const EdgeInsetsDirectional.only(top: 20.0),
                      child: Container(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height * 0.25,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          image: DecorationImage(
                            image: cubit.categoryImageUrl.isNotEmpty
                                ? NetworkImage(cubit.categoryImageUrl)
                                : const NetworkImage(defaultNewCatPro),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
                    fallback: (BuildContext context) =>SizedBox(
                      width: double.infinity,
                        height: MediaQuery.of(context).size.height * 0.25,
                        child:  const Center(child: CircularProgressIndicator(),)),
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
                      controller: categoryNameController,
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return '  Required*';
                        }
                      },
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Enter Category Name',
                        floatingLabelStyle: TextStyle(color: defaultColor),
                      ),
                      onTap: () {},
                      onChanged: (value) {},
                      onFieldSubmitted: (value) {},
                    ),
                  ),
                ),
                const Spacer(),
                ConditionalBuilder(
                  condition: state is! AppAddNewCategoryLoadingState,
                  builder: (BuildContext context) => DefaultButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        if(cubit.categoryImageUrl.isNotEmpty){
                          cubit.addNewCategory(
                            categoryName: categoryNameController.text,
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
    );
  }
}
