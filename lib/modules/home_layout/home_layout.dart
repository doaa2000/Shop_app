// ignore_for_file: prefer_const_constructors

import 'package:circle_bottom_navigation_bar/circle_bottom_navigation_bar.dart';
import 'package:circle_bottom_navigation_bar/widgets/tab_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:my_shop_app/components.dart';
import 'package:my_shop_app/cubit/cubit.dart';
import 'package:my_shop_app/cubit/states.dart';
import 'package:my_shop_app/modules/search/search.dart';


class HomeLayout extends StatelessWidget {
  const HomeLayout({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) 
  {
    var cubit=ShopCubit.Get(context);
    return BlocConsumer<ShopCubit,ShopStates>(

    listener: (context,state)=>{},
    builder: (context,state){
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('Salla',),
        actions: [
          IconButton(onPressed: (){
            NavigateTo(context, SearchScreen());
          }, icon: Icon(Icons.search,color: Colors.black,)),
        ],
        ),
        body:cubit.Screens[cubit.CurrentIndex],
        bottomNavigationBar:  BottomNavigationBar(
          currentIndex: cubit.CurrentIndex,
          onTap: (int index)
          {
cubit.ChangeBottomNavBar(index);
          },
             unselectedItemColor: Colors.grey,
             showUnselectedLabels: true,
             selectedItemColor:Color.fromARGB(255, 226, 84, 79) ,
          // ignore: prefer_const_literals_to_create_immutables
          items: 
          [

            BottomNavigationBarItem(icon: Icon(Icons.home),
             label:'Home',
            ),
              BottomNavigationBarItem(icon: Icon(Icons.category),
              label: 'Categories',
          
            ),
             BottomNavigationBarItem(icon: Icon(Icons.favorite),
              label: 'Favorites',
          
            ),
            BottomNavigationBarItem(icon: Icon(Icons.settings),
              label: 'Settings',
          
            ),
          ],
        ),
        

      );
    },
    );
  }
}