import 'package:flutter/material.dart';
import 'package:flutter_crud/createpage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [Colors.blueAccent, Colors.greenAccent])),
          ),
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(color: Colors.white54),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                    onPressed: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => CreatePage()));
                    },
                    icon: Icon(Icons.create),
                    label: Text("Create")),
                Padding(padding: EdgeInsets.only(top: 20)),
                ElevatedButton.icon(
                    onPressed: () {},
                    icon: Icon(Icons.read_more_rounded),
                    label: Text("Read")),
                Padding(padding: EdgeInsets.only(top: 20)),
                ElevatedButton.icon(
                    onPressed: () {},
                    icon: Icon(Icons.update),
                    label: Text("Update")),
                Padding(padding: EdgeInsets.only(top: 20)),
                ElevatedButton.icon(
                    onPressed: () {},
                    icon: Icon(Icons.delete),
                    label: Text("Delete")),
                Padding(padding: EdgeInsets.only(top: 20)),
              ],
            ),
          )
        ],
      ),
    ));
  }
}
