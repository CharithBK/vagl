import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_register_ui/screens/screen.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import '../widgets/widget.dart';
import '../constants.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:convert';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController user = new TextEditingController();
  TextEditingController pass = new TextEditingController();

  Future register() async {
    //var url = "https://oshan263.000webhostapp.com/register.php";
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

    if (data1['message'] == "Error") {
      Fluttertoast.showToast(
          msg: "This user already exists!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      Fluttertoast.showToast(
          msg: "Registration successful!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  bool passwordVisibility = true;

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
        child: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: Column(
                  children: [
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Opret konto",
                            style: kHeadline,
                          ),
                          Text(
                            "Opret en ny konto for at starte.",
                            style: kBodyText2,
                          ),
                          SizedBox(
                            height: 50,
                          ),
                          MyTextField(
                            controllerName: user,
                            hintText: 'Name',
                            inputType: TextInputType.name,
                          ),
                          MyTextField(
                            hintText: 'Email',
                            inputType: TextInputType.emailAddress,
                          ),
                          MyTextField(
                            hintText: 'Phone',
                            inputType: TextInputType.phone,
                          ),
                          MyPasswordField(
                            controllerName: pass,
                            isPasswordVisible: passwordVisibility,
                            onTap: () {
                              setState(() {
                                passwordVisibility = !passwordVisibility;
                              });
                            },
                          )
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Har du allerede en konto? ",
                          style: kBodyText,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (context) => SignInPage(),
                              ),
                            );
                          },
                          child: Text(
                            'Log på',
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
                      buttonName: 'Opret',
                      onTap: () {
                        register();
                      },
                      bgColor: Colors.white,
                      textColor: Colors.black87,
                    )
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
