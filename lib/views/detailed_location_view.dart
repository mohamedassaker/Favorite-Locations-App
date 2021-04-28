import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailLocationView extends StatefulWidget {
  @override
  _DetailLocationViewState createState() => _DetailLocationViewState();
}

class _DetailLocationViewState extends State<DetailLocationView> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }

}


Widget buildLocationPage(DocumentSnapshot location){
  int _id = location['id'];
  String _locationName = location['locationName'];
  String _locationTheme = location['theme'];
  String _locationFullDesc = location['fullDesc'];
  String _locationImageurl = location['imageurl'];
  String _locationurl = location['locationurl'];

  Widget notesCard(String txt){
    return Card(
      color: Colors.blueAccent,
      child: InkWell(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Text(
                txt,
                style: TextStyle(
                  fontSize: 27, color: Colors.white
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  return new Scaffold(
    backgroundColor: Colors.white,
    appBar: AppBar(
      backgroundColor: Color(0xFF153386),
      title: Text('$_locationName'),
    ),
    floatingActionButton: FloatingActionButton(
        tooltip: 'Show location in Google Maps',
        // backgroundColor: Color(0xFF153386),
        child: Icon(Icons.map),
        onPressed: () async {
          String url = _locationurl;
          if (await canLaunch(url)) {
            await launch(url);
          } else {
            throw 'Could not launch $url';
          }
        },
    ),
    body: Container(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
            Center(
              child: new Image.network(_locationImageurl,
                  fit:BoxFit.fill
              ),
            ),
            new SizedBox(height: 10,),
            // notesCard('Theme:'),
            // new Text(_locationTheme,style: new TextStyle(fontSize: 25,),),
            // new SizedBox(height: 10,),
            notesCard('Full Description:'),
            new Text(_locationFullDesc,style: new TextStyle(fontSize: 25,),),
            // new SizedBox(height: 10,),
            // notesCard('Location:'),
            // new Linkify(
            //   onOpen: _onOpen,
            //   text: _locationurl,
            //   style: new TextStyle(fontSize: 20),
            // ),
          ],
        ),
      ),
    ),
  );

}