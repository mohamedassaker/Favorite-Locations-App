import 'package:flutter/material.dart';

class HelpView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Help'),
        backgroundColor: Color(0xFF153386),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                'assets/help.png',
                width: MediaQuery.of(context).size.width*0.85,
                height: MediaQuery.of(context).size.height*0.85,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
