import 'package:dio/dio.dart';

class DioHelper{

static Dio ?dio;

static init(){
  dio=Dio(
      BaseOptions(
        baseUrl : 'https://student.valuxapps.com/api/',
        receiveDataWhenStatusError: true,
        )
     );
 }

static Future<Response> getData({
  required String url,
 Map<String , dynamic> ?query,
 String lang = 'en',
 String ?token,
})async{
  dio!.options.headers={
'lang':lang,
'Authorization':token??'',
 'Content-Type':'application/json',

  };
return await dio!.get(
  url,
);
}

   static Future<Response>Postdata({
  required String url,
  Map<String,dynamic>?query,
  required  Map<String,dynamic>data,
   String lang ='en',
   String? token,
})async {
  
   dio!.options.headers = {
     'Lang': lang,
     'Content-Type':'application/json',
     'Authorization': token??' ',
   };
   return await dio!.post(
    url,
    data: data,
    queryParameters: query
  );
  
 }


static Future<Response>PutData({
  required String url,
 required Map<String , dynamic> ?data,
 String lang = 'en',
 String ?token,
})async{
  dio!.options.headers={
'lang':lang,
'Authorization':token??'',
 'Content-Type':'application/json',

  };
return await dio!.put(
  url,
data: data,
);
}


}