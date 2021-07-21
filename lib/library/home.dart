import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

import 'pageVideo_2.dart';

class User {
  String pseudoUser, emailUser;
  User(this.pseudoUser, this.emailUser);

  Map toJson() => {'pseudo': pseudoUser, 'email': emailUser};
}

class Homepage extends StatefulWidget {
  const Homepage({Key key}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  TextEditingController _pseudo = TextEditingController(text: '');
  TextEditingController _email = TextEditingController(text: '');

  Dio dio = new Dio();

  postData(String pseudo, email) async {
    final String pathurl = "http://192.168.0.101:55400/home/user/ajout";

    dynamic data = {
      'pseudo': pseudo,
      'email': email,
    };

    var response = await dio.post(pathurl,
        data: data,
        options: Options(headers: {
          'content-type': 'application/json',
        }));

    return response.data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 300,
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Dev'S",
                        style: TextStyle(
                          fontSize: 35,
                        ),
                      ),
                      Text(
                        "Family",
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                controller: _pseudo,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderSide: BorderSide(
                    color: Colors.white,
                  )),
                  hintText: "Pseudo",
                  labelText: "Pseudo",
                  hintStyle: TextStyle(
                    color: Colors.white,
                  ),
                  prefixIcon: Icon(Icons.person, color: Colors.black),
                ),
                keyboardType: TextInputType.name,
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                controller: _email,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.white,
                    ),
                  ),
                  hintText: "email",
                  labelText: "email",
                  hintStyle: TextStyle(
                    color: Colors.white,
                  ),
                  prefixIcon: Icon(Icons.email_outlined),
                ),
                //keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(
                height: 15,
              ),
              ElevatedButton(
                onPressed: () async {
                  if (_pseudo.text.isNotEmpty && _email.text.isNotEmpty) {
                    print('fonction postData');
                    await postData(_pseudo.text, _email.text)
                        .then(
                      (value) => {
                        print(value),
                        Navigator.pop(context),
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return Pagevideocorriger();
                            },
                          ),
                        )
                      },
                    )
                        .catchError((e) {
                      return print(
                          "Erreur de 'POST' data . Ce message est un 'print' a la ligne 142 du fichier home.dart... ");
                    });
                  } else {
                    print(
                        "Data non envoyer.Ce message est un 'print' a la ligne 145 du fichier home.dart... ");
                  }
                },
                child: Text(
                  "C'est parti !",
                ),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(300, 50),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
