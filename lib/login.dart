import 'package:firebase/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';

class login extends StatefulWidget {


  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  bool status = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    setState(() {
      status = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    double theight = MediaQuery.of(context).size.height;
    double twidth = MediaQuery.of(context).size.width;
    double statusbarheight = MediaQuery.of(context).padding.top;
    double navibartheight = MediaQuery.of(context).padding.bottom;
    double appbarheight = kToolbarHeight;

    double bodyheight = theight - navibartheight - statusbarheight;

    return Scaffold(
        body: status ? SingleChildScrollView(
          child: SafeArea(
              child: Column(
                children: [
                  Container(height: bodyheight*0.30,
                  width: twidth*0.60,
                  decoration: BoxDecoration(image: DecorationImage(image: AssetImage("images/login.gif"))),),
                  Container(
                    height: bodyheight * 0.25,
                    width: twidth,
                    decoration: BoxDecoration(boxShadow: [
                      BoxShadow(
                          color: Colors.black, blurRadius: bodyheight * 0.03)
                    ]),
                    child: Card(
                      shadowColor: Colors.grey,
                      // color: Colors.grey,
                      child: Column(
                        children: [
                          Container(
                            height: bodyheight * 0.10,
                            margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
                            child: TextField(
                              controller: mail,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: "Enter Mail...",
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color(0xe1000211), width: 2)),),
                            ),
                          ),
                          Container(
                            height: bodyheight * 0.10,
                            margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                            child: TextField(
                              controller: pass,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color(0xe1000211), width: 2),
                                ),
                                labelText: "Enter Password...",
                              ),
                            ),
                          ),

                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: bodyheight*0.02,),
                  ElevatedButton(
                    onPressed: () async {
                      try {

                        await FirebaseAuth.instance
                            .signInWithEmailAndPassword(
                            email: mail.text, password: pass.text);
                        print("=====Yes");

                        EasyLoading.show(status: "Please Wait....")
                            .whenComplete(() {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text("LogIn Successfully !"),
                              duration: Duration(seconds: 2)));
                        }).then((value) {
                          EasyLoading.dismiss();
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (context) {
                                return firstdata();
                              },));
                        });
                      }

                      on FirebaseAuthException catch (e) {
                        if (e.code == 'user-not-found') {
                          // print('No user found for that email.');
                          print("=========Email Not Found");

                          Fluttertoast.showToast(
                              msg: "User Not Found",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              fontSize: 16.0);
                        } else if (e.code == 'wrong-password') {
                          // print('Wrong password provided for that user.');
                          print("======Wrong password");
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Wrong Password'),
                                duration: Duration(seconds: 3),
                              ));

                          print(
                              'Wrong password provided for that user.');
                        }
                      }
                    },
                    child: Text(
                      "Sign In",
                      style: TextStyle(fontSize: bodyheight * 0.03,
                          color: Colors.white),
                    ),
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            Colors.black)),
                  ),
                ],
              )),
        ) : Center(
          child: SpinKitFadingCircle(
            itemBuilder: (BuildContext context, int index) {
              return DecoratedBox(
                decoration: BoxDecoration(
                  color: index.isEven ? Colors.red : Colors.green,
                ),
              );
            },
          ),
        )
    );
  }

  TextEditingController mail = TextEditingController();
  TextEditingController pass = TextEditingController();
}
