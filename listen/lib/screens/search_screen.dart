import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:listen/models/album_metadata.dart';
import 'package:listen/provider/music_stream.dart';
import 'package:listen/widgets/see_more_screen_shimmer.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _formKey = GlobalKey<FormState>();
  final _songsRef = FirebaseFirestore.instance.collection('songs');
  String search = '';
  @override
  Widget build(BuildContext context) {
    final _musicStream = Provider.of<MusicStream>(context, listen: false);
    return Column(
      children: [
        Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              decoration: InputDecoration(
                filled: true,
                fillColor: Theme.of(context).primaryColor,
                hintText: 'Search...',
                suffixIcon: Icon(
                  Icons.search_rounded,
                  color: Color(0xFF212121),
                ),
              ),
              cursorColor: Color(0xFF212121),
              onChanged: (val) {
                setState(() {
                  search = val;
                });
              },
              style: TextStyle(
                color: Color(0xFF212121),
              ),
            ),
          ),
        ),
        Expanded(
            child: search.length == 0
                ? Center(
                    child: Container(
                    child: Text(
                      'Search listen',
                      style: GoogleFonts.pacifico(
                        fontSize: 40,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ))
                : StreamBuilder<QuerySnapshot>(
                    stream: _songsRef
                        .where('search', arrayContains: search.toLowerCase())
                        .snapshots(),
                    builder: (ctx, snap) {
                      final data = snap.hasData;
                      if (!data) {
                        return SeeMoreScreenShimmer();
                      }
                      final snaps = snap.data!.docs;
                      return ListView.builder(
                        // separatorBuilder: (ctx, index) {
                        //   return Divider(
                        //     color: Colors.black,
                        //   );
                        // },
                        itemBuilder: (ctx, index) {
                          final info =
                              AlbumMetadata.getAlbumMetadata(snaps[index]);
                          return Card(
                            color: Color(0xFF212121),
                            child: Container(
                              height: 100,
                              padding: EdgeInsets.all(5),
                              child: Row(
                                children: [
                                  Container(
                                    width: 90,
                                    height: 90,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: NetworkImage(
                                          info.album_image!,
                                        ),
                                        fit: BoxFit.cover,
                                      ),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 4,
                                  ),
                                  Expanded(
                                    child: Container(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            height: 30,
                                            width: double.infinity,
                                            child: Text(
                                              info.song_name!,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .subtitle2,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 3,
                                          ),
                                          Container(
                                            height: 30,
                                            width: double.infinity,
                                            child: Text(
                                              info.album_name!,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .subtitle1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 4,
                                  ),
                                  IconButton(
                                      icon: Icon(
                                        Icons.queue_music_rounded,
                                        color: Colors.white,
                                        size: 30,
                                      ),
                                      onPressed: () {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                          content: Text('Song added to queue.'),
                                          duration: Duration(
                                            milliseconds: 800,
                                          ),
                                        ));
                                        _musicStream.addSongToQueue(
                                            metadata: info);
                                      }),
                                  IconButton(
                                      icon: Icon(
                                        Icons.play_arrow_rounded,
                                        color: Colors.white,
                                        size: 30,
                                      ),
                                      onPressed: () {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                          content: Text('Playing song...'),
                                          duration: Duration(
                                            milliseconds: 800,
                                          ),
                                        ));
                                        _musicStream.playSong(
                                          metadata: info,
                                        );
                                      })
                                ],
                              ),
                            ),
                          );
                        },
                        itemCount: snaps.length,
                      );
                    },
                  ))
      ],
    );
  }
}
