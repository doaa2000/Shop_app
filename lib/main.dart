import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_shop_app/constants.dart';
import 'package:my_shop_app/cubit/cubit.dart';
import 'package:my_shop_app/cubit/states.dart';
import 'package:my_shop_app/login_cubit/login_states.dart';

import 'package:my_shop_app/modules/home_layout/home_layout.dart';
import 'package:my_shop_app/modules/login_screen.dart';
import 'package:my_shop_app/modules/on_boarding/on_boarding_screen.dart';


import 'package:my_shop_app/remote/local/dio.dart';
import 'package:my_shop_app/shared/bloc_observer.dart';
import 'package:my_shop_app/shared/network/local/cache_helper.dart';


 main() async 
 {

   WidgetsFlutterBinding.ensureInitialized();
   ByteData data = await PlatformAssetBundle().load('assets/ca/lets-encrypt-r3.pem');
 SecurityContext.defaultContext.setTrustedCertificatesBytes(data.buffer.asUint8List());
   
 
  DioHelper.init();
 await  CachHelper.init(); 
 Widget widget;

token= CachHelper.getData(key: 'token');
  print(token);
  bool  ?onBoarding = CachHelper.getData( key: 'onBoarding');

  if(onBoarding!=null)
  {
    if(token!=null) widget=HomeLayout();
    else widget =  LoginScreen();

  }
  else
  {
    widget= OnBoardingScreen();
  }
 
  runApp( MyApp(startWidget: widget,));
}

class MyApp extends StatelessWidget {
  


Widget startWidget;
MyApp({

required this.startWidget,
});
  get defaultColor => null;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
  final ThemeData theme = ThemeData();

return MultiBlocProvider(
  
  
  providers: [
BlocProvider(
  create: (context)=>ShopCubit()..getHomeData()..getCategoriesData()..getFavoriteData()..getUserDataModel(),
  ),

], child: BlocConsumer<ShopCubit,ShopStates>(

  listener: (context,state)=>{},
  builder: (context,state){
    return MaterialApp(

debugShowCheckedModeBanner: false,



theme: ThemeData(
 
appBarTheme: AppBarTheme(backgroundColor:Color.fromARGB(255, 255, 255, 255),
elevation: 0.0,
titleTextStyle:TextStyle(color: Colors.black,fontSize: 25.0,fontWeight: FontWeight.w600) ,
),
primarySwatch: defaultColor,
),
// 6
home: startWidget ,
);
  },
),

);
  }
}

