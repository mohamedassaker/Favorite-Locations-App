import 'package:flutter/material.dart';
import 'package:milestone0/services/auth_service.dart';
import 'package:milestone0/views/explore_view.dart';
import 'package:milestone0/views/new_favorites/location_view.dart';
import 'package:milestone0/models/Favorite.dart';
import 'file:///D:/Apps/AndroidStudioProjects/milestone0/lib/views/profile_view.dart';
import 'package:milestone0/widgets/provider_widget.dart';
import 'help_view.dart';
import 'home_view.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    HomeView(),
    ExplorePage(),
    ProfileView(),
  ];

  @override
  Widget build(BuildContext context) {
    final newFavorite = new Favorite(null,null, null, null, null, null);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => NewFavoriteLocationView(favorite: newFavorite,)),);
          }
      ),
      appBar: AppBar(
        title: Text('Favorite Location App',),
        backgroundColor: Color(0xFF153386),
        actions: <Widget>[
          // IconButton(
          //     icon: Icon(Icons.add),
          //     onPressed: (){
          //       Navigator.push(context, MaterialPageRoute(builder: (context) => NewFavoriteLocationView(favorite: newFavorite,)),);
          //     }
          // ),
          IconButton(
              icon: Icon(Icons.logout),
              onPressed: ()async{
                try{
                  AuthService auth = Provider.of(context).auth;
                  await auth.signOut();
                }catch(e){
                  print(e);
                }
              }
          ),
          IconButton(
              icon: Icon(Icons.help),
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => HelpView()));
              }
          ),
        ],
      ),
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: new Icon(Icons.home),
            title: new Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.explore),
            title: new Text('Explore'),
          ),
           BottomNavigationBarItem(
             icon: new Icon(Icons.account_circle),
             title: new Text('Profile'),
          ),
        ],
      ),
    );
  }

  void onTabTapped(int index){
    setState(() {
      _currentIndex = index;
    });
  }
}
