import 'package:flutter/material.dart';
import 'package:milestone0/models/Favorite.dart';

import 'locationurl_view.dart';

class NewFavoriteImageurlView extends StatelessWidget {
  final Favorite favorite;
  NewFavoriteImageurlView({Key key, @required this.favorite}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController _titleController = new TextEditingController();
    _titleController.text = favorite.imageurl;

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
                  favorite.imageurl = _titleController.text;
                  Navigator.push(context, MaterialPageRoute(builder: (context) => NewFavoriteLocationurlView(favorite: favorite)),);
                }
            ),
          ],
        ),
      ),
    );
  }
}
