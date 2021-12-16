import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_admin_interface/cubit/states.dart';
import 'package:food_admin_interface/models/category_model.dart';
import 'package:food_admin_interface/models/order_model.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  List<String> orderOngoingStatus = ['Pending', 'Preparing', 'Shipped'];
  List<String> orderPostStatus = ['Delivered', 'Cancelled', 'Picked'];
  List<OrderDataModel> allOngoingOrders = [];
  List<OrderDataModel> allPostOrders = [];
  List<String> ongoingOrderDocumentId = [];
  void getAllOngoingOrders() {
    FirebaseFirestore.instance
        .collection('orders')
        .orderBy('orderNumber', descending: true)
        .where("orderStatus", whereIn: orderOngoingStatus)
        .snapshots()
        .listen((event) {
      allOngoingOrders = [];
      ongoingOrderDocumentId = [];
      for (var element in event.docs) {
        allOngoingOrders.add(OrderDataModel.fromJson(element.data()));
        ongoingOrderDocumentId.add(element.id);
      }
      emit(AppGetAllOngoingOrdersSuccessState());
    });
  }

  void getAllPostOrders() {
    FirebaseFirestore.instance
        .collection('orders')
        .orderBy('orderNumber', descending: true)
        .where("orderStatus", whereIn: orderPostStatus)
        .snapshots()
        .listen((event) {
      allPostOrders = [];
      for (var element in event.docs) {
        allPostOrders.add(OrderDataModel.fromJson(element.data()));
      }
      emit(AppGetAllPostOrdersSuccessState());
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

  List<CategoryDataModel> categories = [];

  void getCategories() {
    FirebaseFirestore.instance
        .collection('categories')
        .snapshots()
        .listen((event) {
      categories = [];
      for (var element in event.docs) {
        categories.add(CategoryDataModel.fromJson(element.data()));
      }
      emit(AppGetCategoriesSuccessState());
    });
  }
}
