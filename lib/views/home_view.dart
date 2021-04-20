import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:milestone0/models/Location.dart';
import 'package:milestone0/widgets/provider_widget.dart';
import 'detailed_location_view.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView>{
  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder(
        stream: getUsersLocationsSnapshots(context),
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
              itemBuilder: (BuildContext context, int index) => buildLocationCard(context, snapshot.data.documents[index]),
          );
        }
      ),
    );
  }

  TextEditingController _searchcontroller = TextEditingController();
  Stream<QuerySnapshot> getUsersLocationsSnapshots(BuildContext context) async*{
    final uid = await Provider.of(context).auth.getCurrentUID();
    yield* Firestore.instance.collection('userData').document(uid).collection('favorites').snapshots();
  }

  Widget buildLocationCard(BuildContext context, DocumentSnapshot location){
    Location newLocation = new Location(id: location['id'],
                            locationName: location['locationName'],
                            theme: location['theme'],
                            fullDesc: location['fullDesc'],
                            imageurl: location['imageurl'],
                            locationurl: location['locationurl']);
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
                backgroundImage: NetworkImage(location['imageurl']),
              ),
              title: Text(
                location['locationName'],
                style: new TextStyle(fontSize: 20),
              ),
              subtitle: Text('Theme: ${location['theme']}'),
              trailing: Wrap(
                spacing: 5, // space between two icons
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.delete),
                    tooltip: 'Delete location',
                    onPressed: () async {
                      final uid = await Provider.of(context).auth.getCurrentUID();
                      final doc = Firestore.instance.collection('userData').document(uid).collection('favorites').document(location.documentID);
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