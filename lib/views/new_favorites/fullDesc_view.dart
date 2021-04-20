import 'package:flutter/material.dart';
import 'package:milestone0/models/Favorite.dart';

import 'imageurl_view.dart';

class NewFavoriteFullDescView extends StatelessWidget {
  final Location location;
  NewFavoriteFullDescView({Key key, @required this.location}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController _titleController = new TextEditingController();
    _titleController.text = location.fullDesc;

    return Scaffold(
      appBar: AppBar(
        title: Text('Add Favorite Full Description'),
        backgroundColor: Color(0xFF153386),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Enter Location Full Description'),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: TextField(
                controller: _titleController,
                autofocus: true,
              ),
            ),
            RaisedButton(
                child: Text('Continue'),
                onPressed: (){
                  location.fullDesc = _titleController.text;
                  Navigator.push(context, MaterialPageRoute(builder: (context) => NewFavoriteImageurlView(location: location)),);
                }
            ),
          ],
        ),
      ),
    );
  }
}
