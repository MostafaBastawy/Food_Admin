import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_admin_interface/cubit/cubit.dart';
import 'package:food_admin_interface/cubit/states.dart';
import 'package:food_admin_interface/models/order_model.dart';
import 'package:food_admin_interface/modules/order_details_screen.dart';
import 'package:food_admin_interface/shared/components/navigator.dart';
import 'package:food_admin_interface/shared/design/colors.dart';

class OngoingOrders extends StatelessWidget {
  int? index;
  OrderDataModel? orderDataModel;
  OngoingOrders({
    Key? key,
    required this.index,
    required this.orderDataModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppCubit cubit = AppCubit.get(context);
    String? orderStatus = orderDataModel!.orderStatus.toString();
    return BlocBuilder<AppCubit, AppStates>(
      builder: (BuildContext context, state) => Padding(
        padding: const EdgeInsets.all(10.0),
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
                        padding: const EdgeInsetsDirectional.only(start: 10.0),
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
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  width: 1.0,
                  color: Colors.grey[300]!,
                ),
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: Row(
                children: [
                  const Text(
                    'Order Status: ',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    height: 32.0,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.grey[400]!, width: 2.0),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: DropdownButton<String>(
                        style: const TextStyle(color: Colors.black),
                        value: orderStatus,
                        underline: Container(
                          height: 0.0,
                        ),
                        onChanged: (String? value) {
                          cubit.updateOrderStatus(
                            orderStatus: value.toString(),
                            orderDocumentId:
                                cubit.ongoingOrderDocumentId[index!],
                          );
                        },
                        items: <String>[
                          'Pending',
                          'Preparing',
                          'Shipped',
                          'Picked',
                          'Delivered',
                          'Cancelled',
                        ]
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
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Container(
                      height: 31.0,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5.0),
                        border: Border.all(color: defaultColor, width: 2.0),
                      ),
                      child: TextButton(
                        onPressed: () {
                          navigateTo(
                            widget: OrderDetailsScreen(
                              orderDataModel: cubit.allOngoingOrders[index!],
                              index: index,
                            ),
                            context: context,
                          );
                        },
                        child: const Text(
                          'View Details',
                          style: TextStyle(
                            color: defaultColor,
                            fontSize: 12.0,
                          ),
                        ),
                      ),
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
