import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:server_demo/main.dart';


class addself extends StatefulWidget {
  @override
  _addselfState createState() => _addselfState();
}

class _addselfState extends State<addself> {
  TextEditingController t1=TextEditingController();
  TextEditingController t2=TextEditingController();
  TextEditingController t3=TextEditingController();

  Future<void> add()async
{
    var map={
      "id":1,
      "title":"${t1.text}",
      "desc":"${t2.text}",
      "date":"${t3.text}",
      "status":0
    };
    var response=await http.put('http://10.0.2.2:8000/users/1/assignselftask',body:json.encode(map),headers: {"Content-Type":"application/json"});
    if(response.statusCode==200)
    {
      print(response.body);
      Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage()));
    }
    else{
      print(response.statusCode);
    }
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Numbers'),
      ),
      body: Column(
        children: [
          TextField(
            autocorrect: true,
            controller: t1,
            decoration: InputDecoration(
              hintText: 'enter title'
            ),
          ),
          TextField(
            autocorrect: true,
            controller: t2,
            decoration: InputDecoration(
              hintText: 'enter desc'
            ),
          ),
          TextField(
            autocorrect: true,
            controller: t3,
            keyboardType: TextInputType.datetime,
            decoration: InputDecoration(
              hintText: 'enter date'
            ),
          ),
          Center(
            child: RaisedButton(
              child: Text('add'),
              onPressed: (){
              add();
            }),
          )
        ],
      ),
    );
  }
}