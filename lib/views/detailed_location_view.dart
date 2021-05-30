import 'package:flutter/material.dart';
import 'package:milestone0/models/Location.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailLocationView extends StatefulWidget {
  final Location location;

  DetailLocationView({Key key, @required this.location}) : super(key: key);

  @override
  _DetailLocationViewState createState() => _DetailLocationViewState();
}

class _DetailLocationViewState extends State<DetailLocationView> {

  @override
  Widget build(BuildContext context) {

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
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xFF153386),
        title: Text(widget.location.locationName),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Show location in Google Maps',
        // backgroundColor: Color(0xFF153386),
        child: Icon(Icons.map),
        onPressed: () async {
          String url = widget.location.locationurl;
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
                child: new Image.network(widget.location.imageurl,
                    fit:BoxFit.fill
                ),
              ),
              new SizedBox(height: 10,),
              notesCard('Full Description:'),
              new Text(widget.location.fullDesc,style: new TextStyle(fontSize: 25,),),
            ],
          ),
        ),
      ),
    );
  }
}