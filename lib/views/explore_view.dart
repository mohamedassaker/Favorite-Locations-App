import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/Favorite.dart';
import 'package:milestone0/locations.dart';

class ExplorePage extends StatelessWidget {
  final List<Favorite> favoritesList = locationsAll().listobj;
  // final List<Favorite> favoritesList =[
  //   Favorite(1,'Pyramids', 'Ancient Egypt', 'The Great Pyramid of Giza is the oldest and largest of the pyramids '
  //       'in the Giza pyramid complex bordering present-day Giza in Greater Cairo, Egypt. '
  //       'It is the oldest of the Seven Wonders of the Ancient World, and the only one to remain largely intact.',
  //       'https://www.planetware.com/photos-large/EGY/egypt-cairo-pyramids-of-giza-and%20camels-2.jpg',
  //       'https://goo.gl/maps/8J5rPTiq9VRpKFtz9'),
  //   Favorite(2,'Nile', 'Egypt', 'The Nile is a major north-flowing river in northeastern Africa. '
  //       'The longest river in Africa, it has historically been considered the longest river in the world, '
  //       'though this has been contested by research suggesting that the Amazon River is slightly longer.',
  //       'https://lp-cms-production.imgix.net/features/2014/07/nile-cruise-egypt-63c7bab066af.jpg?auto=format&fit=crop&sharp=10&vib=20&ixlib=react-8.6.4&w=850',
  //       'https://goo.gl/maps/PTB3QurhtnDWvzPH6'),
  //   Favorite(3,'Abu Simbel Temple', 'Ancient Egypt', 'The Abu Simbel temples are two massive rock-cut temples at Abu Simbel, a village in Aswan Governorate, '
  //       'Upper Egypt, near the border with Sudan. They are situated on the western bank of Lake Nasser, about 230 km southwest of Aswan.',
  //       'https://cdn.britannica.com/49/189749-050-EDADDEC0/Great-Temple-of-Ramses-II-temples-larger.jpg',
  //       'https://goo.gl/maps/8T93ykzzYoDounLf6'),
  //   Favorite(4,'Karnak Temple', 'Ancient Egypt', 'The Karnak Temple Complex, commonly known as Karnak, comprises a vast mix of decayed temples, chapels,'
  //       ' pylons, and other buildings near Luxor, in Egypt.',
  //       'https://lp-cms-production.imgix.net/2019-06/a19a84692952790abb5bd06a8e0d7e79-karnak.jpg',
  //       'https://goo.gl/maps/jQKUjrsGZ2isEWhs8'),
  //   Favorite(5,'Wadi El Hitan', 'World heritage fossil site', 'Wadi Al-Hitan is a paleontological site in the Faiyum Governorate of Egypt, some 150 kilometres south-west of '
  //       'Cairo. It was designated a UNESCO World Heritage Site in July 2005 for its hundreds of fossils of some of the earliest forms of whale, the archaeoceti.',
  //       'https://upload.wikimedia.org/wikipedia/commons/thumb/9/97/The_whales_fossils.jpg/1200px-The_whales_fossils.jpg',
  //       'https://goo.gl/maps/yEvBX8fLYEtQ7cnd9'),
  //   Favorite(6,'Pyramid of Djoser', 'Ancient Egypt', 'The Pyramid of Djoser, or Step Pyramid, is an archaeological site in the Saqqara necropolis, Egypt, northwest of the '
  //       'city of Memphis. The 6-tier, 4-sided structure is the earliest colossal stone building in Egypt. It was built in the 27th century BC during the Third '
  //       'Dynasty for the burial of Pharaoh Djoser.',
  //       'https://www.tripsavvy.com/thmb/6TGF48NyEyn45a6cW6Lss4zknB0=/1885x1414/smart/filters:no_upscale()/GettyImages-911461570-5b76b8fb46e0fb00509c9abe.jpg',
  //       'https://goo.gl/maps/NzmphBy87Ljqtsku5'),
  //
  // ];
  @override
  Widget build(BuildContext context) {
    return Container(
      child: new ListView.builder(
        itemCount: favoritesList.length,
        itemBuilder: (BuildContext context, int index) => buildFavoriteCard(context, index),
      ),
    );
  }

  Widget buildFavoriteCard(BuildContext context, int index){
    final favorite = favoritesList[index];
    return new Container(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            new ListTile(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => buildFavoritePage(favorite)),);
              },
              leading: CircleAvatar(
                radius: 30 ,
                backgroundImage: NetworkImage(favorite.imageurl),
              ),
              title: Text(
                favorite.locationName,
                style: new TextStyle(fontSize: 20),
              ),
              subtitle: Text('Theme: ${favorite.theme}'),
            )
          ],
        ),
      ),
    );
  }

  Widget buildFavoritePage(Favorite favorite){
    String _locationName = favorite.locationName;
    String _locationTheme = favorite.theme;
    String _locationFullDesc = favorite.fullDesc;
    String _locationImageurl = favorite.imageurl;
    String _locationurl = favorite.locationurl;

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