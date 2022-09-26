import 'package:my_shop_app/models/login_model.dart';

abstract class LoginStates {}

class LoginInitialStates extends LoginStates{}

class LoginSuccessStates extends LoginStates{
final ShopLoginModel ?loginModel;

  LoginSuccessStates(
     this.loginModel,
  );
}

class LoginErrorStates extends LoginStates{
  String error;
  LoginErrorStates(this.error);
}

class LoginLoadingStates extends LoginStates{}

class ChangePasswordVisibilitystate extends LoginStates{}
