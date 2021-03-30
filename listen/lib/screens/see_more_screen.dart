import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:listen/models/album_metadata.dart';
import 'package:listen/provider/music_stream.dart';
import 'package:listen/widgets/see_more_screen_shimmer.dart';
import 'package:provider/provider.dart';

class SeeMoreScreen extends StatefulWidget {
  final String type;
  SeeMoreScreen(this.type);
  @override
  _SeeMoreScreenState createState() => _SeeMoreScreenState();
}

class _SeeMoreScreenState extends State<SeeMoreScreen> {
  final _songsRef = FirebaseFirestore.instance.collection('songs');

  @override
  Widget build(BuildContext context) {
    final _musicStream = Provider.of<MusicStream>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_rounded),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(widget.type == ''
            ? 'Songs'
            : '${widget.type[0].toUpperCase() + widget.type.substring(1)}'),
      ),
      backgroundColor: Color(0xFF212121),
      body: FutureBuilder<QuerySnapshot>(
        future: widget.type == ''
            ? _songsRef.get()
            : _songsRef.where('type', isEqualTo: widget.type).get(),
        builder: (ctx, snapshot) {
          bool snap = snapshot.hasData;
          if (!snap) {
            return SeeMoreScreenShimmer();
          }
          final snaps = snapshot.data!.docs;
          return Scrollbar(
            child: ListView.builder(
              // separatorBuilder: (ctx, index) {
              //   return Divider(
              //     color: Colors.black,
              //   );
              // },
              itemBuilder: (ctx, index) {
                final info = AlbumMetadata.getAlbumMetadata(snaps[index]);
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
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: 30,
                                  width: double.infinity,
                                  child: Text(
                                    info.song_name!,
                                    style:
                                        Theme.of(context).textTheme.subtitle2,
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
                                    style:
                                        Theme.of(context).textTheme.subtitle1,
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
                              _musicStream.addSongToQueue(metadata: info);
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
            ),
          );
        },
      ),
    );
  }
}
