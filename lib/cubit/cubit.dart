import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_admin_interface/cubit/states.dart';
import 'package:food_admin_interface/models/order_model.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  List<OrderDataModel> allOrders = [];
  List<OrderDataModel> allOngoingOrders = [];
  List<OrderDataModel> allPostOrders = [];
  List<String> ongoingOrderDocumentId = [];
  void getAllOrders() {
    FirebaseFirestore.instance
        .collection('orders')
        .orderBy('orderNumber', descending: true)
        .snapshots()
        .listen((event) {
      allOrders = [];
      allOngoingOrders = [];
      allPostOrders = [];
      ongoingOrderDocumentId = [];
      for (var element in event.docs) {
        allOrders.add(OrderDataModel.fromJson(element.data()));
      }
      emit(AppGetAllOrdersSuccessState());
    });
  }

  void updateOrderStatus({
    required String orderStatus,
    required String orderDocumentId,
  }) {
    FirebaseFirestore.instance
        .collection('orders')
        .doc(orderDocumentId)
        .update({'orderStatus': orderStatus}).then((value) {
      emit((AppUpdateOrderStatusSuccessState()));
    }).catchError((error) {
      emit(AppUpdateOrderStatusErrorState(error.toString()));
    });
  }
}
