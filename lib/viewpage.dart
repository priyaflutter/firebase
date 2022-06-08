import 'package:firebase/database.dart';
import 'package:firebase/updatepage.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as developer;

class view extends StatefulWidget {
  @override
  State<view> createState() => _viewState();
}

class _viewState extends State<view> {
  bool status = false;
  List list = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dataview();
  }

  Future<void> dataview() async {
    DatabaseReference ref = FirebaseDatabase.instance.ref("My Realtime");
    DatabaseEvent de = await ref.once();

    // developer.log('Response body: ${de!.snapshot.value}');
    print("=====${de.snapshot.value}");
    Map map = de.snapshot.value as Map;
    map.forEach((key, value) {
      setState(() {
        list.add(value);
        status = true;
      });
    });
    developer.log("222=============${list}");
  }

  @override
  Widget build(BuildContext context) {
    double theight = MediaQuery.of(context).size.height;
    double twidth = MediaQuery.of(context).size.width;
    double statusbarheight = MediaQuery.of(context).padding.top;
    double tnaviheight = MediaQuery.of(context).padding.bottom;
    double tappbar = kToolbarHeight;

    double bodyheight = theight - statusbarheight - tappbar - tnaviheight;

    return status
        ? Scaffold(
        appBar: AppBar(
          title: Text("Data View"),
        ),
        body: RefreshIndicator(onRefresh: () async {
        await  Future.delayed(Duration(seconds: 2)).then((value) {

                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                     return view();
                },));
          });
        },
          child: WillPopScope(onWillPop: onback,
            child: ListView.builder(
              itemCount: list.length,
              itemBuilder: (context, index) {
                return Container(
                  height: bodyheight * 0.20,
                  width: double.infinity,
                  margin: EdgeInsets.all(bodyheight*0.01),
                  decoration: BoxDecoration(
                    border: Border.all(width: 1),
                    borderRadius: BorderRadius.all(Radius.circular(bodyheight*0.02))
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                        width: twidth * 0.02,
                      ),
                      Card(
                        child: Container(
                          height: bodyheight * 0.12,
                          width: twidth * 0.22,
                          decoration: BoxDecoration(
                            // color: Colors.yellow,
                              image: DecorationImage(
                                  image: NetworkImage(
                                      "${list[index]['imagepath']}"),
                                  fit: BoxFit.cover)),
                        ),
                      ),
                      Expanded(
                        child: Container(
                            margin: EdgeInsets.fromLTRB(
                                bodyheight * 0.02,
                                bodyheight * 0.05,
                                bodyheight * 0.02,
                                bodyheight * 0.02),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "Id : ",
                                      style: TextStyle(
                                          fontSize: bodyheight * 0.02,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Expanded(
                                      child: Text(
                                        "${list[index]['id']}",
                                        style: TextStyle(
                                            fontSize: bodyheight * 0.02,
                                            color: Colors.black45,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "Name : ",
                                      style: TextStyle(
                                          fontSize: bodyheight * 0.02,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      "${list[index]['name']}",
                                      style: TextStyle(
                                          fontSize: bodyheight * 0.02,
                                          color: Colors.black45,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "Mobile : ",
                                      style: TextStyle(
                                          fontSize: bodyheight * 0.02,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      "${list[index]['Mobile']}",
                                      style: TextStyle(
                                          fontSize: bodyheight * 0.02,
                                          color: Colors.black45,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ],
                            )),
                      ),
                      PopupMenuButton(onSelected: (value) {
                        if (value == 1) {
                          Navigator.pushReplacement(
                              context, MaterialPageRoute(builder: (context) {
                            return update1(list, index);
                          },));
                        }

                      },
                        itemBuilder: (context) {
                          return [
                            PopupMenuItem(value: 1, child: Text("Update")),
                            PopupMenuItem(onTap: () {
                              Navigator.pop(context);
                              setState(() async {
                              await  FirebaseDatabase.instance.ref("My Realtime").child(list[index]['id']).remove();
                              });
                            }, child: Text("Delete"))
                          ];
                        },
                      )
                    ],
                  ),
                );
              },
            ),
          ),
        ))
        : Center(child: CircularProgressIndicator());
  }

  Future<bool> onback() {

    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
          return firstdata();
    },));

    return Future.value(true);
  }
}
