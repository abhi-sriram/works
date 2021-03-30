import 'package:cloud_firestore/cloud_firestore.dart';

class AlbumMetadata {
  final String? album_image, album_name, artist_names, song_name, type, url;

  AlbumMetadata({
    this.album_image,
    this.album_name,
    this.artist_names,
    this.song_name,
    this.type,
    this.url,
  });

  factory AlbumMetadata.getAlbumMetadata(QueryDocumentSnapshot snapshot) {
    return AlbumMetadata(
      album_image: snapshot.get('album_image'),
      album_name: snapshot.get('album_name'),
      artist_names: snapshot.get('artist_names'),
      song_name: snapshot.get('song_name'),
      type: snapshot.get('type'),
      url: snapshot.get('url'),
    );
  }

  addToFirebase(AlbumMetadata metadata) async {
    final ref = FirebaseFirestore.instance.collection('songs');
    List<String> search = [];
    final l1 = List.generate(metadata.album_name!.length,
        (index) => metadata.album_name!.toLowerCase().substring(0, index + 1));
    final l2 = List.generate(metadata.song_name!.length,
        (index) => metadata.song_name!.toLowerCase().substring(0, index + 1));
    final l3 = List.generate(
        metadata.artist_names!.length,
        (index) =>
            metadata.artist_names!.toLowerCase().substring(0, index + 1));

    search = [...l1, ...l2, ...l3];
    await ref.add({
      'url': metadata.url,
      'artist_names': metadata.artist_names,
      'song_name': metadata.song_name,
      'album_name': metadata.album_name,
      'album_image': metadata.album_image,
      'type': metadata.type,
      'search': search,
    });
  }
}
