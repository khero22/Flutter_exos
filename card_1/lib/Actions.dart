import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

/*
le 29/05/2019
khero22
knaib22@gmail.com
*/
// variables globaux ---------------------------------------------

//----------------------------------------------------------------
void newItem(context,message) {
  Firestore.instance.runTransaction((transaction) async {
    await transaction.set(
        Firestore.instance.collection("listeCartes").document(),
        {'nom': 'sans nom!'});
  });
  //afficherToast(context, message);
}
//----------------------------------------------------------------
void editItem(docId, nom) {
  Firestore.instance
      .collection('listeCartes')
      .document(docId)
      .updateData({'nom': nom})
      .catchError((e) {
    print(e);
  });
}

//----------------------------------------------------------------
void deleteItem(context,docId,message) {
  Firestore.instance
      .collection('listeCartes')
      .document(docId)
      .delete()
      .catchError((e) {
    print(e);
  });
  showToast(context, message);
}

//----------------------------------------------------------------
void refresh() async {
  //Firestore.instance.settings(timestampsInSnapshotsEnabled: true);
}
//----------------------------------------------------------------
void showToast(BuildContext context, String message) {
  final scaffold = Scaffold.of(context);
  scaffold.showSnackBar(
    SnackBar(
      content: Text(message),
      action: SnackBarAction(
          label: 'HIDE', onPressed: scaffold.hideCurrentSnackBar),
    ),
  );
}
//----------------------------------------------------------------
Color verifieAdminColor(bool admin){
   if(admin)return Colors.deepOrange[300]; 
  return Colors.deepPurple[100];
}
//----------------------------------------------------------------
