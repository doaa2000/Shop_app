class CategoriesModel
{
bool ?status;
CateoriesDataModel ?data;

CategoriesModel.fromJson(Map<String,dynamic>json){
status=json['status'];
data= CateoriesDataModel.fromJson(json['data']);
}
}

class CateoriesDataModel
{
int ?currentPage;
List<DataModel> data=[];

CateoriesDataModel.fromJson(Map<String,dynamic>json){
currentPage=json['current_page'];
json['data'].forEach((element){
  data.add(DataModel.fromJson(element));
});

}

}
class DataModel
{
  int ?id;
  String ?name;
  String ?image;
  DataModel.fromJson(Map<String,dynamic>json){
    id=json['id'];
name= json['name'];
image=json['image'];

  }
}