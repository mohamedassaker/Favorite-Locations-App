import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:milestone0/widgets/provider_widget.dart';

class ProfileView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: <Widget>[
            FutureBuilder(
              future: Provider.of(context).auth.getCurrentUser(),
              builder: (context, snapshot){
                if(snapshot.connectionState == ConnectionState.done){
                  return displayUserInformation(context, snapshot);
                } else {
                  return Scaffold(
                    backgroundColor: Color(0xFF153386),
                    body: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SpinKitCircle(color: Colors.white,),
                        Text('Loading', style: TextStyle(color: Colors.white),),
                      ],
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget displayUserInformation(context, snapshot){
    final user = snapshot.data;
    return Center(
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Name: ${user.displayName ?? 'Anonymous'}', style: TextStyle(fontSize: 25,)),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Email: ${user.email ?? 'Anonymous'}', style: TextStyle(fontSize: 25,)),
          ),
          showSignOut(context, user.isAnonymous),
        ],
      ),
    );
  }

  Widget showSignOut(context, bool isAnonymous){
    if(isAnonymous == true){
      return RaisedButton(
        child: Text('Sign in to save your data'),
          onPressed: (){
            Navigator.of(context).pushNamed('/convertUser');
          }
      );
    }
    return Container(width: 0, height: 0,);
  }

}
