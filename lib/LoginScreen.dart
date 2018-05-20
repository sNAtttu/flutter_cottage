import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'FrontScreen.dart';
import 'Models/Config.dart';
import 'Models/User.dart';

class LoginScreen extends StatefulWidget {
  final Config config;
  LoginScreen(this.config);
  @override
  LoginScreenState createState() => new LoginScreenState();
}

class LoginScreenState extends State<LoginScreen>{

  bool loading = false;
  String username;

  @override
  Widget build(BuildContext context) {

    Future<http.Response> postUsername(String username) async {
      User newUser = new User(username: username);
      return await http.post(
          "${widget.config.devUrl}Users",
          body: json.encode(newUser),
          headers: {"Content-Type": "application/json"});
    }

    usernameOnPressed() async {
      final prefs = await SharedPreferences.getInstance();
      prefs.setString('username', username);
      setState(() {
        loading = true;
      });
      postUsername(username).then((resp){
        setState(() {
          loading = false;
        });
        Navigator.push(context, new MaterialPageRoute(builder: (context) => new FrontScreen(widget.config)));
      });
    }

    return new Scaffold(
      floatingActionButton: new FloatingActionButton(
          child: this.loading ? new Icon(Icons.file_upload) : new Icon(Icons.add),
          onPressed: () => usernameOnPressed()),
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
