import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_shop_app/cubit/states.dart';
import 'package:my_shop_app/login_cubit/login_states.dart';

import 'package:my_shop_app/models/login_model.dart';
import 'package:my_shop_app/register/cubit/states.dart';

import 'package:my_shop_app/end_point.dart';
import 'package:my_shop_app/remote/local/dio.dart';


class RegisterCubit extends Cubit<RegisterStates>{
  RegisterCubit() : super(RegisterInitialStates());

ShopLoginModel ?loginModel;
  static RegisterCubit get(context)=>BlocProvider.of(context);

void UserRegister({
  required String email,
  required String password,
   required String phone,
   required String name,
})
{
  emit(RegisterLoadingStates());
DioHelper.Postdata(url:REGISTER, data: {
  'email':email,
  'password':password,
  'phone':phone,
  'name':name,
}).then((value) 
{
loginModel=ShopLoginModel.fromJson(value.data);
  print(value.data);
emit(RegisterSuccessStates( loginModel));
},).catchError((error){
print(error.toString());
  emit(RegisterErrorStates(error.toString()));
});
}


bool isPassword= false;

IconData suffixIcon=Icons.visibility_outlined;

void ChangePasswordVisibility()
{
  emit(RegisterChangePasswordVisibilitystate());
  isPassword=!isPassword;

  suffixIcon=isPassword?Icons.visibility_outlined:Icons.visibility_off_outlined;
}

}