import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

void main() {
  runApp(new MaterialApp(
    title: "Membaca data JSON",
    home: new HalamanJson(),
  ));
}

class HalamanJson extends StatefulWidget {
  @override
  _HalamanJsonState createState() => _HalamanJsonState();
}

class _HalamanJsonState extends State<HalamanJson> {
  List datadariJSON;

  Future<String> ambildata() async {
    http.Response hasil = await http.get(
        Uri.encodeFull("https://jsonplaceholder.typicode.com/users"),
        headers: {"Accept": "application/json"});

    this.setState(() {
      datadariJSON = json.decode(hasil.body);
    });
  }

  @override
  void initState() {
    this.ambildata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Data JSON"),
      ),
      body: Container(
        child: datadariJSON == null ? new Center( child: CircularProgressIndicator() ) : ListView.builder(
          itemCount: datadariJSON == null ? 0 : datadariJSON.length,
          itemBuilder: (context, i){
            return ListTile(
              title: Text(datadariJSON[i]['name']),
            );
          }
        ),
      ),
    );
  }
}