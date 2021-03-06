import 'package:flutter/material.dart';
import 'package:state_login/apiprovider/user_api.dart';
import 'package:state_login/pages/editSelfTask.dart';

class SelfTaskList extends StatefulWidget {
  final id;

  const SelfTaskList({this.id});
  @override
  _SelfTaskListState createState() => _SelfTaskListState();
}

class _SelfTaskListState extends State<SelfTaskList> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getselftask(widget.id),
      builder: (context, snapshot) {
        return (snapshot.connectionState == ConnectionState.waiting)
            ? Center(child: CircularProgressIndicator())
            : CustomScrollView(
                    slivers: <Widget>[
                      SliverPersistentHeader(
                          delegate: HeaderDelegate(snapshot.data.length)),
                      SliverList(
                          delegate: SliverChildBuilderDelegate(
                              (BuildContext context, int index) {
                        return (index < snapshot.data.length &&
                                snapshot.data.elementAt(index).status == '0')
                            ? InkWell(
                                onTap: (){
                                  snapshot.data.elementAt(index).id=widget.id.toString();
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>EditSelfTask(stlm: snapshot.data.elementAt(index))));
                                },
                                child: Container(
                                  margin: EdgeInsets.only(
                                      left: 10.0, right: 10.0, top: 10.0),
                                  width: MediaQuery.of(context).size.width - 10.0,
                                  child: Card(
                                    elevation: 7.0,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0)),
                                    color: Colors.white,
                                    child: ListTile(
                                      title: Text(
                                        snapshot.data
                                            .elementAt(index)
                                            .title
                                            .toString()
                                            .toUpperCase(),
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17.0),
                                      ),
                                      subtitle: Padding(
                                        padding: const EdgeInsets.only(top: 8.0),
                                        child: Text(
                                          snapshot.data.elementAt(index).date,
                                          style: TextStyle(
                                              color: Colors.grey, fontSize: 13.0),
                                        ),
                                      ),
                                      trailing: PopupMenuButton(
                                          onSelected: performAction,
                                          itemBuilder: (context) {
                                            return ["Complete", "Delete"]
                                                .map((e) {
                                              return PopupMenuItem(
                                                child: Text(e),
                                                value: [
                                                  widget.id,
                                                  snapshot.data
                                                      .elementAt(index)
                                                      .title,
                                                  snapshot.data
                                                      .elementAt(index)
                                                      .date
                                                ],
                                              );
                                            }).toList();
                                          }),
                                    ),
                                  ),
                                ),
                            )
                            : Container();
                      }, childCount: snapshot.data.length)),
                      SliverToBoxAdapter(
                        child: Container(
                          margin: EdgeInsets.only(top: 8.0),
                          padding:
                              EdgeInsets.only(top: 4.0, bottom: 4.0, left: 7.0),
                          width: MediaQuery.of(context).size.width,
                          color: Colors.grey.shade300,
                          child: Text('Completed Task'),
                        ),
                      ),
                      SliverList(
                          delegate: SliverChildBuilderDelegate(
                              (BuildContext context, int index) {
                        return (index < snapshot.data.length &&
                                snapshot.data.elementAt(index).status == '1')
                            ? Container(
                                margin: EdgeInsets.only(
                                    left: 10.0, right: 10.0, top: 10.0),
                                width: MediaQuery.of(context).size.width - 10.0,
                                child: Card(
                                  elevation: 7.0,
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(10.0)),
                                  color: Colors.white,
                                  child: ListTile(
                                    title: Text(
                                      snapshot.data
                                          .elementAt(index)
                                          .title
                                          .toString()
                                          .toUpperCase(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 17.0),
                                    ),
                                    subtitle: Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: Text(
                                        snapshot.data.elementAt(index).date,
                                        style: TextStyle(
                                            color: Colors.grey, fontSize: 13.0),
                                      ),
                                    ),
                                    trailing: IconButton(
                                      icon: Icon(Icons.delete),
                                      onPressed: () {
                                        deleteTask(
                                            widget.id,
                                            snapshot.data
                                                .elementAt(index)
                                                .title,
                                            snapshot.data
                                                .elementAt(index)
                                                .date);
                                      },
                                    ),
                                  ),
                                ),
                              )
                            : Container();
                      }, childCount: snapshot.data.length)),
                    ],
                  );
      },
    );
  }

  void performAction(List task) async {
    if (await completeSelfTask(
        task.elementAt(0), task.elementAt(1), task.elementAt(2))) {
      // print('complete');
      setState(() {
        print('Task Completed');
      });
    } else {
      setState(() {
        print('task not completed');
      });
    }
  }

  void deleteTask(id, title, date) async {
    if (await deleteSelfTask(id, title, date)) {
      setState(() {
        print('deleted');
      });
    } else {
      setState(() {
        print('not deleted');
      });
    }
  }
}

class HeaderDelegate extends SliverPersistentHeaderDelegate {
  final length;

  HeaderDelegate(this.length);
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return LayoutBuilder(builder: (context, constraints) {
      return Container(
        padding: EdgeInsets.only(left: 30.0, right: 20.0),
        child: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Self Tasks',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25.0,
                      color: Colors.black),
                ),
                IconButton(
                    icon: Icon(Icons.settings_ethernet), onPressed: () {})
              ],
            ),
            RichText(
                text: TextSpan(children: [
              TextSpan(text: 'You have', style: TextStyle(color: Colors.grey)),
              TextSpan(
                  text: ' Self tasks', style: TextStyle(color: Colors.green)),
              TextSpan(text: ' here', style: TextStyle(color: Colors.grey)),
            ]))
          ],
        ),
      );
    });
  }

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate _) => true;

  @override
  double get maxExtent => 80.0;

  @override
  double get minExtent => 0.0;
}
