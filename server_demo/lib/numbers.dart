import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
List<dynamic> num=[];
Future<List<dynamic>> getnumbers()async
{
  num=[];
    var response=await http.get('http://10.0.2.2:8000/numbers');
    if(response.statusCode==200)
    {
      num=(json.decode(response.body));
      // print(users);
      return num;
    }
    else{
      print('cant fetch data');
    }
}
class Numbers extends StatefulWidget {
  @override
  _NumbersState createState() => _NumbersState();
}

class _NumbersState extends State<Numbers> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Numbers'),
      ),
      body: FutureBuilder(
            future: getnumbers(),
            builder: (context,snapshot){
              if(snapshot.connectionState==ConnectionState.waiting)
              {
                return Center(child: CircularProgressIndicator(),);
              }
              else
              {
                return ListView.builder(
                  itemCount: num.length,
                  itemBuilder:(_,index){
                    return Column(
                      children: <Widget>[
                        Text('${snapshot.data.elementAt(index)['number']}',style: TextStyle(fontSize: 30.0)),
                      ],
                    );
                  } );
              }
            },
          ),
    );
  }
}