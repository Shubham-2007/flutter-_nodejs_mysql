import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:server_demo/bloc/TaskListState.dart';
import 'package:server_demo/bloc/listingBloc.dart';
import 'package:server_demo/numbers.dart';
import 'package:server_demo/repository.dart';
import 'package:server_demo/selftask.dart';

// List<dynamic> tasks; 

// Future<List<dynamic>> getData()async
// {
//     tasks=[];
//     var response=await http.get('http://10.0.2.2:8000/users/1/selftasks');
//     if(response.statusCode==200)
//     {
//       tasks=(json.decode(response.body));
//       return tasks;
//     }
//     else{
//       print('cant fetch data');
//     }
// }

void main(){
  runApp(MaterialApp(
    home: HomePage(),
  ));
}

class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        Container(margin:EdgeInsets.all(10.0),child: FloatingActionButton(onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>Numbers()));
        },child: Icon(Icons.phone),)),
        Container(
          color: Colors.blue,
          child: IconButton(
            onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>addself()));
          },icon: Icon(Icons.add),),
        ),
        Container(
          color: Colors.blue,
          margin:EdgeInsets.all(10.0),child: IconButton(onPressed: (){
          // bl.dispatch();
        },icon: Icon(Icons.send),))
      ],),
      appBar: AppBar(
        leading: Container(),
        title: Text('Self Tasks'),
      ),
          body: BlocProvider(            
            create: (context) => TaskListingBloc(TaskRepo()),
            child: displayPage(),
          ),
    );
  }
}

class displayPage extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    final bl=BlocProvider.of<TaskListingBloc>(context);
    return BlocBuilder<TaskListingBloc,ListingState>(
      // bloc:BlocProvider.of<TaskListingBloc>(context),
      builder: (context,state){
        if(state is ListEmptyState){
          return Center(child: Text('empty set'),);
        }
        else if(state is ListErrorState){
          return Center(child: Text('error set'),);
        }
        else if(state is ListFetchingState){
          return Center(child: CircularProgressIndicator(),);
        }
        else{
          final stateasdatafetched= state as ListFectchedState;
          final tasks=stateasdatafetched.tasks;
          return buildList(tasks);
        }
      }
    );
  }
}

Widget buildList(List<dynamic> tasks){
  return ListView.builder(
            itemCount: tasks.length,
            itemBuilder:(_,index){
              return ListTile( 
                title: Text('${tasks.elementAt(index)['title']}',style: TextStyle(fontSize: 20.0),),
                subtitle: Text('${tasks.elementAt(index)['desc']} Dealine: ${tasks.elementAt(index)['date']}',style: TextStyle(fontSize: 15.0),),
            );
        } );
}

// FutureBuilder(
//             future: getData(),
//             builder: (context,snapshot){
//               if(snapshot.connectionState==ConnectionState.waiting)
//               {
//                 return Center(child: CircularProgressIndicator(),);
//               }
//               else
//               {
//                 return ListView.builder(
//                   itemCount: tasks.length,
//                   itemBuilder:(_,index){
//                     return ListTile( 
//                       title: Text('${snapshot.data.elementAt(index)['title']}',style: TextStyle(fontSize: 20.0),),
//                       subtitle: Text('${snapshot.data.elementAt(index)['desc']} Dealine: ${snapshot.data.elementAt(index)['date']}',style: TextStyle(fontSize: 15.0),),
//                     );
//                   } );
//               }
//             },
//           )