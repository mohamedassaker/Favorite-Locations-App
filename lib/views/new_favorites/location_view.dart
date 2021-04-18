import 'package:flutter/material.dart';
import 'package:milestone0/models/Favorite.dart';
import 'package:milestone0/views/new_favorites/theme_view.dart';

class NewFavoriteLocationView extends StatelessWidget {
  final Favorite favorite;
  NewFavoriteLocationView({Key key, @required this.favorite}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController _titleController = new TextEditingController();
    _titleController.text = favorite.locationName;

    return Scaffold(
      appBar: AppBar(
        title: Text('Add Favorite Location Name'),
        backgroundColor: Color(0xFF153386),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Enter Location Name'),
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
                favorite.locationName = _titleController.text;
                Navigator.push(context, MaterialPageRoute(builder: (context) => NewFavoriteThemeView(favorite: favorite)),);
              }
            ),
          ],
        ),
      ),
    );
  }
}
