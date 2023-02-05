import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;


class VerifyOtp extends StatefulWidget {
  const VerifyOtp({Key? key}) : super(key: key);

  @override
  State<VerifyOtp> createState() => _VerifyOtpState();
}

class _VerifyOtpState extends State<VerifyOtp> {

  var code1;
  var code2;
  var code3;
  var code4;

  bool isLoading = false;

  var verify = '';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      bottom: true,
      child: Scaffold(
        backgroundColor: Colors.yuktidea,
        body: Form(
            child:Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [

                  Padding(
                    padding: const EdgeInsets.only(top: 50),
                    child: Align(
                        alignment: Alignment.topCenter,
                        child: Column(
                          children: [
                            Text("Verify Your Number",style: TextStyle(fontSize: 25,color: Colors.white),),
                            Text("Enter the OTP received on your number",style: TextStyle(fontSize: 14,color: Colors.white),),
                          ],
                        )
                    ),
                  ),

                  SizedBox(height: 70,),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //
                      // otpBox(first: true, last: false),
                      // otpBox(first: false, last: false),
                      // otpBox(first: false, last: false),
                      // otpBox(first: false, last: true),

                         SizedBox(
                          height: 70,
                          width: 65,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.black,
                            ),
                            child: TextFormField(
                              onChanged: (code){
                                if(code.length == 1) {
                                  code1 = code;
                                  FocusScope.of(context).nextFocus();
                                }
                              },
                              onSaved: (code1){},
                              textAlign: TextAlign.center,
                              keyboardType: TextInputType.number,
                              style: TextStyle(fontSize: 20,color: Colors.white),
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(1),
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                            ),
                          ),
                        ),
                      SizedBox(
                        height: 70,
                        width: 65,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.black,
                          ),
                          child: TextFormField(
                            onChanged: (code){
                              if(code.length == 1) {
                                code2 = code;
                                FocusScope.of(context).nextFocus();
                              }
                            },
                            onSaved: (code2){},
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.number,
                            style: TextStyle(fontSize: 20,color: Colors.white),
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(1),
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 70,
                        width: 65,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.black,
                          ),
                          child: TextFormField(
                            onChanged: (code){
                              if(code.length == 1) {
                                code3 = code;
                                FocusScope.of(context).nextFocus();
                              }
                            },
                            onSaved: (code3){},
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.number,
                            style: TextStyle(fontSize: 20,color: Colors.white),
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(1),
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 70,
                        width: 65,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.black,
                          ),
                          child: TextFormField(
                            onChanged: (code){
                              if(code.length == 1) {
                                code4 = code;
                              }
                            },
                            onSaved: (code4){},
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.number,
                            style: TextStyle(fontSize: 20,color: Colors.white),
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(1),
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                          ),
                        ),
                      ),

                    ],
                  ),
                  SizedBox(height: 50,),

                  SizedBox(
                    height: 45,
                    width: 250,
                    child: ElevatedButton(
                      onPressed: (){
                          verify = '${code1}${code2}${code3}${code4}';
                          print('#################################${verify}');
                          otpVerify(verify);
                          // Fluttertoast.showToast(msg: '$verify');
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
                        "Verify",
                        style: TextStyle(
                            fontSize: 23,
                            color: Colors.white),),
                    ),
                  ),

                  SizedBox(height: 20,),

                  GestureDetector(
                      onTap: (){
                        Fluttertoast.showToast(msg: "Resend API");
                        // reSend();
                      },
                        child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("Resend OTP in ",style: TextStyle(fontSize: 13,color: Colors.yuktideaText),),
                                  Text("10 seconds",style: TextStyle(fontSize: 13,color: Colors.yuktideaRed),),
                                ],
                              ),
                        ),
                  ),
                ],
              ),
            )
        ),
      ),
    );
  }

  Future otpVerify(String otp) async {

    try{

      var uri = Uri.parse('https://cinecompass.yuktidea.com/api/v1/otp/verify');

      Map otpNum = {

        'otp' : otp,
      };

      http.Response response = await http.post(uri,body: otpNum);

      var data = jsonDecode(response.body);
      print('......................${data}');

      if(response.statusCode == 200){
        Navigator.pushNamed(context, 'home');
      }else{
        Fluttertoast.showToast(msg: 'Error in submitting details Retry...');
        Navigator.pushNamed(context, 'home');
      }

    }catch(e){
      print(e);
    }
  }

  // Future reSend() async {
  //
  //   var token;
  //   List data = [];
  //   var jj = 'access_token' as int;
  //   var uri = Uri.parse('https://cinecompass.yuktidea.com/api/v1/otp/resend');
  //   final String jwt_token = data[jj];
  //
  //   // Map<String,String> headerss = {
  //   //
  //   //   'Accept': 'application/json',
  //   //   'Authorization': 'Bearer $jwt_token'
  //   //
  //   // };
  //
  //   http.Response resp = await http.get(uri,headers: {'Accept': 'application/json','Authorization': 'Bearer $jwt_token'});
  //
  //
  //   final json = jsonDecode(resp.body) as Map;
  //   final result = json["data"] as List;
  //
  //   setState(() {
  //     data = result;
  //   });
  //
  //   if(resp.statusCode == 200){
  //     Fluttertoast.showToast(msg: 'success');
  //   }else{
  //     Fluttertoast.showToast(msg: 'sorry');
  //   }
  // }

}
