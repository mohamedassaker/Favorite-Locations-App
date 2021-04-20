import 'package:flutter/material.dart';
import 'package:milestone0/models/Favorite.dart';

import 'fullDesc_view.dart';

class NewFavoriteThemeView extends StatelessWidget {
  final Location location;
  NewFavoriteThemeView({Key key, @required this.location}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController _titleController = new TextEditingController();
    _titleController.text = location.theme;

    return Scaffold(
      appBar: AppBar(
        title: Text('Add Favorite Theme'),
        backgroundColor: Color(0xFF153386),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Enter Location Theme'),
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
                  location.theme = _titleController.text;
                  Navigator.push(context, MaterialPageRoute(builder: (context) => NewFavoriteFullDescView(location: location)),);
                }
            ),
          ],
        ),
      ),
    );
  }
}
