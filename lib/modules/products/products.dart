import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_shop_app/cubit/cubit.dart';
import 'package:my_shop_app/cubit/states.dart';
import 'package:my_shop_app/models/categories_model.dart';
import 'package:my_shop_app/models/home_model.dart';
import 'package:my_shop_app/style/colors.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){},
       builder: (context,state){
         return ConditionalBuilder(
           condition: ShopCubit.Get(context).homeModel!=null&&ShopCubit.Get(context).categoriesModel!=null,
           builder:  (context)=>WidgetBuilder(ShopCubit.Get(context).homeModel as HomeModel,ShopCubit.Get(context).categoriesModel as CategoriesModel,context),
           fallback: (context)=>Center(child: CircularProgressIndicator(color:Color.fromARGB(255, 226, 84, 79),)),
         );
       },
    );
  }
  Widget WidgetBuilder(HomeModel model, CategoriesModel categoriesModel,context){
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
   crossAxisAlignment: CrossAxisAlignment.start,
        children: [
// CarouselSlider(
//   items:model.data!.banners.map((e) => Image(
//       image:NetworkImage('${e.image}',
      
//       ),
//        fit: BoxFit.cover,
//        width: double.infinity,
      
//       ), ).toList(), 
  
//   options: CarouselOptions(
//    height: 200.0,
//    initialPage: 0,
//    autoPlay: true,
//    reverse: false,
//    enableInfiniteScroll: true,
//    autoPlayAnimationDuration: Duration(seconds: 1),
//    autoPlayInterval: Duration(seconds: 3),
//    autoPlayCurve: Curves.fastOutSlowIn,
//    scrollDirection: Axis.horizontal,
//    viewportFraction: 1.0,
//   )),
SizedBox(height: 10.0,),
Padding(
  padding: const EdgeInsets.symmetric(horizontal: 10.0),
  child:   Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
          Text('Categories',style: TextStyle(fontSize: 25.0,
      fontWeight: FontWeight.w500),),
      SizedBox(height: 10.0,),
      Container(
        height: 100.0,
        child:   ListView.separated(
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) => buildCategoriesList(categoriesModel.data!.data[index]), 
          separatorBuilder: (context,index)=>SizedBox(width:10.0), 
          itemCount: categoriesModel.data!.data.length,
          
          ),
      ),
      SizedBox(height: 25.0,),
      Text('Products',style: TextStyle(fontSize: 25.0,
      fontWeight: FontWeight.w500),),
    ],
  ),
),
SizedBox(height: 10.0,),
  Container(
    color: Colors.grey[200],
    child: GridView.count(
      crossAxisCount: 2,
      shrinkWrap:true,
      mainAxisSpacing: 1.0,
      crossAxisSpacing: 1.0,
      childAspectRatio: 1/1.7,
      physics: NeverScrollableScrollPhysics(),
    children: List.generate(model.data!.products.length,
     (index) => buildProducts(model.data!.products[index],context),
    ),
    ),
  ),
  ]
      
      ),
    );
  }

  Widget buildProducts(ProductModel model,context)=>Container(
    color: Colors.white,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
children: [
    Stack(
      alignment: AlignmentDirectional.bottomStart,
      children: [
        Image(image: NetworkImage('${model.image}'),
       width: double.infinity,
      
       height: 200.0,
      ),
       if(model.discount!=0)
      Container(
        padding: EdgeInsets.symmetric(horizontal: 5.0),
        color: Colors.red,
      
        child:
        
         Text('DISCOUNT',style: TextStyle(fontSize: 10.0,color: Colors.white),),
      ),
      ],
    ),

    Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${model.name}',
            maxLines: 2,
overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    ),
  
 Padding(
   padding: const EdgeInsets.symmetric(horizontal: 8.0),
   child: Row(
  
       children: [
         Text(
            '${model.price.round()}',
            maxLines: 2,
overflow: TextOverflow.ellipsis,
style: TextStyle(fontSize: 12.0,color: defaultColor),
          ),
          SizedBox(width: 5.0,),
          if(model.discount!=0)
          Text(
        '${model.old_price.round()}',
        maxLines: 2,
overflow: TextOverflow.ellipsis,

style: TextStyle(fontSize: 10.0,color: Colors.grey,decoration: TextDecoration.lineThrough),
      ),
    Spacer(),
    CircleAvatar(
      radius: 17,
      backgroundColor: ShopCubit.Get(context).favorites[model.id]! ? defaultColor:Colors.grey,
      child: IconButton(
        onPressed: (){
          ShopCubit.Get(context).ChangeFavorite(model.id !);
        }, 
        icon: Icon(Icons.favorite_border,size: 16.0,color: Colors.white,))),
       ],
   ),
 ),
],
    ),
  );

  Widget buildCategoriesList(DataModel model)=>Stack(
  alignment: AlignmentDirectional.bottomCenter,
  children: [
 Image(image:
 NetworkImage('${model.image}',
 ),
 height: 100.0,
 width: 100.0,
 ),

 Container(
 
   width: 100.0,
   color: Colors.black.withOpacity(0.6),
   child: Text('${model.name}',style: TextStyle(color: Colors.white,fontSize: 15.0,
   
   
   ),
   textAlign: TextAlign.center,
   maxLines: 1,
   overflow: TextOverflow.ellipsis,
   )),
    
  ],
);
}