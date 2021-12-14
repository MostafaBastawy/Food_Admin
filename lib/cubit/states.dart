abstract class AppStates {}

class AppInitialState extends AppStates {}

class AppRefreshState extends AppStates {}

class AppGetAllOrdersSuccessState extends AppStates {}

class AppUpdateOrderStatusSuccessState extends AppStates {}

class AppUpdateOrderStatusErrorState extends AppStates {
  final String error;
  AppUpdateOrderStatusErrorState(this.error);
}
