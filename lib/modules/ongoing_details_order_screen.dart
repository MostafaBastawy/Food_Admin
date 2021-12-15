import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_admin_interface/cubit/cubit.dart';
import 'package:food_admin_interface/cubit/states.dart';
import 'package:food_admin_interface/models/order_model.dart';
import 'package:food_admin_interface/shared/design/colors.dart';

class OngoingDetailsOrderScreen extends StatelessWidget {
  OrderDataModel? orderDataModel;
  OngoingDetailsOrderScreen({
    Key? key,
    required this.orderDataModel,
  }) : super(key: key);

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
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(15.0),
                decoration: BoxDecoration(
                  color: pastOrderColor,
                  border: Border.all(
                    width: 1.0,
                    color: Colors.grey[300]!,
                  ),
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 30.0,
                          width: 30.0,
                          child: Image.asset(
                            orderDataModel!.orderType == 'Delivery'
                                ? 'assets/images/delivery-icon.png'
                                : 'assets/images/preparation-icon.png',
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsetsDirectional.only(start: 10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                orderDataModel!.orderReceiverName.toString(),
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                orderDataModel!.orderDateTime.toString(),
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 13.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Spacer(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            SizedBox(
                              child: Text(
                                'Order id:  ${orderDataModel!.orderNumber}',
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 13.0,
                                ),
                              ),
                            ),
                            SizedBox(
                              child: Text(
                                'Total: \$ ${orderDataModel!.orderTotalValue}',
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 13.0,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                color: pastOrderColor,
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(15.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    width: 1.0,
                    color: Colors.grey[300]!,
                  ),
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: ListView.separated(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 120.0,
                        child: Text(
                            '• ${orderDataModel!.orderProducts[index].productName}'),
                      ),
                      Text(
                          'Qty:${orderDataModel!.orderProducts[index].productQuantity}'),
                      SizedBox(
                        width: 40.0,
                        child: Text(
                            '\$ ${(orderDataModel!.orderProducts[index].productPrice)! * (orderDataModel!.orderProducts[index].productQuantity!)}'),
                      ),
                    ],
                  ),
                  separatorBuilder: (BuildContext context, int index) =>
                      const SizedBox(height: 10.0),
                  itemCount: orderDataModel!.orderProducts.length,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
