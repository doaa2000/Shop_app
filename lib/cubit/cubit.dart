import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/io_client.dart';
import 'package:my_shop_app/constants.dart';
import 'package:my_shop_app/cubit/states.dart';
import 'package:my_shop_app/models/categories_model.dart';
import 'package:my_shop_app/models/change_favorite_model.dart';
import 'package:my_shop_app/models/favorite_model.dart';
import 'package:my_shop_app/models/home_model.dart';
import 'package:my_shop_app/models/login_model.dart';
import 'package:my_shop_app/modules/categories/categories.dart';
import 'package:my_shop_app/modules/favorites/favorites.dart';
import 'package:my_shop_app/modules/products/products.dart';
import 'package:my_shop_app/modules/settings/settings.dart';
import 'package:my_shop_app/end_point.dart';
import 'package:my_shop_app/remote/local/dio.dart';


class ShopCubit extends Cubit<ShopStates>{
  ShopCubit() : super(ShopInitialStates());

static ShopCubit Get(context) => BlocProvider.of(context);

int CurrentIndex=0;
HomeModel? homeModel;
 Map<int,bool> favorites={};
void getHomeData(){

DioHelper.getData(
  url: HOME,
 token: token,

).then((value) {
homeModel=HomeModel.fromJson(value.data);

//print(homeModel!.data!.banners[0].image);

homeModel!.data!.products.forEach((element)
{
favorites.addAll({
element.id!:element.in_favorite! ,
});


});
print(favorites.toString());
  emit(SuccessHomeDataState());
}).catchError((error){
  print(error.toString());
emit(ErrorHomeDataState());
});
}

CategoriesModel? categoriesModel;
void getCategoriesData(){

DioHelper.getData(
  url: GET_CATEGORIES,
 token: token,

).then((value) {
categoriesModel=CategoriesModel.fromJson(value.data);


  emit(SuccessCategoriesState());
}).catchError((error){
  print(error.toString());
emit(ErrorCategoriesState());
});
}

List<Widget> Screens=
[
   ProductScreen(),
   CategoriesScreen(),
   FavoriteScreen(),
   SettingsScreen(),
 
  
];
void ChangeBottomNavBar(int index){
CurrentIndex = index;
emit(ChangeBottomNavState());
}
ChangeFavoriteModel ?changeFavoriteModel;


void ChangeFavorite(int ProductId){

 favorites[ProductId] = !favorites[ProductId]!;
 emit(SuccessChangeFavoritesState());
  DioHelper.Postdata(
    url: FAVORITES,
     data:{
       'product_id':ProductId,

     } ,
     token: token,
     
     ).then((value) {

changeFavoriteModel = ChangeFavoriteModel.fromJson(value.data);
print(value.data);
if(changeFavoriteModel!.status==false)
{
 favorites[ProductId] = !favorites[ProductId]!;
}
else{
  getFavoriteData();
}
emit(SuccessChangeFavoritesState());
     }).catchError((error){
        favorites[ProductId] = !favorites[ProductId]!;
       emit(ErrorChangeFavoritesState());
     });
}

FavoriteModel? favoriteModel;


void getFavoriteData(){
emit(LoadingFavoriteState());
DioHelper.getData(
  url: FAVORITES,
 token: token,

).then((value) {
favoriteModel=FavoriteModel.fromJson(value.data);
print(value.data.toString());

  emit(SuccessGetFavoriteState());
}).catchError((error){
  print(error.toString());
emit(ErrorGetFavoriteState());
});
}

ShopLoginModel? userDataModel;
void getUserDataModel(){

DioHelper.getData(
  url: PROFILE,
 token: token,

).then((value) {
userDataModel=ShopLoginModel.fromJson(value.data);
print(userDataModel!.data!.name);

  emit(SuccessUserDataState());
}).catchError((error){
  print(error.toString());
emit(ErrorUserDataState());
});
}
void UpdateUserDataModel({
  required String name,
  required String email,
  required String phone,
}){

DioHelper.PutData(
  url: UPDATE_PROFILE,
 token: token,
 data: {
   'name':name,
   'email':email,
   'phone':phone,
 }

).then((value) {
userDataModel=ShopLoginModel.fromJson(value.data);
print(userDataModel!.data!.name);

  emit(SuccessUpdateState());
}).catchError((error){
  print(error.toString());
emit(ErrorUpdateState());
});



}



}