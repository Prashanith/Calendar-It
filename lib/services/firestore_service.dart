
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

final FirebaseFirestore firestore=FirebaseFirestore.instance;

final CollectionReference tasks = firestore.collection("tasks");

Future createTask({required String task,required String description, required DateTime dateTime}) async {
  try{
    print("Entered");
    await tasks.add({
      'task':task,
      'description':description,
      'dateTime':dateTime
    });
  }
  catch(e){
    log(e.toString());
  }
}