

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_shop_app/style/colors.dart';



Function onSubmit=(){};
Function onTap=(){};
Function ?validate=(){};
Function suffixPressed=(){};

// ignore: non_constant_identifier_names
Future NavigateTo(context,widget){

  return Navigator.push(context, MaterialPageRoute(builder: (context)=>widget));
}

Widget defaultFormField({
 required String ?label,
required IconData ?prefixIcon,
 IconData ?suffixIcon,
bool isPassword=false,
 required TextEditingController ?controlloer,
 onSubmit,
 onTap,
required validate,
required TextInputType type,
suffixPressed,
}){

  return TextFormField(
    onFieldSubmitted: onSubmit,
    controller:controlloer ,
    decoration: InputDecoration(
                         border: OutlineInputBorder(),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  borderSide: BorderSide(
                    color:defaultColor,
                  ),
                ),
               hoverColor: defaultColor,
                enabledBorder: OutlineInputBorder(

                  borderRadius: BorderRadius.circular(25.0),
                  borderSide: BorderSide(
                    color:defaultColor,
                    width: 1.0,
                  ),
                ),

         
                          labelText: label,
                          iconColor: defaultColor,
                          prefixIcon: Icon(prefixIcon,),
                          suffixIcon:IconButton(
                            onPressed:suffixPressed ,
                            icon: Icon(suffixIcon,)) ,
                       
                        ),
    obscureText: isPassword,
    validator: validate,
    keyboardType:type ,

    
    
    onTap: onTap,

  );
}

void showToast({
  String ?msg,
  ToastState ?state,
})=>Fluttertoast.showToast(
        msg: msg as String,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: chooseToastColor(state as ToastState),
        textColor: Colors.white,
        fontSize: 16.0
    );

  enum ToastState{SUCCESS, WARNING , ERROR}

  Color chooseToastColor(ToastState state){
    Color color;
switch(state)

{
  case ToastState.SUCCESS :
  color= Colors.green;
  break;
  case ToastState.WARNING :
  color= Colors.amber;
  break;
  case ToastState.ERROR :
  color= Colors.red;
  break;

}
return color;

  }  