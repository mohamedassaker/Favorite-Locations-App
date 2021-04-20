import 'package:flutter/material.dart';
import 'package:milestone0/models/Favorite.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:milestone0/widgets/provider_widget.dart';

class NewFavoriteLocationurlView extends StatelessWidget {
  final db = Firestore.instance;
  final Location location;
  NewFavoriteLocationurlView({Key key, @required this.location}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController _titleController = new TextEditingController();
    _titleController.text = location.locationurl;

    return Scaffold(
      appBar: AppBar(
        title: Text('Add Favorite Location URL'),
        backgroundColor: Color(0xFF153386),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Enter Location URL'),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: TextField(
                controller: _titleController,
                autofocus: true,
              ),
            ),
            RaisedButton(
                child: Text('Finish'),
                onPressed: () async {
                  //save data to firebase
                  location.locationurl = _titleController.text;
                  final uid = await Provider.of(context).auth.getCurrentUID();

                  await db.collection('userData').document(uid).collection('favorites').add(location.toJson());

                  Navigator.of(context).popUntil((route) => route.isFirst);
                }
            ),
          ],
        ),
      ),
    );
  }
}
