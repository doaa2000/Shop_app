import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_shop_app/cubit/cubit.dart';
import 'package:my_shop_app/cubit/states.dart';
import 'package:my_shop_app/models/favorite_model.dart';
import 'package:my_shop_app/style/colors.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
     listener: (context,state)=>{},
     builder: (context,state){
       return ConditionalBuilder(
        condition: state is! LoadingFavoriteState,
        builder: (context)=> ListView.separated(
          physics: BouncingScrollPhysics(),
          itemBuilder: (context,index)=> buildFavoriteList(ShopCubit.Get(context).favoriteModel!.data!.data![index] , context ),
           separatorBuilder: (context,index)=>Container(color: Colors.grey[300],
           height: 1,width: double.infinity),
            itemCount:ShopCubit.Get(context).favoriteModel!.data!.data!.length,
            ),
            fallback: (context)=>Center(child: CircularProgressIndicator(backgroundColor: defaultColor)),

       );
     },
    );
  }
  }

  Widget buildFavoriteList(FavoritesData model,context)=>Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        height:120.0,
        child: Row(
   
children: [
        Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
            Image(image: NetworkImage('${model.product!.image}'),
           width: 120.0,
          fit: BoxFit.cover,
           height: 120.0,
          ),
           if(model.product!.discount!=0)
          Container(
            padding: EdgeInsets.symmetric(horizontal: 5.0),
            color: Colors.red,
          
            child:
            
             Text('DISCOUNT',style: TextStyle(fontSize: 10.0,color: Colors.white),),
          ),
          ],
        ),
SizedBox(width: 10.0,),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${model.product!.name}',
                maxLines: 2,
overflow: TextOverflow.ellipsis,
              ),

              Spacer(),
              Row(
 
           children: [
             Text(
                '${model.product!.price.toString()}',
                maxLines: 2,
overflow: TextOverflow.ellipsis,
style: TextStyle(fontSize: 12.0,color: defaultColor),
              ),
              SizedBox(width: 5.0,),
              if(model.product!.discount!=0)
              Text(
            '${model.product!.oldPrice.toString()}',
            maxLines: 2,
overflow: TextOverflow.ellipsis,

style: TextStyle(fontSize: 10.0,color: Colors.grey,decoration: TextDecoration.lineThrough),
          ),
      Spacer(),
      CircleAvatar(
          radius: 17,
          backgroundColor:  ShopCubit.Get(context).favorites[model.product!.id]!?  defaultColor:Colors.grey ,
          child: IconButton(
            onPressed: (){
              ShopCubit.Get(context).ChangeFavorite(model.product!.id!);
            }, 
            icon: Icon(Icons.favorite_border,size: 16.0,color: Colors.white,))),
           ],
 ),
            ],
          ),
        ),
  
 
],
        ),
      ),
    );
