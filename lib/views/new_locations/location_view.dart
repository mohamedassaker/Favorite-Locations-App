import 'package:flutter/material.dart';
import 'package:milestone0/models/Location.dart';
import 'package:milestone0/views/new_locations/theme_view.dart';

class NewLocationView extends StatelessWidget {
  final Location location;
  NewLocationView({Key key, @required this.location}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController _titleController = new TextEditingController();
    _titleController.text = location.locationName;

    return Scaffold(
      appBar: AppBar(
        title: Text('Add Location Location Name'),
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
                location.locationName = _titleController.text;
                Navigator.push(context, MaterialPageRoute(builder: (context) => NewLocationThemeView(location: location)),);
              }
            ),
          ],
        ),
      ),
    );
  }
}
