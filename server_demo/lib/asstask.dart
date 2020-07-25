import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'main.dart';

class Asstask extends StatefulWidget {
  @override
  _AsstaskState createState() => _AsstaskState();
}

class _AsstaskState extends State<Asstask> {
  
  TextEditingController t1=TextEditingController();
  TextEditingController t2=TextEditingController();
  TextEditingController t3=TextEditingController();  
  TextEditingController t4=TextEditingController();

  Future<void> addt()async
  {
  int i=int.parse(t4.text);
    var map={
      "id":1,
      "title":"${t1.text}",
      "desc":"${t2.text}",
      "date":"${t3.text}",
      "tid":i,
      "status":0
    };
    var response=await http.put('http://10.0.2.2:8000/users/1/assigntask/$i',body:json.encode(map),headers: {"Content-Type":"application/json"});
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
          TextField(
            autocorrect: true,
            controller: t4,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: 'enter employee id'
            ),
          ),
          Center(
            child: RaisedButton(
              child: Text('add'),
              onPressed: (){
              addt();
            }),
          )
        ],
      ),
    );
  }
}