import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_shop_app/cubit/cubit.dart';
import 'package:my_shop_app/cubit/states.dart';
import 'package:my_shop_app/models/categories_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CategoriesScreen extends StatelessWidget {
  const  CategoriesScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
     listener: (context,state)=>{},
     builder: (context,state){
       return ListView.separated(
        physics: BouncingScrollPhysics(),
        itemBuilder: (context,index)=>buildCatList( ShopCubit.Get(context).categoriesModel!.data!.data[index] ),
         separatorBuilder: (context,index)=>Container(color: Colors.grey[300],
         height: 1,width: double.infinity),
          itemCount:ShopCubit.Get(context).categoriesModel!.data!.data.length,
          );
     },
    );
  }

  Widget buildCatList(DataModel model )=>Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(children: [

        Image(image: NetworkImage('${model.image}'),
         height: 120.0,
         width: 120.0,
        ),
        SizedBox(width: 20.0,),
        Text('${model.name}',
        style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),),
        Spacer(),
        Icon(Icons.arrow_forward_ios),
        

      ],),
    );
}