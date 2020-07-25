import 'package:http/http.dart' as http;
import 'dart:convert';


class TaskAPIProvider{

  String baseurl="http://10.0.2.2:8000/";
  final successcode=200;
  
  Future<List<dynamic>> getselfData(int id)async
  {
    var tasks=[];
    print('in selfdata');
    var response=await http.get(baseurl+'users/$id/selftasks');
    print('data fetchewd');
    if(response.statusCode==200)
    {
      tasks=(json.decode(response.body));
      return tasks;
    }
    else{
      throw Exception('cant fetch data');
    }
  }

  Future<List<dynamic>> getAsstasks(int id)async{

    var task=[];
    var response=await http.get(baseurl+'users/$id/asstasks');
    if(response.statusCode==200)
    {
      task=json.decode(response.body);
      return task;
    }
    else{
      throw Exception('cant fetch data');
    }
  }
}