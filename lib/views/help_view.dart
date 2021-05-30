import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HelpView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Help'),
        backgroundColor: Color(0xFF153386),
          actions: <Widget>[
            IconButton(
              tooltip: 'App Demo',
              icon: Icon(Icons.ondemand_video_outlined),
                onPressed: ()async{
                  String url = 'https://www.drive.google.com/file/d/1mtKFYgUpg4M3Y3w14tDqqw2eOQR-i-Gi/view?usp=sharing';
                  if (await canLaunch(url)) {
                    await launch(url);
                  } else {
                    throw 'Could not launch $url';
                  }
                }
          ),
          ]
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
