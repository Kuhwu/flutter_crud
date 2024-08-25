import 'package:flutter/material.dart';
import 'package:flutter_crud/model/student_model.dart';
import 'package:flutter_crud/services/api.dart';

class ReadPage extends StatefulWidget {
  const ReadPage({super.key});

  @override
  State<ReadPage> createState() => _ReadPageState();
}

class _ReadPageState extends State<ReadPage> {
  late Future<List<Student>> studentsFuture;

  @override
  void initState() {
    super.initState();
    studentsFuture = Api.getPerson();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blueAccent, Colors.greenAccent],
              ),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(color: Colors.white54),
          ),
          FutureBuilder<List<Student>>(
            future: studentsFuture,
            builder:
                (BuildContext context, AsyncSnapshot<List<Student>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Error: ${snapshot.error}"),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            studentsFuture = Api.getPerson();
                          });
                        },
                        child: Text("Retry"),
                      ),
                    ],
                  ),
                );
              } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                List<Student> sdata = snapshot.data!;

                return ListView.builder(
                  itemCount: sdata.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      leading: Icon(Icons.person_2_rounded, size: 35),
                      title: Text("First Name: ${sdata[index].firstname}"),
                      subtitle: Text("Last Name: ${sdata[index].lastname}"),
                      trailing: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Course: ${sdata[index].course}"),
                          Text("Year: ${sdata[index].year}"),
                          Text(
                              "Enrolled: ${sdata[index].enrolled == true ? 'Yes' : 'No'}"),
                        ],
                      ),
                    );
                  },
                );
              } else {
                return Center(
                  child: Text(
                    "NO DATA FOUND !",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
