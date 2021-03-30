import 'package:flutter/material.dart';
import 'package:listen/models/album_metadata.dart';
import 'package:listen/provider/music_stream.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class AlbumCover extends StatelessWidget {
  final AlbumMetadata albumInfo;
  AlbumCover(this.albumInfo);

  final uuid = Uuid();

  @override
  Widget build(BuildContext context) {
    final _musicStream = Provider.of<MusicStream>(context, listen: false);
    return GestureDetector(
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Playing song...'),
          duration: Duration(
            milliseconds: 800,
          ),
        ));
        _musicStream.playSong(
          metadata: albumInfo,
        );
      },
      child: Container(
        key: ValueKey(uuid.v1()),
        margin: EdgeInsets.only(left: 6),
        height: 200,
        width: 200,
        decoration: BoxDecoration(
            image: DecorationImage(
          image: NetworkImage(albumInfo.album_image!),
          fit: BoxFit.cover,
        )),
        child: Stack(
          children: [
            Positioned(
              bottom: 65,
              left: 50,
              child: Icon(
                Icons.play_arrow_rounded,
                size: 90,
                color: Colors.white70,
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                height: 50,
                width: 200,
                color: Colors.black.withOpacity(0.5),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 4,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            albumInfo.song_name!,
                            style: Theme.of(context)
                                .textTheme
                                .subtitle2!
                                .copyWith(fontSize: 15),
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            albumInfo.album_name!,
                            style: Theme.of(context)
                                .textTheme
                                .subtitle2!
                                .copyWith(fontSize: 12),
                            overflow: TextOverflow.ellipsis,
                          )
                        ],
                      ),
                    ),
                    IconButton(
                        icon: Icon(
                          Icons.queue_music_rounded,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text('Song added to queue.'),
                            duration: Duration(
                              milliseconds: 800,
                            ),
                          ));
                          _musicStream.addSongToQueue(metadata: albumInfo);
                        })
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
