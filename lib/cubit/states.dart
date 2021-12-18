abstract class AppStates {}

class AppInitialState extends AppStates {}

class AppRefreshState extends AppStates {}

class AppGetAllOngoingOrdersSuccessState extends AppStates {}

class AppGetAllPostOrdersSuccessState extends AppStates {}

class AppGetCategoriesSuccessState extends AppStates {}

class AppUpdateOrderStatusSuccessState extends AppStates {}

class AppUpdateOrderStatusErrorState extends AppStates {
  final String error;
  AppUpdateOrderStatusErrorState(this.error);
}

class AppAddNewCategorySuccessState extends AppStates {}

class AppAddNewCategoryErrorState extends AppStates {
  final String error;
  AppAddNewCategoryErrorState(this.error);
}

class AppGetCategoryImageSuccessState extends AppStates {}

class AppGetCategoryImageErrorState extends AppStates {}

class AppUploadCategoryImageSuccessState extends AppStates {}

class AppUploadCategoryImageErrorState extends AppStates {
  final String error;
  AppUploadCategoryImageErrorState(this.error);
}

class AppGetProductImageSuccessState extends AppStates {}

class AppGetProductImageErrorState extends AppStates {}

class AppUploadProductImageSuccessState extends AppStates {}

class AppUploadProductImageErrorState extends AppStates {
  final String error;
  AppUploadProductImageErrorState(this.error);
}

class AppAddNewProductSuccessState extends AppStates {}

class AppAddNewProductErrorState extends AppStates {
  final String error;
  AppAddNewProductErrorState(this.error);
}
