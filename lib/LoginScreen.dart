import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'FrontScreen.dart';
import 'Models/Config.dart';

class LoginScreen extends StatefulWidget {
  final Config config;
  LoginScreen(this.config);
  @override
  LoginScreenState createState() => new LoginScreenState();
}

class LoginScreenState extends State<LoginScreen>{
  String username;

  @override
  Widget build(BuildContext context) {

    Future<http.Response> postUsername() async {
      return await http.post("${widget.config.devUrl}Users");
    }

    usernameOnPressed() async {
      final prefs = await SharedPreferences.getInstance();
      prefs.setString('username', username);
      Navigator.push(context, new MaterialPageRoute(builder: (context) => new FrontScreen(widget.config)));
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
