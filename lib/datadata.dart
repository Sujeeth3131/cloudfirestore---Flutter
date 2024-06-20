import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ShowData1 extends StatefulWidget {
  const ShowData1({super.key});

  @override
  State<ShowData1> createState() => _ShowDataState();
}

class _ShowDataState extends State<ShowData1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Show Data"),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection("document").snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text("No data available"));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                var doc = snapshot.data!.docs[index];
                return ListTile(
                  leading: CircleAvatar(
                    child: Text("${index + 1}"),
                  ),
                  title:Text("${snapshot.data!.docs[index]["title"]}"),
                  subtitle: Text("${snapshot.data!.docs[index]["description"]}"),
                );
              },
            );
          }
        },
      ),
    );
  }
}

