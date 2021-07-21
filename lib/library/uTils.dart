import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

final String urlDeSupressionVideo =
    "http://192.168.0.101:55400/home/supression";

//boite modal inferieur
dynamic showModalBottomSheet_2(context, identifiant) {
  showModalBottomSheet(
      context: context,
      builder: (cxt) {
        return Container(
          height: 100,
          child: Center(
              child: Column(
            children: [
              TextButton(
                onPressed: () {},
                child: Text("Ajouter une video"),
              ),
              TextButton(
                onPressed: () async {
                  Navigator.pop(context);
                  var deleteFile = await http.post(
                    Uri.parse(urlDeSupressionVideo + '/' + identifiant),
                    encoding: utf8,
                  );
                  print('Contenu de identifiant $identifiant');
                  print(' Voici la requete de deleteFile: $deleteFile');
                  return deleteFile;
                },
                child: Text("Suprimer une video"),
              ),
            ],
          )),
        );
      });
}
