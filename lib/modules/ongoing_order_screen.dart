import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_admin_interface/cubit/cubit.dart';
import 'package:food_admin_interface/cubit/states.dart';
import 'package:food_admin_interface/models/order_model.dart';

class OngoingOrderScreen extends StatelessWidget {
  OrderDataModel? orderDataModel;
  OngoingOrderScreen({Key? key, required this.orderDataModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppCubit cubit = AppCubit.get(context);
    return BlocBuilder<AppCubit, AppStates>(
      builder: (BuildContext context, state) => Scaffold(
        appBar: AppBar(
          title: const Padding(
            padding: EdgeInsetsDirectional.only(start: 40.0),
            child: Text('Ongoing Order'),
          ),
        ),
      ),
    );
  }
}
