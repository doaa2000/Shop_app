import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_shop_app/cubit/states.dart';
import 'package:my_shop_app/models/login_model.dart';

import 'package:my_shop_app/end_point.dart';
import 'package:my_shop_app/remote/local/dio.dart';

import 'login_states.dart';

class LoginCubit extends Cubit<LoginStates>{
  LoginCubit() : super(LoginInitialStates());

ShopLoginModel ?loginModel;
  static LoginCubit get(context)=>BlocProvider.of(context);

void UserLogin({
  required String email,
  required String password,
})
{
  emit(LoginLoadingStates());
DioHelper.Postdata(
  url:'login', data: {
  'email':email,
  'password':password,
}).then((value) {
 loginModel=ShopLoginModel.fromJson(value.data);
  print(value.data);
emit(LoginSuccessStates( loginModel));
},).catchError((error){
print(error.toString());
  emit(LoginErrorStates(error.toString()));
});
}


bool isPassword= false;

IconData suffixIcon=Icons.visibility_rounded;

void ChangePasswordVisibility()
{
  emit(ChangePasswordVisibilitystate());
  isPassword=!isPassword;

  suffixIcon=isPassword?Icons.visibility_outlined:Icons.visibility_off_outlined;
}

}