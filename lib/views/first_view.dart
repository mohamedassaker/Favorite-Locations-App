import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:milestone0/widgets/custom_dialog.dart';

class FirstView extends StatelessWidget {
  final primaryColor = const Color(0xFF153386);

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        width: _width,
        height: _height,
        color: primaryColor,
        child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: <Widget>[
                  SizedBox(height: _height*0.1,),
                  Text(
                    'Welcome',
                    style: TextStyle(fontSize: 44,color: Colors.white),),
                  SizedBox(height: _height*0.1,),
                  AutoSizeText(
                    "Let's start adding your favorite location",
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 40,
                        color: Colors.white
                    ),
                  ),
                  SizedBox(height: _height*0.15,),
                  RaisedButton(
                    color: Colors.white,
                    shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                    child: Padding(
                      padding: const EdgeInsets.only(top:10, bottom:10, left:30, right:30),
                      child: Text(
                        'Get Started',
                        style: TextStyle(
                          color: primaryColor,
                          fontSize: 28,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                    onPressed: (){
                      showDialog(
                        context: context,
                        builder: (BuildContext context) => CustomDialog(
                          title: 'Would you like to create an account?',
                          description: 'With an account, your data will be securely saved, allowing you to access it from multiple devices.',
                          primaryButtonText: 'Create My Account',
                          primaryButtonRoute: '/signUp',
                          secondaryButtonText: 'Maybe Later',
                          secondaryButtonRoute: '/anonymousSignIn',

                        ),
                      );
                    },
                  ),
                  SizedBox(height: _height*0.05,),
                  TextButton(
                    child: Text(
                      'Sign In',
                      style: TextStyle(color: Colors.white, fontSize: 25),
                    ),
                    onPressed: (){
                      Navigator.of(context).pushReplacementNamed('/signIn');
                    },
                  )
                ],
              ),
            ),
        ),
      ),
    );
  }
}
