import 'package:flutter/material.dart';
import 'MaCarte.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'Actions.dart';

/*
le 29/05/2019
khero22
knaib22@gmail.com
*/
//________________________________________________________
main() {
  runApp(CardApplication());
}

//________________________________________________________
class CardApplication extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return Card1();
  }
}

//________________________________________________________
// variable globale
List<Widget> mesCartes = new List();
AsyncSnapshot<QuerySnapshot> snapshotRefresh;

//________________________________________________________
class Card1 extends State<CardApplication> {
// lancer des methodes a l'initialisation de l'app
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'teste de carte avec FireBase',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Exo Flutter 01: [Card+fireBase]'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () => refresh(),
            )
          ],
          backgroundColor: Colors.deepPurple[300],
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: new Radius.circular(16.0),
                  bottomRight: new Radius.circular(16.0))),
          elevation: 8.0,
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: Firestore.instance.collection('listeCartes').snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData)
              return Center(
                child: CircularProgressIndicator(),
              );
            snapshotRefresh = snapshot;

            return Scrollbar(
              child: ListView.builder(
                itemCount: snapshot.data.documents.length,
                itemBuilder: (BuildContext context, int index) {
                  final item = snapshot.data.documents[index];
                  bool tempAdmin;
                  if (item.data['admin']==1) {
                    tempAdmin = true;
                  } else {
                    tempAdmin = false;
                  }

                  return Dismissible(
                    child: new MaCarte(
                        item.documentID, item.data['nom'], tempAdmin),
                    key: Key(item.documentID),
                    onDismissed: (direction) {
                      deleteItem(context, item.documentID,
                          'votre carte sous le nom: ${snapshot.data.documents[index].data['nom']} a ete supprimer !');
                    },
                  );
                },
              ),
            );
          },
        ),
        backgroundColor: Colors.white,
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add_circle_outline),
          backgroundColor: Colors.redAccent,
          onPressed: () => nouvelleCarteVide(context,
              'une nouvelle carte a ete creer avec succee vous pouvez modifier son nom en double cliquant sur elle.'),
        ),
      ),
    );
  }

//________________________________________________________
  nouvelleCarteVide(context, message) {
    setState(() {
      newItem(context, message);
    });
  }
//________________________________________________________
}
