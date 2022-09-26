import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_shop_app/components.dart';
import 'package:my_shop_app/constants.dart';
import 'package:my_shop_app/cubit/cubit.dart';
import 'package:my_shop_app/cubit/states.dart';
import 'package:my_shop_app/modules/home_layout/home_layout.dart';


import 'package:my_shop_app/register/cubit/cubit.dart';
import 'package:my_shop_app/register/cubit/states.dart';
import 'package:my_shop_app/shared/network/local/cache_helper.dart';
import 'package:my_shop_app/style/colors.dart';

var emailController = TextEditingController();
   var PhOneController = TextEditingController();
      var PasswordController = TextEditingController();
    var NameController = TextEditingController();
var formKey = GlobalKey<FormState>();
class RegisterScreen extends StatelessWidget {
  const RegisterScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit,RegisterStates>(
        listener: (context, state) => {
          if(state is RegisterSuccessStates){
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
        builder: (context,state){
          return Scaffold(
        backgroundColor: Colors.white
        ,
        appBar: AppBar(
        foregroundColor: Colors.black,
          // leading: IconButton(icon: Icon(Icons.arrow_back_ios),color: Colors.black,
          // onPressed: (){
          //   Navigator.push(context, MaterialPageRoute(builder: ((context) =>RegisterScreen())));
         // },),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Form(
   key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
             
                children: [
                
Text('REGISTER',style: TextStyle(fontSize: 30.0,fontWeight: FontWeight.bold, ),),
SizedBox(height: 20.0,),
                     defaultFormField(
                                label: 'Name', 
                                prefixIcon:Icons.person,
                                 controlloer: NameController,
                                  validate: (  value){
                                  if(value.isEmpty)
                                  return 'Please Enter your name';
                    
                                },
                                type: TextInputType.name,
                                ),
                            
                     
                              SizedBox(height: 20.0,),
                     defaultFormField(
                                label: 'Email Address', 
                                prefixIcon:Icons.email,
                                 controlloer: emailController,
                                  validate: (  value){
                                  if(value.isEmpty)
                                  return 'Please Enter your email';
                    
                                },
                                type: TextInputType.emailAddress,
                                ),
                                 SizedBox(height: 20.0,),
                                   defaultFormField(
                                label: 'Password', 
                                prefixIcon:Icons.lock,
                                 controlloer: PasswordController,
                                  validate: ( value){
                                  if(value.isEmpty)
                                  return 'please enter your password';
                    
                                },
                                isPassword:RegisterCubit.get(context).isPassword ,
                                suffixIcon:RegisterCubit.get(context).suffixIcon,
                                suffixPressed: (){
RegisterCubit.get(context).ChangePasswordVisibility();
                                },
                               
                                onSubmit: (value){
  
                                },
                                type: TextInputType.emailAddress,
                                ),
                                    SizedBox(height: 20.0,),
                     defaultFormField(
                                label: 'Phone', 
                                prefixIcon:Icons.phone,  
                                 controlloer: PhOneController,
                                  validate: (  value){
                                  if(value.isEmpty)
                                  return 'Please Enter your phone';
                    
                                },
                                type: TextInputType.phone,
                                ),
                           SizedBox(height: 20.0,) ,

ConditionalBuilder(
                    condition: state is! RegisterLoadingStates, 
                    builder: (context) =>   Container(
                width: double.infinity,
                child: MaterialButton(onPressed: (){
                  
                   if(formKey.currentState!.validate())
                            {
  RegisterCubit.get(context).UserRegister(
    email: emailController.text,
    password: PasswordController.text,
     name: NameController.text,
     phone: PhOneController.text,

   );
                            }
                },
                color: defaultColor,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0)),
                child: Text('Register', style: TextStyle(color: Colors.white)),
                ),
              ),
                     fallback: (context)=> Center(child: CircularProgressIndicator(color: defaultColor,))),
            
                  
                ],
              ),
            ),
          ),
        ),
        
      );
        },
      ),
    );
  }
}