import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_shop_app/components.dart';
import 'package:my_shop_app/cubit/cubit.dart';
import 'package:my_shop_app/cubit/states.dart';
import 'package:my_shop_app/models/search_model.dart';
import 'package:my_shop_app/modules/search/cubit.dart';
import 'package:my_shop_app/modules/search/states.dart';
import 'package:my_shop_app/style/colors.dart';

var searchController = TextEditingController();
var formKey = GlobalKey<FormState>();
class SearchScreen extends StatelessWidget {
  const SearchScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return BlocProvider(
      create: (BuildContext context) =>SearchCubit(),
  child: BlocConsumer<SearchCubit,SearchStates>(
    listener:(contxet,state)=>{} ,
    builder:((context, state) {
      return Scaffold(
        backgroundColor: Colors.white,
    appBar: AppBar(
      foregroundColor: Colors.black,
     
    ),
    body:Padding(
      padding: const EdgeInsets.all(20.0),
      child: Center(
        child:   Form(
          key: formKey,
          child: Column(
          children: [
          defaultFormField(
            label: 'Search',
             prefixIcon: Icons.search,
              controlloer: searchController, 
              onSubmit: (String text){
               SearchCubit.get(context).Search(text);
              },
              validate: ( value){
                if(formKey.currentState!.validate()){
                  return 'Enter text to search';
                }
              }, 
              type: TextInputType.text
              ),
SizedBox(height: 10.0,),
if(state is SearchLoadingStates)
LinearProgressIndicator(backgroundColor: defaultColor,color: Color.fromARGB(255, 253, 144, 42),),
SizedBox(height: 20.0,),
if(state is SearchSuccessStates)
Expanded(
  child:   ListView.separated(
            physics: BouncingScrollPhysics(),
            itemBuilder: (context,index)=> buildSearchList(SearchCubit.get(context).search_model!.data!.data![index] , context ),
             separatorBuilder: (context,index)=>Container(color: Colors.grey[300],
             height: 1,width: double.infinity),
              itemCount:SearchCubit.get(context).search_model!.data!.data!.length,
              ),
),
          ],
          ),
        ),
      ),
    ) ,
      );
    }

  ),
    ));
  } 
}

Widget buildSearchList(Product model,context)=>Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        height:120.0,
        child: Row(
   
children: [
        Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
            Image(image: NetworkImage('${model.image}'),
           width: 120.0,
          fit: BoxFit.cover,
           height: 120.0,
          ),
          
          ],
        ),
SizedBox(width: 10.0,),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${model.name}',
                maxLines: 2,
overflow: TextOverflow.ellipsis,
              ),

              Spacer(),
              Row(
 
           children: [
             Text(
                '${model.price.toString()}',
                maxLines: 2,
overflow: TextOverflow.ellipsis,
style: TextStyle(fontSize: 12.0,color: defaultColor),
              ),
              SizedBox(width: 5.0,),
            
      Spacer(),
      CircleAvatar(
          radius: 17,
          backgroundColor:  ShopCubit.Get(context).favorites[model.id]!?  defaultColor:Colors.grey ,
          child: IconButton(
            onPressed: (){
              ShopCubit.Get(context).ChangeFavorite(model.id!);
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
