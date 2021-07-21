import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';
import 'lecteurVideo.dart';

class PageVideo extends StatefulWidget {
  const PageVideo({Key key}) : super(key: key);

  @override
  _PageVideoState createState() => _PageVideoState();
}
//-------------------------------------------------------------------------------------------------------------

class _PageVideoState extends State<PageVideo> {
  //
  final String apiUrl =
      "http://192.168.0.101:55400/home/fichier"; // recuperation des fichiers reel
  final String apiUrl_2 = "http://192.168.0.101:55400/home";

  //

  var tableauDeDonne;

  //
  Future dataVideo() async {
    // recuperation des fichiers reel

    var dataApiUrl = await http.get(Uri.parse(apiUrl));

    var tableauDeDonne = jsonDecode(dataApiUrl.body);

    print(tableauDeDonne);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black,
        child: FutureBuilder(
          future: dataVideo(),
          builder: (context, snapshot) {
            return GridView.builder(
              itemCount: snapshot.data.length,
              //
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                crossAxisSpacing: 0.0,
              ),
              //
              itemBuilder: (context, index) {
                var g = snapshot.data[index];
                var valeurPosition;
                var i;
                var positionEnString;

                //-----------------vrai-------------------------

                contenu() {
                  for (var i = 0; i < snapshot.data.length; i++) {
                    if (tableauDeDonne[i] == g ?? 0) {
                      valeurPosition = i ?? 0;

                      String positionEnString = valeurPosition.toString();
                      return Container(
                          //child: DataFromAPI(apiUrl_2 + "/" + positionEnString),
                          );
                    }
                  }
                }

                return contenu();
              },
            );
          },
        ),
      ),
      bottomNavigationBar: _buildBottomAppBar(context),
    );
  }

  BottomAppBar _buildBottomAppBar(BuildContext context) {
    return BottomAppBar(
      elevation: 0,
      color: Colors.black,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(
            icon: Icon(
              Icons.menu,
              color: Colors.white,
            ),
            onPressed: () {
              dataVideo();
            },
          ),
        ],
      ),
    );
  }
}

class VideoIndex {
  final String indexVideo, nomVideo;
  VideoIndex(this.indexVideo, this.nomVideo);
}
