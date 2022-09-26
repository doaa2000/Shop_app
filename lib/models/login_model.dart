class ShopLoginModel{

  bool ?status;
String ?message;

UserData ?data;

ShopLoginModel.fromJson(Map<String , dynamic>json){
status=json['status'];
message=json['message'];
data=json['data']!=null?UserData.fromJson(json['data']):null;


  }
}

class UserData{
  int ?id;
  String ?name;
  String ?email;
  String ?phone;
  int ?points;
  int ?credit;
  String ?token;


  UserData({
    this.email,
    this.name,
    this.phone,
    this.points,
    this.id,
    this.credit,
    this.token,
  });

  UserData.fromJson(Map<String , dynamic>json){
id=json['id'];
name=json['name'];
email=json['email'];
phone=json['phone'];
credit=json['credit'];
token=json['token'];
points=json['points'];

  }
}