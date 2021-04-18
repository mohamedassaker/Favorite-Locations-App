import 'package:flutter/material.dart';
import 'package:milestone0/services/auth_service.dart';
import 'package:milestone0/views/sign_up_view.dart';
import 'package:milestone0/widgets/provider_widget.dart';
import 'views/navigation_view.dart';
import 'package:milestone0/views/first_view.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider(
      auth: AuthService(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Favorite Location Apps',
        theme: ThemeData(
          primarySwatch: Colors.blue,
      ),
        // home: Home(),
        home: HomeController(),
        routes: <String, WidgetBuilder>{
          '/home': (BuildContext context) => HomeController(),
          '/signUp': (BuildContext context) => SignUpView(authFormType: AuthFormType.signUp,),
          '/signIn': (BuildContext context) => SignUpView(authFormType: AuthFormType.signIn,),
          '/anonymousSignIn': (BuildContext context) => SignUpView(authFormType: AuthFormType.anonymous,),
          '/convertUser': (BuildContext context) => SignUpView(authFormType: AuthFormType.convert,),
        },
      ),
    );
  }
}

class HomeController extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AuthService auth = Provider.of(context).auth;
    return StreamBuilder(
      stream: auth.onAuthStateChanged,
      builder: (context, AsyncSnapshot<String> snapshot){
        if(snapshot.connectionState == ConnectionState.active){
          final bool signedIn = snapshot.hasData;
          return signedIn ? Home(): FirstView();
        }
        return CircularProgressIndicator();
      },
    );
  }
}
