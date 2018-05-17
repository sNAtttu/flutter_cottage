import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'FrontScreen.dart';


class LoginScreen extends StatefulWidget {
  @override
  LoginScreenState createState() => new LoginScreenState();
}

class LoginScreenState extends State<LoginScreen>{

  String username;


  @override
  Widget build(BuildContext context) {

    usernameOnPressed() async {
      final prefs = await SharedPreferences.getInstance();
      prefs.setString('username', username);
      Navigator.push(context, new MaterialPageRoute(builder: (context) => new FrontScreen()));
    }

    return new Scaffold(
      floatingActionButton: new FloatingActionButton(onPressed: () => usernameOnPressed()),
      appBar: new AppBar(
        title: new Text("Login"),
      ),
      body: new Center(
        child: new TextField(
          onChanged: (value) => this.setState((){ username = value; }),
          decoration: new InputDecoration(
              border: InputBorder.none,
              hintText: 'Please give a username'
          ),
        ),
      ),
    );
  }

}
