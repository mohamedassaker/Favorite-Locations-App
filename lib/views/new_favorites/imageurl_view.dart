import 'package:flutter/material.dart';
import 'package:milestone0/models/Favorite.dart';

import 'locationurl_view.dart';

class NewFavoriteImageurlView extends StatelessWidget {
  final Location location;
  NewFavoriteImageurlView({Key key, @required this.location}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController _titleController = new TextEditingController();
    _titleController.text = location.imageurl;

    return Scaffold(
      appBar: AppBar(
        title: Text('Add Favorite Image URL'),
        backgroundColor: Color(0xFF153386),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Enter Location Image URL'),
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
                  location.imageurl = _titleController.text;
                  Navigator.push(context, MaterialPageRoute(builder: (context) => NewFavoriteLocationurlView(location: location)),);
                }
            ),
          ],
        ),
      ),
    );
  }
}
