import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_admin_interface/cubit/cubit.dart';
import 'package:food_admin_interface/cubit/states.dart';
import 'package:food_admin_interface/models/order_model.dart';
import 'package:food_admin_interface/shared/components/default_divider.dart';
import 'package:food_admin_interface/shared/design/colors.dart';

class OngoingDetailsOrderScreen extends StatelessWidget {
  OrderDataModel? orderDataModel;
  int deliveryFee = 0;
  OngoingDetailsOrderScreen({
    Key? key,
    required this.orderDataModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppCubit cubit = AppCubit.get(context);
    if (orderDataModel!.orderType == 'Delivery') {
      deliveryFee = 15;
    }
    {
      deliveryFee = 0;
    }
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
                                '${orderDataModel!.orderPaymentMethod}',
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
                color: Colors.white,
                width: double.infinity,
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  children: [
                    const Icon(
                      Icons.phone,
                      color: defaultColor,
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.only(start: 15.0),
                      child: Text(
                        '${orderDataModel!.orderReceiverNumber}',
                      ),
                    ),
                  ],
                ),
              ),
              const DefaultDivider(),
              Container(
                color: Colors.white,
                width: double.infinity,
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  children: [
                    const Icon(
                      Icons.mail,
                      color: defaultColor,
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.only(start: 15.0),
                      child: Text(
                        '${orderDataModel!.orderReceiverEmail}',
                      ),
                    ),
                  ],
                ),
              ),
              const DefaultDivider(),
              Container(
                color: Colors.white,
                width: double.infinity,
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  children: [
                    const Icon(
                      Icons.location_on,
                      color: defaultColor,
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.only(start: 15.0),
                      child: Text(
                        '${orderDataModel!.orderReceiverAddress}',
                      ),
                    ),
                  ],
                ),
              ),
              const DefaultDivider(),
              Container(
                color: pastOrderColor,
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    SizedBox(
                      width: 120.0,
                      child: Text(
                        'Items',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15.0),
                      ),
                    ),
                    Text(
                      'Quantity',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 15.0),
                    ),
                    SizedBox(
                      width: 40.0,
                      child: Text(
                        'Price',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15.0),
                      ),
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
                color: pastOrderColor,
                width: double.infinity,
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Text(
                          'Subtotal  :  ',
                          style: TextStyle(fontSize: 17.0),
                        ),
                        SizedBox(
                          width: 50.0,
                          child: Text(
                            '\$ ${(int.parse(orderDataModel!.orderTotalValue!) - deliveryFee)}',
                            style: const TextStyle(fontSize: 17.0),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Text(
                          'Delivery Fee  :  ',
                          style: TextStyle(fontSize: 17.0),
                        ),
                        SizedBox(
                          width: 50.0,
                          child: Text(
                            '\$ $deliveryFee',
                            style: const TextStyle(fontSize: 17.0),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: const [
                        Text(
                          '+ Service Tax (0%)  :  ',
                          style: TextStyle(fontSize: 17.0),
                        ),
                        SizedBox(
                          width: 50.0,
                          child: Text(
                            '\$ 0',
                            style: TextStyle(fontSize: 17.0),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: const [
                        Text(
                          '- Discount (0%)  :  ',
                          style: TextStyle(fontSize: 17.0),
                        ),
                        SizedBox(
                          width: 50.0,
                          child: Text(
                            '\$ 0',
                            style: TextStyle(fontSize: 17.0),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.only(top: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const Text(
                            'Total  :  ',
                            style: TextStyle(
                                fontSize: 20.0, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            width: 50.0,
                            child: Text(
                              '\$ ${orderDataModel!.orderTotalValue}',
                              style: const TextStyle(
                                  fontSize: 20.0, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const DefaultDivider(),
            ],
          ),
        ),
      ),
    );
  }
}
