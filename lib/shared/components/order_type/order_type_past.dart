import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_admin_interface/cubit/cubit.dart';
import 'package:food_admin_interface/cubit/states.dart';
import 'package:food_admin_interface/models/order_model.dart';
import 'package:food_admin_interface/shared/design/colors.dart';

class PastOrders extends StatelessWidget {
  int? index;
  OrderDataModel? orderDataModel;
  PastOrders({Key? key, required this.orderDataModel, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppCubit cubit = AppCubit.get(context);

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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
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
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  cubit.allPostOrders[index!].orderReceiverName
                                      .toString(),
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  cubit.allPostOrders[index!].orderDateTime
                                      .toString(),
                                  style: TextStyle(
                                    color: Colors.grey[500]!,
                                    fontSize: 13.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            'Order id: ${cubit.allPostOrders[index!].orderNumber}',
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 11.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Total: \$ ${cubit.allPostOrders[index!].orderTotalValue}',
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 11.0,
                              fontWeight: FontWeight.bold,
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
                      width: 35.0,
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
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  width: 1.0,
                  color: Colors.grey[300]!,
                ),
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Order Status: Order ${cubit.allPostOrders[index!].orderStatus}',
                    style: TextStyle(
                      color:
                          cubit.allPostOrders[index!].orderStatus == 'Cancelled'
                              ? Colors.red
                              : priceColor,
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  Container(
                    height: 31.0,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5.0),
                      border: Border.all(color: defaultColor, width: 2.0),
                    ),
                    child: TextButton(
                      onPressed: () {},
                      child: const Text(
                        'View Details',
                        style: TextStyle(
                          color: defaultColor,
                          fontSize: 12.0,
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
