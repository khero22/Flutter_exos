import 'package:card_1/Actions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';


/*
le 29/05/2019
khero22
knaib22@gmail.com
*/

//class carte personaliser
class MaCarte extends StatefulWidget {
  bool admin;
   String id='';
   String nomCarte = 'sans nom !';
  MaCarte(this.id,this.nomCarte,this.admin);
  @override
  State<StatefulWidget> createState() {
    return Carte(this.id,this.nomCarte,this.admin);
  }
}

//_______________________________________________________
class Carte extends State<MaCarte> {
  bool admin;
  String id='';
  String nomCarte ;
  Carte(this.id,this.nomCarte,this.admin);
  final monController = TextEditingController();
  bool etat=true;
  
  @override
  void initState(){
    monController.text=nomCarte;
   super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onDoubleTap: () => afficherDialogEdit(),
        splashColor: Colors.red,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
          child: Card(
            color: verifieAdminColor(admin),
            elevation: 5,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(new Radius.circular(16.0))),
            child: Container(
              height: 100,
              width: 200,
              child: Row(
                children: <Widget>[
                  PopupMenuButton(
                    itemBuilder: (context) => [
                          PopupMenuItem(
                            child: Text('edit'),
                            value: 1,
                          ),
                          //PopupMenuItem(
                          //  child: Text('delete'),
                          //  value: 2,
                         // )
                        ],
                        icon: Icon(Icons.edit),
                        onSelected: (value)=>editerCarte(value),
                  ),
                  Text(
                    (nomCarte),
                    style:
                        TextStyle(fontSize: 18.0, fontStyle: FontStyle.italic),
                  )
                ],
              ),
            ),
          ),
        ));
  }
 //____________________________________________________________
  affecterText() {
    setState(() {
      this.nomCarte = monController.text;
      editItem(id,monController.text);
      showToast(context, 'votre carte a ete mise a jour avec le nom: ${monController.text}');
      Navigator.pop(context); //pour quitter le dialog
    });
  }
  //____________________________________________________________
  editerCarte(value) {
    if (value==1){
     afficherDialogEdit();
    }
    //if (value==2){
    // etat=false;
    //}
  }
  //____________________________________________________________
   //_______________________________________________________
  afficherDialogEdit() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: Text('Entree un Nom a la Carte:'),
            contentPadding: EdgeInsets.all(15.0),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(new Radius.circular(16.0))),
            children: <Widget>[
              TextField(
                controller: monController,
              ),
              MaterialButton(
                color: Colors.deepPurpleAccent[100],
                child: Text('valider'),
                onPressed: () {
                  affecterText();
                }, //pour quitter
              ),
            ],
          );
        });
  }
 
}
