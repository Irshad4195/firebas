import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Screen"),
        centerTitle: true,
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection("Users").snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Colors.deepPurpleAccent.withOpacity(0.1)),
                        child: ListTile(
                          leading: CircleAvatar(
                              backgroundColor:
                                  Colors.deepPurpleAccent.withOpacity(0.0),
                              child: Text("${index + 1}.")),
                          title: Text(snapshot.data!.docs[index]["Name"]),
                          subtitle: Text(snapshot.data!.docs[index]["Email"]),
                        ),
                      ),
                    );
                  },
                  itemCount: snapshot.data!.docs.length,
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text("${snapshot.hasError.toString()}"),
                );
              } else {
                return Center(
                  child: Text("Data Not Found!!"),
                );
              }
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}
