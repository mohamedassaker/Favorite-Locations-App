import 'package:flutter/material.dart';
import 'package:milestone0/widgets/provider_widget.dart';
import 'package:intl/intl.dart';

class ProfileView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: <Widget>[
            FutureBuilder(
              future: Provider.of(context).auth.getCurrentUser(),
              builder: (context, snapshot){
                if(snapshot.connectionState == ConnectionState.done){
                  return displayUserInformation(context, snapshot);
                } else {
                  return CircularProgressIndicator();
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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Created: ${DateFormat('dd/MM/yyyy').format(user.metadata.creationTime)}', style: TextStyle(fontSize: 25,)),
          ),
          showSignOut(context, user.isAnonymous),
        ],
      ),
    );
  }

  Widget showSignOut(context, bool isAnonymous){
    if(isAnonymous == true){
      return ElevatedButton(
        child: Text('Sign in to save your data'),
          onPressed: (){
            Navigator.of(context).pushNamed('/convertUser');
          }
      );
    }
    return Container(width: 0, height: 0,);
  }
}
