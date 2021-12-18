import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:food_admin_interface/cubit/cubit.dart';
import 'package:food_admin_interface/cubit/states.dart';
import 'package:food_admin_interface/modules/add_new_category.dart';
import 'package:food_admin_interface/modules/add_new_product.dart';
import 'package:food_admin_interface/shared/components/default_button.dart';
import 'package:food_admin_interface/shared/components/default_category_item.dart';
import 'package:food_admin_interface/shared/components/default_drawer.dart';
import 'package:food_admin_interface/shared/components/navigator.dart';
import 'package:food_admin_interface/shared/design/colors.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppCubit cubit = AppCubit.get(context);
    cubit.getCategories();
    return BlocBuilder<AppCubit, AppStates>(
      builder: (BuildContext context, state) => Scaffold(
        appBar: AppBar(
          title: const Padding(
            padding: EdgeInsetsDirectional.only(start: 80.0),
            child: Text('Menu'),
          ),
        ),
        drawer: const DefaultDrawer(),
        body: Column(
          children: [
            Expanded(
              child: ConditionalBuilder(
                condition: cubit.categories.isNotEmpty,
                builder: (BuildContext context) => Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: ListView.separated(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) => Slidable(
                      endActionPane: ActionPane(
                        motion: const DrawerMotion(),
                        children: [
                          SlidableAction(
                            onPressed: cubit.doNothing,
                            backgroundColor: const Color(0xAF1869AA),
                            foregroundColor: Colors.white,
                            icon: Icons.edit,
                            label: 'Edit',
                          ),
                          SlidableAction(
                            onPressed: cubit.doNothing,
                            backgroundColor: Colors.red,
                            foregroundColor: Colors.white,
                            icon: Icons.restore_from_trash,
                            label: 'Delete',
                          ),
                        ],
                      ),
                      child: DefaultCatItem(
                        index: index,
                      ),
                    ),
                    separatorBuilder: (BuildContext context, int index) =>
                        const SizedBox(
                      height: 10.0,
                    ),
                    itemCount: cubit.categories.length,
                  ),
                ),
                fallback: (BuildContext context) => const Center(
                  child: CircularProgressIndicator(
                    color: defaultColor,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                children: [
                  Expanded(
                    child: DefaultButton(
                      onPressed: () {
                        navigateTo(widget: AddNewCategory(), context: context);
                      },
                      color: defaultColor,
                      labelText: 'Add Category',
                      height: 40.0,
                    ),
                  ),
                  const SizedBox(width: 10.0),
                  Expanded(
                    child: DefaultButton(
                      onPressed: () {
                        navigateTo(widget: AddNewProduct(), context: context);
                      },
                      color: defaultColor,
                      labelText: 'Add Product',
                      height: 40.0,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
