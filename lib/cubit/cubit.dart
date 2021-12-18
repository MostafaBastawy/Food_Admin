import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_admin_interface/cubit/states.dart';
import 'package:food_admin_interface/models/category_model.dart';
import 'package:food_admin_interface/models/order_model.dart';
import 'package:image_picker/image_picker.dart';

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
  List<String> categoriesDropList = [];

  void getCategories() {
    FirebaseFirestore.instance
        .collection('categories')
        .snapshots()
        .listen((event) {
      categories = [];
      categoriesDropList = [];
      for (var element in event.docs) {
        categories.add(CategoryDataModel.fromJson(element.data()));
      }
      for (var i in categories) {
        categoriesDropList.add(i.categoryName.toString());
      }
      emit(AppGetCategoriesSuccessState());
    });
  }

  void addNewCategory({
    required String categoryName,
  }) {
    emit(AppAddNewCategoryLoadingState());
    FirebaseFirestore.instance.collection('categories').doc(categoryName).set({
      'categoryName': categoryName,
      'categoryImage': categoryImageUrl,
    }).then((value) {
      emit(AppAddNewCategorySuccessState());
    }).catchError((error) {
      emit(AppAddNewCategoryErrorState(error.toString()));
    });
  }

  File? categoryImage;
  String categoryImageUrl = '';
  var picker = ImagePicker();

  Future<void> getCategoryImage({
    required String categoryName,
  }) async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      categoryImage = File(pickedFile.path);
      emit(AppGetCategoryImageSuccessState());
      uploadCategoryImage(categoryName: categoryName);
    } else {
      emit(AppGetCategoryImageErrorState());
    }
  }

  void uploadCategoryImage({
    required String categoryName,
  }) {
    if (categoryImage != null) {
      firebase_storage.FirebaseStorage.instance
          .ref()
          .child(categoryName)
          .child('$categoryName.jpg')
          .putFile(categoryImage!)
          .then((value) {
        value.ref.getDownloadURL().then((value) {
          categoryImageUrl = value;
        }).catchError((error) {
          emit(AppUploadCategoryImageErrorState(error.toString()));
        });
      }).catchError((error) {
        emit(AppUploadCategoryImageErrorState(error.toString()));
      });
    }
  }

  File? productImage;
  String productImageUrl = '';

  Future<void> getProductImage({
    required String productName,
  }) async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      productImage = File(pickedFile.path);
      emit(AppGetProductImageSuccessState());
      uploadProductImage(productName: productName);
    } else {
      emit(AppGetProductImageErrorState());
    }
  }

  void uploadProductImage({
    required String productName,
  }) {
    if (productImage != null) {
      firebase_storage.FirebaseStorage.instance
          .ref()
          .child(productName)
          .child('$productName.jpg')
          .putFile(productImage!)
          .then((value) {
        value.ref.getDownloadURL().then((value) {
          productImageUrl = value;
        }).catchError((error) {
          emit(AppUploadProductImageErrorState(error.toString()));
        });
      }).catchError((error) {
        emit(AppUploadProductImageErrorState(error.toString()));
      });
    }
  }

  void addNewProduct({
    required String productName,
    required String productRecipe,
    required String productCategory,
    required int productSmallSizePrice,
    required int productMediumSizePrice,
    required int productLargeSizePrice,
  }) {
    emit(AppAddNewProductLoadingState());
    FirebaseFirestore.instance.collection('products').doc(productName).set({
      'productName': productName,
      'productImage': productImageUrl,
      'productRecipe': productRecipe,
      'productCategory': productCategory,
      'productSmallSizePrice': productSmallSizePrice,
      'productMediumSizePrice': productMediumSizePrice,
      'productLargeSizePrice': productLargeSizePrice,
    }).then((value) {
      emit(AppAddNewProductSuccessState());
    }).catchError((error) {
      emit(AppAddNewProductErrorState(error.toString()));
    });
  }

  void doNothing(BuildContext context) {}
}
