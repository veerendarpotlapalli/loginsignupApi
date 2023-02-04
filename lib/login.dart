import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  TextEditingController user = TextEditingController();
  TextEditingController password = TextEditingController();

  bool passwordVisibility = false;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      bottom: true,

      child: Scaffold(
        backgroundColor: Colors.yuktidea,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [

                Padding(
                  padding: const EdgeInsets.only(top: 50),
                  child: Align(
                    alignment: Alignment.topCenter,
                      child: Column(
                        children: [
                          Text('Welcome Back',style: TextStyle(fontSize: 25,color: Colors.white),),
                          Text('Please sign in to your account',style: TextStyle(fontSize: 14,color: Colors.white),),
                        ],
                      )
                  ),
                ),

                SizedBox(height: 50,),

                TextField(
                  controller: user,
                  keyboardType: TextInputType.text,
                  style: TextStyle(fontSize: 17,color: Colors.white),
                  decoration: InputDecoration(
                    labelText: "Email/Phone number",
                    labelStyle: TextStyle(fontSize: 17,color: Colors.yuktideaText),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none),
                    fillColor: Colors.black,
                    filled: true,
                  ),
                ),

                SizedBox(height: 17,),

                TextField(
                  controller: password,
                  obscureText: passwordVisibility,
                  keyboardType: TextInputType.text,
                  style: TextStyle(fontSize: 17,color: Colors.white),
                  decoration: InputDecoration(
                    labelText: "Password",
                    labelStyle: TextStyle(fontSize: 17,color: Colors.yuktideaText),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none),
                    fillColor: Colors.black,
                    filled: true,
                    suffixIcon: IconButton(
                      onPressed: (){
                        setState(() {
                          passwordVisibility = !passwordVisibility;
                        });
                      },
                      icon: Icon(
                        passwordVisibility ? Icons.visibility : Icons.visibility_off,
                        color: Colors.yuktideaText,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 50,),

                SizedBox(
                  height: 45,
                  width: 250,
                  child: ElevatedButton(
                    onPressed: (){
                      if(user.text.isEmpty){
                        Fluttertoast.showToast(msg: "Enter your Email/Phone number");
                      } else if (password.text.isEmpty){
                        Fluttertoast.showToast(msg: "Enter your Password");
                      } else{
                        logIn(user.text.trim().toString(),password.text.trim.toString());
                        // Navigator.pushNamed(context, 'home');
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        primary: Colors.yuktideaRed
                    ),
                    child: isLoading ? Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: CircularProgressIndicator(color: Colors.white,),
                    ):
                    Text(
                      "Login",
                      style: TextStyle(
                          fontSize: 23,
                          color: Colors.white),),
                  ),
                ),

                SizedBox(height: 20,),

                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Don't have an Account?",style: TextStyle(fontSize: 12,color: Colors.yuktideaText),),
                      SizedBox(width: 5,),
                      GestureDetector(
                          onTap: (){
                            Navigator.pushNamed(context, 'signUp');
                          },
                          child: Text("Sign Up",style: TextStyle(fontSize: 15,color: Colors.yuktideaRed),)
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future logIn(String user,password) async {

    try{

      var uri = Uri.parse('https://cinecompass.yuktidea.com/api/v1/login');

      Map loginData = {

        'user' : user,
        'password' : password,

      };

      http.Response response = await http.post(uri,body: loginData);

      var data = jsonDecode(response.body);
      print('......................${data}');

      if(response.statusCode == 200){
        Navigator.pushNamed(context, 'home');
      }else{
        Fluttertoast.showToast(msg: 'Error in submitting details Retry...');
      }

    }catch(e){
      print(e);
    }
  }

}
