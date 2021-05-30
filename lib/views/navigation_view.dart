import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:milestone0/services/auth_service.dart';
import 'package:milestone0/views/explore_view.dart';
import 'package:milestone0/views/new_locations/location_view.dart';
import 'package:milestone0/models/Location.dart';
import 'package:milestone0/views/profile_view.dart';
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
    final newLocation = new Location(id: null, locationName: null, theme: null, fullDesc: null, imageurl: null, locationurl: null);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          tooltip: 'Add new location',
          backgroundColor: Color(0xFF153386),
          child: Icon(Icons.add),
          onPressed: (){
            HapticFeedback.heavyImpact();
            Navigator.push(context, MaterialPageRoute(builder: (context) => NewLocationView(location: newLocation,)),);
          }
      ),
      appBar: AppBar(
        title: Text('Favorite Location App',),
        backgroundColor: Color(0xFF153386),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.logout),
              tooltip: 'Sign Out',
              onPressed: ()async{
                HapticFeedback.heavyImpact();
                try{
                  AuthService auth = Provider.of(context).auth;
                  await auth.signOut();
                }catch(e){
                  print(e);
                }
              }
          ),
          IconButton(
              icon: Icon(Icons.help_outline,color: Colors.blue,),
              tooltip: 'Help',
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
            tooltip: "User's Locations",
            icon: new Icon(Icons.home_outlined),
            activeIcon: new Icon(Icons.home,color: Color(0xFF153386),),
            title: new Text('Home',style: TextStyle(color: Color(0xFF153386))),
          ),
          BottomNavigationBarItem(
            tooltip: 'Suggested Locations',
            icon: new Icon(Icons.explore_outlined),
            activeIcon: new Icon(Icons.explore,color: Color(0xFF153386)),
            title: new Text('Explore',style: TextStyle(color: Color(0xFF153386))),
          ),
           BottomNavigationBarItem(
             tooltip: "User's Profile",
             icon: new Icon(Icons.account_circle_outlined),
             activeIcon: new Icon(Icons.account_circle,color: Color(0xFF153386)),
             title: new Text('Profile',style: TextStyle(color: Color(0xFF153386))),
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
