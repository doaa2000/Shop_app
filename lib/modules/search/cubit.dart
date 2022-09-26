import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_shop_app/constants.dart';
import 'package:my_shop_app/end_point.dart';
import 'package:my_shop_app/models/search_model.dart';
import 'package:my_shop_app/modules/search/states.dart';
import 'package:my_shop_app/remote/local/dio.dart';

class SearchCubit extends Cubit<SearchStates>{
  SearchCubit() : super(SearchInitialStates());

  static SearchCubit get(context)=>BlocProvider.of(context);


  SearchModel ?search_model;

void Search(String text){
emit(SearchLoadingStates());
  DioHelper.Postdata(
    url: SEARCH,
    token: token,
     data: {
      'text':text
     }).then((value) {
search_model = SearchModel.fromJson(value.data);

      emit(SearchSuccessStates());
     }).catchError((error){
      emit(SearchErrorStates());
     });
}


}