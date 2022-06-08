import 'dart:io';
import 'dart:math';

import 'package:firebase/viewpage.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

class update1 extends StatefulWidget {
  List<dynamic> list;
  int index;

  update1(this.list, this.index);

  @override
  State<update1> createState() => _update1State();
}

class _update1State extends State<update1> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getmychangevalue();
  }
  void getmychangevalue() {

    setState(() {
      String name1=widget.list[widget.index]['name'];
      name.text=name1;
      String mobile1=widget.list[widget.index]['Mobile'];
      phone.text=mobile1;
    });
  }
  @override
  Widget build(BuildContext context) {
    double theight = MediaQuery.of(context).size.height;
    double twidth = MediaQuery.of(context).size.width;
    double statusbarheight = MediaQuery.of(context).padding.top;
    double tnaviheight = MediaQuery.of(context).padding.bottom;
    double tappbar = kToolbarHeight;

    double bodyheight = theight - statusbarheight - tnaviheight;

    return WillPopScope( onWillPop: onback,
      child: Scaffold(
        body: SafeArea(
            child: Container(
          height: bodyheight,
          width: twidth,
          padding: EdgeInsets.all(bodyheight * 0.01),
          child: Column(
            children: [
              InkWell(
                onTap: () async {
                  print("gggggg");

                  print("efjkijjj");
                  final ImagePicker _picker = ImagePicker();
                  // Pick an image
                  final XFile? image =
                      await _picker.pickImage(source: ImageSource.gallery);

                  setState(() {
                    img = image!.path;
                    print("object");
                  });
                },
                child: Center(
                    child: Container(
                        height: bodyheight * 0.20,
                        width: twidth * 0.35,
                        // decoration: BoxDecoration(border: Border.all(width: 1)),
                        child: img != ""
                            ? CircleAvatar(
                                backgroundImage: FileImage(File(img)),
                                maxRadius: bodyheight * 0.05)
                            : CircleAvatar(
                                backgroundImage: NetworkImage(widget.list[widget.index]['imagepath']),
                              ))),
              ),
              TextField(
                  controller: name,
                  decoration: InputDecoration(
                      labelText: "Name",
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)))),
              SizedBox(
                height: bodyheight * 0.04,
              ),
              TextField(
                  controller: phone,
                  maxLength: 10,
                  decoration: InputDecoration(
                      labelText: "Mobile Number",
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)))),
              SizedBox(
                height: bodyheight * 0.04,
              ),
              ElevatedButton(
                onPressed: () async {
                  final storageRef = FirebaseStorage.instance.ref();
                  String imagename =
                      "MyImages${Random().nextInt(1000)} ${dt.day} /${dt.month} /${dt.year} - ${dt.hour}:${dt.minute}.jpg";
                  final spaceRef =
                      storageRef.child("images/${imagename}"); //imagepath
                  await spaceRef.putFile(File(img));
                  spaceRef.getDownloadURL().then((value) async {
                    print("=====${value}");

                    setState(() {
                         imageurl=value;
                    });

                    DatabaseReference ref = FirebaseDatabase.instance
                        .ref("My Realtime")
                        .child(widget.list[widget.index]['id']); //database name

                    String? id = ref.key; //id key

                    await ref.set({
                      "name": name.text,
                      "Mobile": phone.text,
                      "imagepath": imageurl,
                      "id": id
                    });

                    Fluttertoast.showToast(
                        msg: "Update Sucessfully",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0);

                    Navigator.pushReplacement(context, MaterialPageRoute(
                      builder: (context) {
                        return view();
                      },
                    ));
                  });
                },
                child: Text(
                  "Submit",
                  style: TextStyle(
                    fontSize: bodyheight * 0.03,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.black)),
              )
            ],
          ),
        )),
      ),
    );
  }

  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();

  String img = "";
  DateTime dt = DateTime.now();
  String blankimage = "images/camera.png";
  String imageurl="";



  Future<bool> onback() {

    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      return view();
    },));

    return Future.value(true);
  }
}
