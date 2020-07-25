import 'package:server_demo/APIprovider.dart';

class TaskRepo{
  TaskAPIProvider tap=TaskAPIProvider();

  Future<List<dynamic>> fetchAssTasks(int id)=> tap.getAsstasks(id);
  Future<List<dynamic>> fetchSelfTask(int id) async { 
    print('inside fetchselfdata');
    return tap.getselfData(id);
  }
}
