import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../constants.dart';
import '../screens/screen.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import '../widgets/widget.dart';
import 'package:http/http.dart' as http;

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  TextEditingController user = new TextEditingController();
  TextEditingController pass = new TextEditingController();

  Future login() async {
   // var url = "https://oshan263.000webhostapp.com/login.php";
    var url = "your url";
    print(user.text);
    print(pass.text);

    var map = Map<String, dynamic>();
    map["username"] = user.text;
    map["password"] = pass.text;
    final data = json.encode(map);
    Map<String, String> headers = {"Content-type": "application/json"};

    final response = await http.post(url, headers: headers, body: data);
    // var response = await http.post(url,body: {
    //   "username" : user.text,
    //   "password" : pass.text,
    // });
    print('response==> $response');

    var data1 = json.decode(response.body);

    if (data1['message'] == "Login_Fail") {
      Fluttertoast.showToast(
          msg: "Username or Password incorrect!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      Fluttertoast.showToast(
          msg: "Login successful!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
      Navigator.push(
          // SKIFT DETTE NÅR DER ER LAVET ET LOGIN AUTH!!!
          context, // SKIFT DETTE NÅR DER ER LAVET ET LOGIN AUTH!!!
          CupertinoPageRoute(
            // SKIFT DETTE NÅR DER ER LAVET ET LOGIN AUTH!!!
            builder: (context) =>
                MainPage(), // SKIFT DETTE NÅR DER ER LAVET ET LOGIN AUTH!!!
          ));
    }
  }

  bool isPasswordVisible = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kBackgroundColor,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Image(
            width: 24,
            color: Colors.white,
            image: Svg('assets/images/back_arrow.svg'),
          ),
        ),
      ),
      body: SafeArea(
        //to make page scrollable
        child: CustomScrollView(
          reverse: true,
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      fit: FlexFit.loose,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Velkommen tilbage",
                            style: kHeadline,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Vi har savnet dig!",
                            style: kBodyText2,
                          ),
                          SizedBox(
                            height: 60,
                          ),
                          MyTextField(
                            controllerName: user,
                            hintText: 'Phone, email or username',
                            inputType: TextInputType.text,
                          ),
                          MyPasswordField(
                            controllerName: pass,
                            isPasswordVisible: isPasswordVisible,
                            onTap: () {
                              setState(() {
                                isPasswordVisible = !isPasswordVisible;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Har du ikke en konto? ",
                          style: kBodyText,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (context) => RegisterPage(),
                              ),
                            );
                          },
                          child: Text(
                            'Opret bruger',
                            style: kBodyText.copyWith(
                              color: Colors.white,
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    MyTextButton(
                      buttonName: 'Log på',
                      onTap: () {
                        login();
                        // SKIFT DETTE NÅR DER ER LAVET ET LOGIN AUTH!!!
                      },
                      // SKIFT DETTE NÅR DER ER LAVET ET LOGIN AUTH!!!
                      bgColor: Colors.white,
                      textColor: Colors.black87,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
