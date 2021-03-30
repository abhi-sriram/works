import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:listen/models/album_metadata.dart';
import 'package:listen/provider/api_calls.dart';

class NewScreen extends StatefulWidget {
  @override
  _NewScreenState createState() => _NewScreenState();
}

class _NewScreenState extends State<NewScreen> {
  final _albumImage = TextEditingController();

  final _albumName = TextEditingController();

  final _artistNames = TextEditingController();

  final _songName = TextEditingController();

  final _url = TextEditingController();

  List val = [false, false];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView(
        children: [
          TextFormField(
            controller: _albumImage,
            decoration: InputDecoration(
              hintText: 'album image',
              hintStyle: TextStyle(color: Colors.white),
            ),
            style: TextStyle(color: Colors.white),
          ),
          TextFormField(
            controller: _albumName,
            decoration: InputDecoration(
              hintText: 'album name',
              hintStyle: TextStyle(color: Colors.white),
            ),
            style: TextStyle(color: Colors.white),
          ),
          TextFormField(
            controller: _artistNames,
            decoration: InputDecoration(
              hintText: 'artist name',
              hintStyle: TextStyle(color: Colors.white),
            ),
            style: TextStyle(color: Colors.white),
          ),
          TextFormField(
            controller: _songName,
            decoration: InputDecoration(
              hintText: 'song name',
              hintStyle: TextStyle(color: Colors.white),
            ),
            style: TextStyle(color: Colors.white),
          ),
          TextFormField(
            controller: _url,
            decoration: InputDecoration(
              hintText: 'url',
              hintStyle: TextStyle(color: Colors.white),
            ),
          ),
          CheckboxListTile(
              value: val[0],
              title: Text('tollywood'),
              onChanged: (b) {
                setState(() {
                  val[0] = b;
                  val[1] = false;
                });
              }),
          CheckboxListTile(
              value: val[1],
              title: Text('bollywood'),
              onChanged: (b) {
                setState(() {
                  val[1] = b;
                  val[0] = false;
                });
              }),
          TextButton(
              onPressed: () {
                AlbumMetadata m = AlbumMetadata(
                  type: val[0] ? 'tollywood' : 'bollywood',
                  album_image: _albumImage.text.trim(),
                  album_name: _albumName.text.trim(),
                  artist_names: _artistNames.text.trim(),
                  song_name: _songName.text.trim(),
                  url: _url.text.trim(),
                );
                AlbumMetadata().addToFirebase(m);
                _albumImage.clear();
                _albumName.clear();
                _songName.clear();
                _url.clear();
                _artistNames.clear();
              },
              child: Text('add'))
        ],
      ),
    );
  }
}
