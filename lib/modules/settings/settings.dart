import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_shop_app/components.dart';
import 'package:my_shop_app/constants.dart';
import 'package:my_shop_app/cubit/cubit.dart';
import 'package:my_shop_app/cubit/states.dart';
import 'package:my_shop_app/models/login_model.dart';
import 'package:my_shop_app/style/colors.dart';

var emailController = TextEditingController();
   var PhOneController = TextEditingController();
    var NameController = TextEditingController();
var formKey = GlobalKey<FormState>();
class SettingsScreen extends StatelessWidget {
  

  const SettingsScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener:(context,state)=>{

      },
      builder:(context,state){
        var model =ShopCubit.Get(context).userDataModel;

       
        PhOneController.text=model!.data!.phone!;
        emailController.text=model.data!.email!;
        NameController.text=model.data!.name!;
      
        return Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
               if(state is LoadingUpdateState)
LinearProgressIndicator(color: defaultColor,
backgroundColor: Color.fromARGB(255, 235, 144, 24)),
SizedBox(height: 10.0,),
   defaultFormField
                (
                  label: 'Name', 
                  prefixIcon: Icons.person,
                   controlloer: NameController,
                    validate: ( value){
                                  if(value!.isEmpty)
                                  return 'name must not be empty';
                    
                                },
                    type: TextInputType.name,
                    ),
SizedBox(height: 20.0,),
                defaultFormField
                (
                  label: 'Email Address', 
                  prefixIcon: Icons.email,
                   controlloer: emailController,
                    validate: ( value){
                                  if(value!.isEmpty)
                                  return 'email must not be empty';
                    
                                },
                    type: TextInputType.emailAddress,
                    ),

             SizedBox(height: 20.0,),
                defaultFormField
                (
                  label: 'Phone', 
                  prefixIcon: Icons.phone,
                   controlloer: PhOneController,
                    validate: ( value){
                                  if(value!.isEmpty)
                                  return 'phone must not be empty';
                    
                                },
                    type: TextInputType.phone,
                    ),
      SizedBox(height: 20.0,),

      Row(
            children: [
            Expanded(
                child: MaterialButton(
                  onPressed:(){
                    if(formKey.currentState!.validate())
                    {
     ShopCubit.Get(context).UpdateUserDataModel(
                  name: NameController.text,
                   email: emailController.text,
                    phone: PhOneController.text);
                    }
         
                  } ,
                  color: defaultColor,
                  shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0)) ,
                  child: Text('UPDATE',style: TextStyle(color: Colors.white),),
                  
                  ),
              ),
              SizedBox(width: 10.0,),
                 Expanded(
                   child: MaterialButton(
                onPressed:(){
                    SignOut(context);
                } ,
                color: defaultColor,
                shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0)) ,
                child: Text('LOGOUT',style: TextStyle(color: Colors.white),),
                
                ),
                 ),
            ],
      )
               


              ],
            ),
          ),
        ),
      );
      } ,
    
    );
  }
}