import 'package:my_shop_app/models/login_model.dart';

abstract class RegisterStates {}

class RegisterInitialStates extends RegisterStates{}

class RegisterSuccessStates extends RegisterStates{
final ShopLoginModel ?loginModel;

  RegisterSuccessStates(
     this.loginModel,
  );
}

class RegisterErrorStates extends RegisterStates{
  String error;
  RegisterErrorStates(this.error);
}

class RegisterLoadingStates extends RegisterStates{}

class RegisterChangePasswordVisibilitystate extends RegisterStates{}
