import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';


void main() {
  runApp(new MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'JSON Parsing Example',
    home: new MyHomePage(),
  ));
}

// Stateful widget
class MyHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyHomePageState();
  }
}

// API Calling and JSON Response Parsing
Future<Map> _getJson() async {
  var response = await http.get(
      'https://cricapi.com/api/matches?apikey=ap2pOQEi9CXANoBgYmUcsLh2Gag2');

  return json.decode(response.body);
}

// State Class of the Stateful Widget
class _MyHomePageState extends State<MyHomePage> {
  var matches;

  void getData() async {
    var data = await _getJson();
    setState(() {
      matches = data['matches'];
    });
  }

  @override
  Widget build(BuildContext context) {
    getData();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Matches",
          style: new TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700
          ),),


      ),


      body: Column(

        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(10.0),
          ),
          Expanded(
            child: ListView.builder(
                itemCount: matches == null ? 0 : matches.length,
                itemBuilder: (context, i) {
                  return Card(
                      child: ListTile(
                          title: Text(
                              (matches[i]['team-1']) + " " + 'V/S' + " " +
                                  (matches[i]['team-2'])),
                          subtitle: Text(matches[i]['date'])
                          trailing: Column(
                              children: <Widget>[
                                Text(
                                  'Type:',
                                  style: new TextStyle(
                                      fontWeight: FontWeight.w700),
                                ),
                                Text(
                                  matches[i]['type'],
                                  style: new TextStyle(
                                      fontStyle: FontStyle.italic),
                                ),
                             ])
                      )
                  );
                }
            ),
          )
        ],
      ),
    );
  }
}
