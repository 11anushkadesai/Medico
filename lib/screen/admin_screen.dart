import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medico/readdata/get_user_data.dart';
import 'package:medico/widget/custom_homepage.dart';
import 'package:medico/widget/custom_scaffold.dart';
import 'package:cloud_firestore/cloud_firestore.dart';



class adminhomepage extends StatefulWidget {
  const adminhomepage({super.key});

  @override
  State<adminhomepage> createState() => _adminhomepageState();
}

class _adminhomepageState extends State<adminhomepage> {

  final user=FirebaseAuth.instance.currentUser!;

  List<String> docIds =[];
  Future getDocid() async{
    await FirebaseFirestore.instance.collection('users').get().then
      ((snapshot) => snapshot.docs.forEach((document) {
        print(document.reference);
        docIds.add(document.reference.id);
    }));
  }


  @override
  Widget build(BuildContext context) {
    return CustomHomepage(
      title: "Admin Homepage",
      child:
          Expanded(
            child:
               FutureBuilder(
                 future:getDocid() ,
                 builder: (context,snapshot) {
                   return ListView.builder(
                     itemCount: docIds.length,
                     itemBuilder: (context,index){
                       return Padding(
                         padding: const EdgeInsets.all(8.0),
                         child: ListTile(
                           title: getuserdata(documentId:docIds[index]),
                           tileColor: Colors.grey[400],
                         ),
                       );},);
                   },
               ),
          )
    );

  }
}
