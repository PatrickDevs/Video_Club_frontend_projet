import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/library/uTils.dart';
import 'package:http/http.dart' as http;

import 'lecteurVideo.dart';

class Pagevideocorriger extends StatefulWidget {
  const Pagevideocorriger({Key key})
      : super(
          key: key,
        );

  @override
  _PagevideocorrigerState createState() => _PagevideocorrigerState();
}

class _PagevideocorrigerState extends State<Pagevideocorriger> {
  final String apiUrl =
      "http://192.168.0.101:55400/home/fichier"; // recuperation des fichiers reel.

  final String apiUrl_2 = "http://192.168.0.101:55400/home";

  Future dataVideo() async {
    // recuperation des fichiers reel

    var dataApiUrl = await http.get(Uri.parse(apiUrl));

    var tableauDeDonne;

    tableauDeDonne = jsonDecode(dataApiUrl.body) ?? [];

    return tableauDeDonne;

    //print(tableauDeDonne);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white70,
        title: Text("Dev'S Family"),
      ),
      body: Container(
        child: FutureBuilder(
          future: dataVideo(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return GridView.builder(
                itemCount: snapshot.data.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  crossAxisSpacing: 0.0,
                ),
                itemBuilder: (context, int index) {
                  var g = snapshot.data[index];
                  var valeurPosition;

                  //-----------------vrai-------------------------

                  contenu() {
                    //Creation d'une boucle pour recuperer la position d'une video dans le tableau (tableauDeDonne)
                    for (var i = 0; i < snapshot.data.length; i++) {
                      if (snapshot.data[i] == g) {
                        valeurPosition = i ?? 0;

                        // on converti la position en string qu'on stocke dans 'positionEnString'
                        String positionEnString = valeurPosition.toString();
                        return Container(
                          child: DataFromAPI(apiUrl_2 + "/" + positionEnString),
                        );
                      }
                    }
                  }

                  return contenu();
                },
              );
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: Container(
                  alignment: Alignment.center,
                  child: CircularProgressIndicator(),
                ),
              );
            } else {
              return Center(
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        ":(",
                        style: TextStyle(
                          fontSize: 100,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        "Ho la la! Erreur de connection .. ",
                        style: TextStyle(
                          fontStyle: FontStyle.italic,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
          },
        ),
      ),
      /*     floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet_2(context);
        },
        child: Icon(Icons.add),
      ), */
    );
  }
}
