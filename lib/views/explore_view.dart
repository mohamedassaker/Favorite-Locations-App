import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:milestone0/views/detailed_location_view.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:milestone0/models/Location.dart';
import 'package:milestone0/locations.dart';

class ExplorePage extends StatelessWidget {
  final List<Location> locationsList = locationsAll().listobj;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: new ListView.builder(
        itemCount: locationsList.length,
        itemBuilder: (BuildContext context, int index) => buildLocationCard(context, index),
      ),
    );
  }

  Widget buildLocationCard(BuildContext context, int index){
    final location = locationsList[index];
    return new Container(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            new ListTile(
              onTap: (){
                // TODO Can be changed to buildLocationPage
                Navigator.push(context, MaterialPageRoute(builder: (context) => DetailLocationView(location: location)),);
              },
              leading: CircleAvatar(
                radius: 30 ,
                backgroundImage: NetworkImage(location.imageurl),
              ),
              title: Text(
                location.locationName,
                style: new TextStyle(fontSize: 20),
              ),
              subtitle: Text('Theme: ${location.theme}'),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildLocationPage(Location location){
    String _locationName = location.locationName;
    String _locationTheme = location.theme;
    String _locationFullDesc = location.fullDesc;
    String _locationImageurl = location.imageurl;
    String _locationurl = location.locationurl;

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
          padding: const EdgeInsets.all(15),
          child: ListView(
            children: <Widget>[
              new Image.network(_locationImageurl,
                  width: 100,
                  height: 350,
                  fit:BoxFit.fill
              ),
              // new SizedBox(height: 10,),
              // notesCard('Theme:'),
              // new Text(_locationTheme,style: new TextStyle(fontSize: 25,),),

              new SizedBox(height: 10,),
              notesCard('Full Description:'),
              new Text(_locationFullDesc,style: new TextStyle(fontSize: 25,),),
              new SizedBox(height: 10,),
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
}