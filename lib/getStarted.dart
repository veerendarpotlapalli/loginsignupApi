import 'package:flutter/material.dart';

class GetStarted extends StatefulWidget {
  const GetStarted({Key? key}) : super(key: key);

  @override
  State<GetStarted> createState() => _GetStartedState();
}

class _GetStartedState extends State<GetStarted> {

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      bottom: true,
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/yuktideaoone.png"),
                  fit:BoxFit.cover
              )
          ),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: SizedBox(
                height: 45,
                width: 250,
                child: ElevatedButton(
                  onPressed: (){
                    Navigator.pushNamed(context, 'login');
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
                    "Get Started",
                    style: TextStyle(
                        fontSize: 23,
                        color: Colors.white),),
                ),
              ),

            ),
          ),
        ),
      ),
    );
  }
}
