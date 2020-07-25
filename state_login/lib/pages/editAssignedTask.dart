import 'package:flutter/material.dart';
import 'package:state_login/contacts.dart';
import 'package:state_login/models/assignedBymemodel.dart';
import 'package:state_login/models/contactdetail.dart';
import 'package:state_login/apiprovider/user_api.dart';

class EditAssignedTask extends StatefulWidget {
  final AssignedByMeModel abm;
  final employeeName;

  const EditAssignedTask({Key key, this.abm, this.employeeName})
      : super(key: key);
  @override
  _EditAssignedTaskState createState() => _EditAssignedTaskState();
}

class _EditAssignedTaskState extends State<EditAssignedTask> {
  var fkey = GlobalKey<FormState>();
  var selectedDate = DateTime.now();
  var selectedContact;
  String oldTitle;
  String oldTid;
  String oldDate;

  @override
  void initState(){
    super.initState();
    oldTitle=widget.abm.title;
    oldDate=widget.abm.date;
    oldTid=widget.abm.tid;
  }

  Future<Null> selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.pop(context);
      },
      child: Form(
        key: fkey,
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.black,
                ),
                onPressed: () {
                  Navigator.pop(context);
                }),
            title: Text(
              'Edit Task',
              style: TextStyle(color: Colors.black),
            ),
            elevation: 0.0,
            actions: [
              IconButton(
                icon: Icon(
                  Icons.flag,
                  color: Colors.black,
                ),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(
                  Icons.check,
                  color: Colors.black,
                ),
                onPressed: ()async {
                  if(await updateAssignedTaskToOther(oldTitle,oldDate,oldTid,widget.abm.id,widget.abm))
                  {
                    // Scaffold.of(context).showSnackBar(SnackBar(content: Text('Task Updated Successfully!!'),duration: Duration(seconds: 1),));
                    Navigator.pop(context);
                  }
                },
              ),
            ],
          ),
          body: ListView(
            children: [
              Container(
                margin: EdgeInsets.only(left: 15.0, right: 15.0, top: 5.0),
                child: TextFormField(
                  initialValue: widget.abm.title,
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
                  decoration: InputDecoration(
                      hintText: 'Title',
                      hintStyle: TextStyle(
                          fontSize: 30.0, fontWeight: FontWeight.bold),
                      border: InputBorder.none),
                  onChanged: (String val) => widget.abm.title = val,
                ),
              ),
              Container(
                  margin: EdgeInsets.only(left: 15.0, right: 15.0, top: 5.0),
                  child: InkWell(
                    onTap: () async {
                      final DateTime picked = await showDatePicker(
                          context: context,
                          initialDate: selectedDate,
                          firstDate: DateTime(2015, 8),
                          lastDate: DateTime(2101));
                      if (picked != null && picked != selectedDate) {
                        setState(() {
                          selectedDate = picked;
                          widget.abm.date = selectedDate.toString();
                        });
                      }
                    },
                    child: Row(
                      children: <Widget>[
                        Text(
                          widget.abm.date,
                          style: TextStyle(fontSize: 20.0),
                        ),
                        Icon(Icons.date_range)
                      ],
                    ),
                  )),
              Container(
                margin: EdgeInsets.only(left: 15.0, right: 15.0, top: 15.0),
                width: MediaQuery.of(context).size.width,
                height: 40.0,
                child: FutureBuilder<List<ContactDetail>>(
                  future: refreshContacts(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting)
                      return Center(child: CircularProgressIndicator());
                    else if (snapshot.hasData) {
                      return DropdownButton<String>(
                        hint: Text(widget.employeeName),
                        value: selectedContact,
                        underline: Container(),
                        onChanged: (value) {
                          setState(() {
                            selectedContact = value;
                            widget.abm.tid = selectedContact;
                            print("at.tid: ${widget.abm.tid}");
                            print(selectedContact);
                          });
                        },
                        items: snapshot.data.map((e) {
                          print("snapshot.data.length ${snapshot.data.length}");
                          return DropdownMenuItem<String>(
                            child: Text(e.name),
                            value: e.id,
                          );
                        }).toList(),
                      );
                    } else {
                      return Container();
                    }
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 15.0, right: 15.0),
                child: TextFormField(
                  initialValue: widget.abm.desc,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  decoration: InputDecoration(
                      hintText: 'Description',
                      border: InputBorder.none,
                      hintStyle: TextStyle(fontSize: 20.0)),
                  onChanged: (String val) => widget.abm.desc = val,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
