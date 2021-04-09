import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'Favorite.dart';

class HomeView extends StatelessWidget {
  final List<Favorite> favoritesList =[
    Favorite('Pyramids', 'Ancient Egypt', 'fullDesc', 'https://www.planetware.com/photos-large/EGY/egypt-cairo-pyramids-of-giza-and%20camels-2.jpg', 'locationurl'),
    Favorite('Nile', 'Egypt', 'Desc', 'imageurl', 'locurl'),
  ];
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
                print('pressed');
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
}