import 'package:flutter/material.dart';
import 'package:state_login/apiprovider/user_api.dart';
import 'package:state_login/models/selftask.dart';

class AddNewSelfTask extends StatefulWidget {
  final id;

  const AddNewSelfTask({Key key, this.id}) : super(key: key);
  @override
  _AddNewSelfTaskState createState() => _AddNewSelfTaskState();
}

class _AddNewSelfTaskState extends State<AddNewSelfTask> {
  
  Selftask st = Selftask();
  var date = DateTime.now();
  final fkey = GlobalKey<FormState>();
  var selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    st.id = widget.id;
    st.status = '0';
    print(st.id);
  }

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime.now(),
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
          // return ;
        },
        child: Form(
          key: fkey,
          child: Scaffold(
            appBar: AppBar(
              elevation: 0.0,
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.black,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              title: Text(
                'New Task',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              actions: [
                IconButton(
                  icon: Icon(
                    Icons.outlined_flag,
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
                      print(st.id);
                      if (await assignSelfTask(st) == 'selftask added') {
                        print('added');
                        setState(() {
                          print('added');
                        });
                      } else {
                        print('cant add task');
                      }
                      Navigator.pop(context);
                    }
                  },
                )
              ],
            ),
            body: ListView(
              children: [
                Container(
                  margin: EdgeInsets.only(left: 15.0, right: 15.0, top: 5.0),
                  child: TextFormField(
                    style:
                        TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Title',
                      hintStyle: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 30.0),
                    ),
                    onChanged: (String val) => st.title = val,
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
                            st.date = selectedDate.toString();
                          });
                        }
                      },
                      child: Row(
                        children: <Widget>[
                          Text(
                            '$selectedDate',
                            style: TextStyle(fontSize: 20.0),
                          ),
                          Icon(Icons.date_range)
                        ],
                      ),
                    )),
                Container(
                  margin: EdgeInsets.only(left: 15.0, right: 15.0, top: 5.0),
                  child: TextFormField(
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    decoration: InputDecoration(
                        hintText: 'Description',
                        hintStyle: TextStyle(
                          fontSize: 20.0,
                        ),
                        border: InputBorder.none),
                    onChanged: (String val) => st.desc = val,
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
