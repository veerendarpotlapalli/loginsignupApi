import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';


class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  TextEditingController userName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();

  bool passwordVisibility = false;
  bool isLoading = false;
  bool con_passwordVisibility = false;
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
                          Text("Create New Account",style: TextStyle(fontSize: 25,color: Colors.white),),
                          Text("Fill in the form to continue",style: TextStyle(fontSize: 14,color: Colors.white),),
                        ],
                      )
                  ),
                ),

                SizedBox(height: 50,),

                TextField(
                  controller: userName,
                  keyboardType: TextInputType.text,
                  style: TextStyle(fontSize: 17,color: Colors.white),
                  decoration: InputDecoration(
                    labelText: "Name",
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
                  controller: email,
                  keyboardType: TextInputType.text,
                  style: TextStyle(fontSize: 17,color: Colors.white),
                  decoration: InputDecoration(
                    labelText: "Email",
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
                  controller: phone,
                  keyboardType: TextInputType.number,
                  style: TextStyle(fontSize: 17,color: Colors.white),
                  decoration: InputDecoration(
                    labelText: "Phone",
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

                SizedBox(height: 17,),

                TextField(
                  controller: confirmPassword,
                  obscureText: con_passwordVisibility,
                  keyboardType: TextInputType.text,
                  style: TextStyle(fontSize: 17,color: Colors.white),
                  decoration: InputDecoration(
                    labelText: "Confirm Password",
                    labelStyle: TextStyle(fontSize: 17,color: Colors.yuktideaText),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none),
                    fillColor: Colors.black,
                    filled: true,
                    suffixIcon: IconButton(
                      onPressed: (){
                        setState(() {
                          con_passwordVisibility = !con_passwordVisibility;
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
                      if(userName.text.isEmpty){
                        Fluttertoast.showToast(msg: "Enter Your Name");
                      } else if(phone.text.isEmpty){
                        Fluttertoast.showToast(msg: "Enter Your Phone number");
                      } else if(email.text.isEmpty){
                        Fluttertoast.showToast(msg: "Enter Your Email");
                      } else if(password.text.isEmpty){
                        Fluttertoast.showToast(msg: "Enter Your Password");
                      } else if(confirmPassword.text.isEmpty){
                        Fluttertoast.showToast(msg: "Confirm Password");
                      } else {
                        signUp(userName.text.trim().toString(),email.text.trim().toString(),phone.text.trim().toString(),password.text.trim().toString(),confirmPassword.text.trim().toString());
                        // Navigator.pushNamed(context, 'verifyOtp');
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
                      "Sign Up",
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
                      Text("Already have an Account?",style: TextStyle(fontSize: 12,color: Colors.yuktideaText),),
                      SizedBox(width: 5,),
                      GestureDetector(
                        onTap: (){
                          Navigator.pushNamed(context, 'login');
                        },
                          child: Text("Login",style: TextStyle(fontSize: 15,color: Colors.yuktideaRed),)
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
  } //build

Future signUp(String name, email, phone, password, confirmPassword) async {
    try{

      var uri = Uri.parse('https://cinecompass.yuktidea.com/api/v1/register');

      Map userdata = {

            'name' : name,
            'email' : email,
            'phone' : phone,
            'password' : password,
            'password_confirmation' : confirmPassword,

      };

      refresh();
      http.Response response = await http.post(uri as Uri,body: userdata);

      var data = jsonDecode(response.body);
      print('......................${data}');

      if(response.statusCode == 200){
        Navigator.pushNamed(context, 'verifyOtp');
      }else{
        Fluttertoast.showToast(msg: 'Error in submitting details Retry...');
      }

    }catch(e){
      print(e);
    }
}

Future refresh () async {


  var uri2 = Uri.parse('https://cinecompass.yuktidea.com/api/v1/refresh');

  Map<String,String> headerss = {

    'Accept': 'application/json',
    'Authorization': 'Bearer jwt_token'

  };

  http.Response resp = await http.get(uri2,headers: headerss);
  if(resp.statusCode == 200){
    Fluttertoast.showToast(msg: 'success');
  }else{
    Fluttertoast.showToast(msg: 'sorry');
  }

}

} //_

