import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:milestone0/views/sign_up_view.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailFavoriteView extends StatefulWidget {
  @override
  _DetailFavoriteViewState createState() => _DetailFavoriteViewState();
}

class _DetailFavoriteViewState extends State<DetailFavoriteView> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }

}


Widget buildFavoritePage(DocumentSnapshot favorite){
  int _id = favorite['id'];
  String _locationName = favorite['locationName'];
  String _locationTheme = favorite['theme'];
  String _locationFullDesc = favorite['fullDesc'];
  String _locationImageurl = favorite['imageurl'];
  String _locationurl = favorite['locationurl'];

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

  Future<void> _onOpen(LinkableElement link) async {
    if (await canLaunch(link.url)) {
      await launch(link.url);
    } else {
      throw 'Could not launch $link';
    }
  }

  return new Scaffold(
    backgroundColor: Colors.white,
    appBar: AppBar(
      backgroundColor: Color(0xFF153386),
      title: Text('$_locationName'),
    ),
    floatingActionButton: FloatingActionButton(
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