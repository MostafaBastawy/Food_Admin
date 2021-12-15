import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_admin_interface/cubit/cubit.dart';
import 'package:food_admin_interface/cubit/states.dart';
import 'package:food_admin_interface/shared/components/default_drawer.dart';
import 'package:food_admin_interface/shared/components/order_type/order_type_ongoing.dart';
import 'package:food_admin_interface/shared/components/order_type/order_type_past.dart';
import 'package:food_admin_interface/shared/design/colors.dart';

class HomeLayoutScreen extends StatelessWidget {
  bool ongoingOrders = true;
  bool pastOrders = false;
  HomeLayoutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppCubit cubit = AppCubit.get(context);
    cubit.getAllOngoingOrders();
    cubit.getAllPostOrders();
    return BlocBuilder<AppCubit, AppStates>(
      builder: (BuildContext context, Object? state) => Scaffold(
        appBar: AppBar(
          title: const Padding(
            padding: EdgeInsetsDirectional.only(start: 60.0),
            child: Text('Our Order\'s'),
          ),
        ),
        drawer: const DefaultDrawer(),
        body: ConditionalBuilder(
          condition: cubit.allOngoingOrders.isNotEmpty,
          builder: (BuildContext context) => Column(
            children: [
              Container(
                height: 50.0,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.fromBorderSide(
                      BorderSide(color: Colors.grey[200]!)),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () {
                          ongoingOrders = true;
                          pastOrders = false;
                          cubit.emit(AppRefreshState());
                        },
                        child: Text(
                          'Ongoing Orders',
                          style: TextStyle(
                            color: ongoingOrders ? defaultColor : Colors.black,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: TextButton(
                        onPressed: () {
                          ongoingOrders = false;
                          pastOrders = true;
                          cubit.emit(AppRefreshState());
                        },
                        child: Text(
                          'Past Orders',
                          style: TextStyle(
                            color: pastOrders ? defaultColor : Colors.black,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              if (ongoingOrders)
                ConditionalBuilder(
                  condition: cubit.allOngoingOrders.isNotEmpty,
                  builder: (BuildContext context) => Expanded(
                    child: ListView.builder(
                      itemBuilder: (BuildContext context, int index) =>
                          OngoingOrders(
                        orderDataModel: cubit.allOngoingOrders[index],
                        index: index,
                      ),
                      itemCount: cubit.allOngoingOrders.length,
                    ),
                  ),
                  fallback: (BuildContext context) => const Padding(
                    padding: EdgeInsetsDirectional.only(top: 200.0),
                    child: Text('There is no ongoing orders'),
                  ),
                ),
              if (pastOrders)
                ConditionalBuilder(
                  condition: cubit.allPostOrders.isNotEmpty,
                  builder: (BuildContext context) => Expanded(
                    child: ListView.builder(
                      itemBuilder: (BuildContext context, int index) =>
                          PastOrders(
                        orderDataModel: cubit.allPostOrders[index],
                        index: index,
                      ),
                      itemCount: cubit.allPostOrders.length,
                    ),
                  ),
                  fallback: (BuildContext context) => const Padding(
                    padding: EdgeInsetsDirectional.only(top: 200.0),
                    child: Text('There is no post orders'),
                  ),
                ),
            ],
          ),
          fallback: (BuildContext context) => const Center(
            child: CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}
