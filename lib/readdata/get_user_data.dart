import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class getuserdata extends StatelessWidget {
  final String documentId;
  getuserdata({required this.documentId});

  @override
  Widget build(BuildContext context) {
    //get the collection
    CollectionReference users=FirebaseFirestore.instance.collection('users');
    
    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(documentId).get(),
      builder: (context,snapshot){
      if(snapshot.connectionState == ConnectionState.done){
        Map<String,dynamic> data=snapshot.data!.data()as Map<String,dynamic>;
        return Text('User Name: ${data['User Name']}'+'\n User Email-ID: ${data['User Email-ID']}');
      }
      return Text('loding...');
    }, );
  }
}
