import 'package:flutter/material.dart';

import 'package:video_player/video_player.dart';

import 'uTils.dart';

// ignore: must_be_immutable
class DataFromAPI extends StatefulWidget {
  String attenteDeApiUrl;

  DataFromAPI(String apiUrlEnAttente) {
    this.attenteDeApiUrl = apiUrlEnAttente;
  }
  @override
  _DataFromAPIState createState() => _DataFromAPIState();
}

class _DataFromAPIState extends State<DataFromAPI> {
  final String apiUrl =
      "http://192.168.0.101:55400/home/fichier"; // recuperation des fichiers reel
  final String apiUrl_2 =
      "http://192.168.0.101:55400/home/store/listeFilm"; //recuperation des faux liens
  final String urlDeSupressionVideo =
      "http://192.168.0.101:55400/home/supression";
  final String dataBaseUrlSup = "http://192.168.0.101:55400/home/store";
  final String urlLectureVideo = "http://192.168.0.101:55400/home";

  /* Future<List<dynamic>> fetchUsers() async {
    var result = await http.get(Uri.parse(apiUrl));
    print("result" + result.body);

    var result_2 = await http.get(Uri.parse(apiUrl_2));
    print("result_2" + result_2.body);

    var tableau = json.decode(result.body);
  
    print(tableau.length);
  } */

  VideoPlayerController _controller;
  Future<dynamic> _initializeVideoPlayerFuture;

  @override
  void initState() {
    _controller = VideoPlayerController.network(widget.attenteDeApiUrl);

    _initializeVideoPlayerFuture = _controller.initialize();

    _controller.setLooping(true);

    super.initState();
  }

//bar de progression de la video...
  Widget buildIndicator() => VideoProgressIndicator(
        _controller,
        allowScrubbing: true,
      );

  Widget buildPlay() => _controller.value.isPlaying
      ? Container()
      : Container(
          child: Icon(
            Icons.play_arrow,
            size: 45,
            color: Colors.white,
          ),
        );

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          /*     ElevatedButton(
            child: Text("Click me"),
            onPressed: () {
              fetchUsers();
            },
          ), */
          FutureBuilder(
            future: _initializeVideoPlayerFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () => {
                    _controller.value.isPlaying
                        ? _controller.pause()
                        : _controller.play(),
                  },
                  child: Stack(
                    children: [
                      AspectRatio(
                        aspectRatio: _controller.value.aspectRatio,
                        child: VideoPlayer(_controller),
                      ),
                      //buildPlay(),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        // top: 0,
                        child:
                            buildIndicator(), //bar de progression de la video...
                      ),
                      Positioned(
                        top: 5,
                        left: 305,
                        right: 5,
                        child: TextButton(
                          child: Icon(Icons.add),
                          onPressed: () {
                            return showModalBottomSheet_2(
                              context,
                              widget.attenteDeApiUrl,
                            );
                          },
                          style: TextButton.styleFrom(
                            primary: Colors.white,
                            backgroundColor: Colors.black54,
                            minimumSize: Size(50, 50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(),
                      Text("Chargement..."),
                    ],
                  ),
                );
              }
            },
          ),
/*           FloatingActionButton(
            onPressed: () {
              setState(
                () {
                  //pause
                  if (_controller.value.isPlaying) {
                    _controller.pause();
                  } else {
                    //play
                    _controller.play();
                  }
                },
              );
            },
            child: Icon(
                _controller.value.isPlaying ? Icons.pause : Icons.play_arrow),
          ) */
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
