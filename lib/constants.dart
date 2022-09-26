import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/io_client.dart';
import 'dart:io';
import 'package:http/http.dart';
import 'package:my_shop_app/modules/login_screen.dart';
import 'dart:async';
import 'dart:convert';

import 'package:my_shop_app/shared/network/local/cache_helper.dart';
const HOME= 'home';

HttpClient client = new HttpClient();
String ?token ='';

void SignOut(context){
CachHelper.removeData(key: 'token').then((value) {
if(value)
Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
});
}



    