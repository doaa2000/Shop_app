import 'dart:math';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_shop_app/components.dart';
import 'package:my_shop_app/constants.dart';

import 'package:my_shop_app/login_cubit/login_cubit.dart';
import 'package:my_shop_app/login_cubit/login_states.dart';
import 'package:my_shop_app/modules/home_layout/home_layout.dart';
import 'package:my_shop_app/register/register_screen.dart';
import 'package:my_shop_app/shared/network/local/cache_helper.dart';
import 'package:my_shop_app/style/colors.dart';




var emailController =TextEditingController();
var passwordController =TextEditingController();
var formKey = GlobalKey<FormState>();
class LoginScreen extends StatefulWidget {
  const LoginScreen({ Key? key }) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=>LoginCubit(),

      child: BlocConsumer<LoginCubit,LoginStates>(
listener: (context,state)=>{

  if(state is LoginSuccessStates){
    if(state.loginModel?.status==true)
    {
  
      CachHelper.saveData(key: 'token', value: state.loginModel!.data!.token).then((value) 
      {
        token= state.loginModel!.data!.token;
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomeLayout()));
      }),

    }
    else{

     showToast(msg:state.loginModel!.message ,
     state: ToastState.ERROR),
    }
  }
},
        builder:(context,state){
          return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(),
          body: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                    key: formKey,
                  child: Column(
                  
                   crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('LOGIN',style: TextStyle(fontSize: 30.0,
                      fontWeight: FontWeight.bold),
                        ),
                      Text('login now to brwose our hot offers',style: TextStyle(color: Colors.grey,
                      fontSize: 17.0,),),
            
                      SizedBox(height: 20.0,),

                      defaultFormField(
                        label: 'Email Address', 
                        prefixIcon:Icons.email,
                         controlloer: emailController,
                          validate: ( value){
                          if(value!.isEmpty)
                          return 'email must not be empty';
            
                        },
                        type: TextInputType.emailAddress,
                        ),
                    
             
                      SizedBox(height: 20.0,),
            
             defaultFormField(
                        label: 'Password', 
                        prefixIcon:Icons.lock,
                         controlloer: passwordController,
                          validate: ( value){
                          if(value!.isEmpty)
                          return 'password must not be empty';
            
                        },
                        isPassword:LoginCubit.get(context).isPassword ,
                        suffixIcon:LoginCubit.get(context).suffixIcon,
                        suffixPressed: (){
  LoginCubit.get(context).ChangePasswordVisibility();
                        },
                       
                        onSubmit: (value){
   if(formKey.currentState!.validate())
                    {
   LoginCubit.get(context).UserLogin(email: emailController.text, password: passwordController.text);
                    }
                        },
                        type: TextInputType.emailAddress,
                        ),


            
          
              SizedBox(height: 20.0,),
            
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
            Center(
              child: ConditionalBuilder(
              condition: state is! LoginLoadingStates,
              builder: (context)=> MaterialButton(onPressed: (){
                    if(formKey.currentState!.validate())
                    {
   LoginCubit.get(context).UserLogin(email: emailController.text, password: passwordController.text);
                    }
                 
                  },
                   elevation: 10.0,
                  
                    child: Text('Login',style: TextStyle(fontSize: 20.0),),
                  
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                    
                    color:defaultColor,
                    textColor: Colors.white,
                    ),
              fallback:(context)=>const CircularProgressIndicator(color: Color.fromARGB(255, 226, 84, 79)),
              ),
            ),
            
              ],
                  
            ),
            SizedBox(height: 20.0,),
            
             Row(
            mainAxisAlignment: MainAxisAlignment.center,
               children: [
                   Text('don\'t have an account?',style: TextStyle(fontSize: 15.0),),
                   SizedBox(width: 10.0,),
                   TextButton(onPressed: (){

                     Navigator.push(context, MaterialPageRoute(builder: (context)=>RegisterScreen()));
                   }, child: Text('Register',style: TextStyle(color:defaultColor ),)),
            
                  
               ],
             ),
            
                      
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
        } ,
      ),
    );
    
  }
}