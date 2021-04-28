import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:milestone0/models/Location.dart';
import 'package:milestone0/locations.dart';

class ExplorePage extends StatelessWidget {
  final List<Location> locationsList = locationsAll().listobj;

  // final List<Location> locationsList =[
  //   Location(
  //       id: 2,
  //       locationName: 'Nile',
  //       theme: 'Egypt',
  //       fullDesc: 'The Nile is a major north-flowing river in northeastern Africa. '
  //       'The longest river in Africa, it has historically been considered the longest river in the world, '
  //       'though this has been contested by research suggesting that the Amazon River is slightly longer.',
  //       imageurl: 'https://lp-cms-production.imgix.net/features/2014/07/nile-cruise-egypt-63c7bab066af.jpg?auto=format&fit=crop&sharp=10&vib=20&ixlib=react-8.6.4&w=850',
  //       locationurl: 'https://goo.gl/maps/PTB3QurhtnDWvzPH6'),
  //   Location(
  //       id: 4,
  //       locationName: 'Karnak Temple',
  //       theme: 'Pharaonic',
  //       fullDesc: 'The Karnak Temple Complex, commonly known as Karnak, comprises a vast mix of decayed temples, chapels,'
  //       ' pylons, and other buildings near Luxor, in Egypt.',
  //       imageurl: 'https://lp-cms-production.imgix.net/2019-06/a19a84692952790abb5bd06a8e0d7e79-karnak.jpg',
  //       locationurl: 'https://goo.gl/maps/jQKUjrsGZ2isEWhs8'),
  //   Location(
  //       id: 5,
  //       locationName: 'Wadi El Hitan',
  //       theme: 'World heritage fossil site',
  //       fullDesc: 'Wadi Al-Hitan is a paleontological site in the Faiyum Governorate of Egypt, some 150 kilometres south-west of '
  //       'Cairo. It was designated a UNESCO World Heritage Site in July 2005 for its hundreds of fossils of some of the earliest forms of whale, the archaeoceti.',
  //       imageurl: 'https://upload.wikimedia.org/wikipedia/commons/thumb/9/97/The_whales_fossils.jpg/1200px-The_whales_fossils.jpg',
  //       locationurl: 'https://goo.gl/maps/yEvBX8fLYEtQ7cnd9'),
  //   Location(
  //       id: 6,
  //       locationName: 'Pyramid of Djoser',
  //       theme: 'Pharaonic',
  //       fullDesc: 'The Pyramid of Djoser, or Step Pyramid, is an archaeological site in the Saqqara necropolis, Egypt, northwest of the '
  //       'city of Memphis. The 6-tier, 4-sided structure is the earliest colossal stone building in Egypt. It was built in the 27th century BC during the Third '
  //       'Dynasty for the burial of Pharaoh Djoser.',
  //       imageurl: 'https://www.tripsavvy.com/thmb/6TGF48NyEyn45a6cW6Lss4zknB0=/1885x1414/smart/filters:no_upscale()/GettyImages-911461570-5b76b8fb46e0fb00509c9abe.jpg',
  //       locationurl: 'https://goo.gl/maps/NzmphBy87Ljqtsku5'),
  // ];
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
                Navigator.push(context, MaterialPageRoute(builder: (context) => buildLocationPage(location)),);
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
            )
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