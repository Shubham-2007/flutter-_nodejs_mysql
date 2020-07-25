import 'package:flutter/material.dart';
import 'package:state_login/apiprovider/user_api.dart';
import 'package:state_login/main.dart';
import 'package:state_login/models/selftasklistmodel.dart';

import '../homepage.dart';

class EditSelfTask extends StatefulWidget {
  final SelfTaskListModel stlm;

  const EditSelfTask({Key key, this.stlm}) : super(key: key);
  @override
  _EditSelfTaskState createState() => _EditSelfTaskState();
}

class _EditSelfTaskState extends State<EditSelfTask> {
  var fkey = GlobalKey<FormState>();
  var selectedDate = DateTime.now();
  String oldTitle;
  String oldDate;
  String oldDesc;

  @override
  void initState() {
    super.initState();
    oldTitle = widget.stlm.title;
    oldDate = widget.stlm.date;
    oldDesc = widget.stlm.desc;
  }

  Future<Null> _selectDate(BuildContext context) async {
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
                onPressed: () async {
                  if (fkey.currentState.validate()) {
                    if (await updateSelfTask(
                        oldTitle,
                        oldDate,
                        widget.stlm.id,
                        widget.stlm.title,
                        widget.stlm.date,
                        widget.stlm.desc)) {
                      Navigator.pop(context);
                    } else {
                      AlertDialog(
                        title: Text('Cannot edit task!!!'),
                      );
                    }
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
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  initialValue: widget.stlm.title,
                  style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Title',
                    hintStyle:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 30.0),
                  ),
                  onChanged: (String val) => widget.stlm.title = val,
                ),
              ),
              Container(
                  margin: EdgeInsets.only(left: 15.0, right: 15.0, top: 10.0),
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
                          widget.stlm.date = selectedDate.toString();
                        });
                      }
                    },
                    child: Row(
                      children: <Widget>[
                        Text(
                          widget.stlm.date,
                          style: TextStyle(fontSize: 20.0),
                        ),
                        Icon(Icons.date_range)
                      ],
                    ),
                  )),
              Container(
                margin: EdgeInsets.only(left: 15.0, right: 15.0, top: 5.0),
                child: TextFormField(
                  initialValue: oldDesc,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  style: TextStyle(fontSize: 20.0),
                  decoration: InputDecoration(
                      hintText: 'Description',
                      hintStyle: TextStyle(
                        fontSize: 20.0,
                      ),
                      border: InputBorder.none),
                  onChanged: (String val) => widget.stlm.desc = val,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
