import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:listen/models/album_metadata.dart';
import 'package:listen/provider/music_stream.dart';
import 'package:listen/screens/see_more_screen.dart';
import 'package:listen/widgets/album_cover.dart';
import 'package:listen/widgets/shimmer_widget.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late MusicStream _music;

  final _songsRef = FirebaseFirestore.instance.collection('songs');

  @override
  void initState() {
    super.initState();
    _music = Provider.of<MusicStream>(context, listen: false);
    init();
  }

  init() {
    _music.createSession();
  }

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: ListView(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 6, vertical: 6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Recently added',
                  style: Theme.of(context).textTheme.subtitle2,
                ),
                TextButton.icon(
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (ctx) => SeeMoreScreen('')));
                  },
                  icon: Text('See More'),
                  label: Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 14,
                  ),
                )
              ],
            ),
          ),
          FutureBuilder<QuerySnapshot>(
            future: _songsRef.limit(10).get(),
            builder: (ctx, snapshot) {
              bool snap = snapshot.hasData;
              if (!snap) {
                return ShimmerWidget();
              }
              final snaps = snapshot.data!.docs;
              return Container(
                height: 200,
                child: Center(
                  child: Scrollbar(
                    child: ListView.builder(
                      itemBuilder: (ctx, index) {
                        final info =
                            AlbumMetadata.getAlbumMetadata(snaps[index]);
                        return AlbumCover(info);
                      },
                      itemCount: snaps.length,
                      scrollDirection: Axis.horizontal,
                    ),
                  ),
                ),
              );
            },
          ),
          // Container(
          //   padding: EdgeInsets.symmetric(horizontal: 6, vertical: 6),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     children: [
          //       Text(
          //         'Newly released',
          //         style: Theme.of(context).textTheme.subtitle2,
          //       ),
          //       TextButton.icon(
          //         onPressed: () {},
          //         icon: Text('See More'),
          //         label: Icon(
          //           Icons.arrow_forward_ios_rounded,
          //           size: 14,
          //         ),
          //       )
          //     ],
          //   ),
          // ),
          // Container(
          //   height: 200,
          //   child: Center(
          //     child: ListView.builder(
          //       itemBuilder: (ctx, index) {
          //         return AlbumCover(Colors.red, index);
          //       },
          //       itemCount: 8,
          //       scrollDirection: Axis.horizontal,
          //     ),
          //   ),
          // ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 6, vertical: 6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Tollywood',
                  style: Theme.of(context).textTheme.subtitle2,
                ),
                TextButton.icon(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (ctx) => SeeMoreScreen('tollywood')));
                  },
                  icon: Text('See More'),
                  label: Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 14,
                  ),
                )
              ],
            ),
          ),
          FutureBuilder<QuerySnapshot>(
            future:
                _songsRef.where('type', isEqualTo: 'tollywood').limit(10).get(),
            builder: (ctx, snapshot) {
              bool snap = snapshot.hasData;
              if (!snap) {
                return ShimmerWidget();
              }
              final snaps = snapshot.data!.docs;
              return Container(
                height: 200,
                child: Center(
                  child: Scrollbar(
                    child: ListView.builder(
                      itemBuilder: (ctx, index) {
                        final info =
                            AlbumMetadata.getAlbumMetadata(snaps[index]);
                        return AlbumCover(info);
                      },
                      itemCount: snaps.length,
                      scrollDirection: Axis.horizontal,
                    ),
                  ),
                ),
              );
            },
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 6, vertical: 6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Bollywood',
                  style: Theme.of(context).textTheme.subtitle2,
                ),
                TextButton.icon(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (ctx) => SeeMoreScreen('bollywood')));
                  },
                  icon: Text('See More'),
                  label: Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 14,
                  ),
                )
              ],
            ),
          ),
          FutureBuilder<QuerySnapshot>(
            future:
                _songsRef.where('type', isEqualTo: 'bollywood').limit(10).get(),
            builder: (ctx, snapshot) {
              bool snap = snapshot.hasData;
              if (!snap) {
                return ShimmerWidget();
              }
              final snaps = snapshot.data!.docs;
              return Container(
                height: 200,
                child: Center(
                  child: Scrollbar(
                    child: ListView.builder(
                      itemBuilder: (ctx, index) {
                        final info =
                            AlbumMetadata.getAlbumMetadata(snaps[index]);
                        return AlbumCover(info);
                      },
                      itemCount: snaps.length,
                      scrollDirection: Axis.horizontal,
                    ),
                  ),
                ),
              );
            },
          ),
          // Container(
          //   padding: EdgeInsets.symmetric(horizontal: 6, vertical: 6),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     children: [
          //       Text(
          //         'Hollywood',
          //         style: Theme.of(context).textTheme.subtitle2,
          //       ),
          //       TextButton.icon(
          //         onPressed: () {},
          //         icon: Text('See More'),
          //         label: Icon(
          //           Icons.arrow_forward_ios_rounded,
          //           size: 14,
          //         ),
          //       )
          //     ],
          //   ),
          // ),
          // Container(
          //   height: 200,
          //   child: Center(
          //     child: ListView.builder(
          //       itemBuilder: (ctx, index) {
          //         return AlbumCover(Colors.yellow, index);
          //       },
          //       itemCount: 8,
          //       scrollDirection: Axis.horizontal,
          //     ),
          //   ),
          // ),
          SizedBox(
            height: 6,
          ),
        ],
      ),
    );
  }
}
