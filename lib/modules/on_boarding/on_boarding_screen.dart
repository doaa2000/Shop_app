import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_shop_app/modules/login_screen.dart';
import 'package:my_shop_app/shared/network/local/cache_helper.dart';

import 'package:smooth_page_indicator/smooth_page_indicator.dart';


class onBoardingModel{
  late String image;
  late String title;
  late String board;

onBoardingModel({
required this.image,
required this.board,
required this.title,
});
}
var pageController=PageController();
    bool isLast=false;
class OnBoardingScreen extends StatefulWidget {
 
  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
late List<onBoardingModel> boarding=[
  onBoardingModel(image: 'assets/boarding1.png', board: '', title: 'Welcome to shop app :)'),
  onBoardingModel(image: 'assets/boarding2.png', board: '', title: 'Explore many products'),
  onBoardingModel(image: 'assets/boarding3.png', board: '', title: 'Easy shopping'),

];

void submit(){
CachHelper.saveData(key: 'onBoarding', value: true).then((value) {
  if(value)
  {
Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
  }
});

}
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor:  Colors.white,
      appBar: AppBar(
        actions: [
          TextButton(onPressed: (){
           submit();
          }, child: Text('SKIP',style: TextStyle(color: Color.fromARGB(255, 226, 84, 79)),)),
        ],
      ),
      // ignore: prefer_const_literals_to_create_immutables
      body:Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: [

          Expanded(
            child: PageView.builder(itemBuilder:((context, index) => buildBoardingItem(boarding[index])),
            itemCount:boarding.length,
            controller: pageController,
            onPageChanged: (int index){
if(index==boarding.length-1)
{
  setState(() {
    
    isLast=true;
  });
}
else{
 setState(() {
    
    isLast=false;
  });

}
            },
                  
            
            ),
          ),
          SizedBox(height: 10.0,),
          Row(children: [
            SmoothPageIndicator(controller: pageController, 
            count: boarding.length,
            effect: SlideEffect(
              activeDotColor: Color.fromARGB(255, 226, 84, 79),
              dotColor: Colors.grey,
              dotHeight: 10,
              dotWidth: 25,
              spacing: 6,
             
            ),
            ),
            Spacer(),
            FloatingActionButton(
              
              backgroundColor: Color.fromARGB(255, 226, 84, 79),
              onPressed: (){
                if(isLast)
                {

                  submit();
                }
                else
                {
 pageController.nextPage(duration: Duration(
                 milliseconds: 750,
               ), curve: Curves.fastLinearToSlowEaseIn,);
              
                }
              
              },
            child:Icon(Icons.arrow_forward_ios))
          ],),
        ],),
      )
    );
  }
}

Widget buildBoardingItem(onBoardingModel model )=>Column(
        crossAxisAlignment: CrossAxisAlignment.start,
      
        children: [
         Expanded(child: Image(image: AssetImage('${model.image}'))),
        const SizedBox(height: 3.0,),
        Text('${model.title}',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 25.0),),
           const SizedBox(height: 10.0,),
  Text('${model.board}',style: TextStyle(fontSize: 15.0),),
      ]);