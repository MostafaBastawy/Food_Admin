import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_admin_interface/cubit/cubit.dart';
import 'package:food_admin_interface/cubit/states.dart';
import 'package:food_admin_interface/shared/components/default_button.dart';
import 'package:food_admin_interface/shared/design/colors.dart';

class AddNewCategory extends StatelessWidget {
  const AddNewCategory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppStates>(
      builder: (BuildContext context, state) => Scaffold(
        appBar: AppBar(
          title: const Padding(
            padding: EdgeInsetsDirectional.only(start: 30.0),
            child: Text('Add New Category'),
          ),
        ),
        body: Column(
          children: [
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: DefaultButton(
                onPressed: () {},
                labelText: 'Save',
                color: defaultColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
