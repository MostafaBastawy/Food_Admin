import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_admin_interface/cubit/cubit.dart';
import 'package:food_admin_interface/cubit/states.dart';

class AddNewItem extends StatelessWidget {
  const AddNewItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppStates>(
      builder: (BuildContext context, state) => Container(),
    );
  }
}
