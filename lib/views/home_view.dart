import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:milestone0/models/Favorite.dart';
import 'package:milestone0/widgets/provider_widget.dart';
import 'detailed_favorite_view.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView>{
  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder(
        stream: getUsersFavoritesSnapshots(context),
        builder: (context, snapshot) {
          if(!snapshot.hasData){
            return Scaffold(
              backgroundColor: Color(0xFF153386),
              body: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SpinKitCircle(color: Colors.white,),
                  Text('Loading', style: TextStyle(color: Colors.white),),
                ],
              ),
            );
          }
          return new ListView.builder(
              itemCount: snapshot.data.documents.length,
              itemBuilder: (BuildContext context, int index) => buildFavoriteCard(context, snapshot.data.documents[index]),
          );
        }
      ),
    );
  }

  TextEditingController _searchcontroller = TextEditingController();
  Stream<QuerySnapshot> getUsersFavoritesSnapshots(BuildContext context) async*{
    final uid = await Provider.of(context).auth.getCurrentUID();
    yield* Firestore.instance.collection('userData').document(uid).collection('favorites').snapshots();
  }

  Widget buildFavoriteCard(BuildContext context, DocumentSnapshot favorite){
    Location newFavorite = new Location(id: favorite['id'],
                            locationName: favorite['locationName'],
                            theme: favorite['theme'],
                            fullDesc: favorite['fullDesc'],
                            imageurl: favorite['imageurl'],
                            locationurl: favorite['locationurl']);
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
                backgroundImage: NetworkImage(favorite['imageurl']),
              ),
              title: Text(
                favorite['locationName'],
                style: new TextStyle(fontSize: 20),
              ),
              subtitle: Text('Theme: ${favorite['theme']}'),
              trailing: Wrap(
                spacing: 5, // space between two icons
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () async {
                      final uid = await Provider.of(context).auth.getCurrentUID();
                      final doc = Firestore.instance.collection('userData').document(uid).collection('favorites').document(favorite.documentID);
                      return await doc.delete();
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}