import 'package:audio_session/audio_session.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:just_audio/just_audio.dart';
import 'package:listen/models/album_metadata.dart';

class MusicStream with ChangeNotifier {
  AudioPlayer? _player;
  ConcatenatingAudioSource _playlist = ConcatenatingAudioSource(
    children: [
      AudioSource.uri(
        Uri.parse(
            "https://djsathi.me/files/download/id/21473&volume=75&showstop=1&showvolume=1"),
        tag: AlbumMetadata(
          album_image:
              "https://upload.wikimedia.org/wikipedia/en/b/b8/Ok_Jaanu_poster.jpg",
          album_name: 'Ok Jaanu',
          artist_names: 'Arijit Singh',
          song_name: 'Enna sona',
          type: 'bollywood',
          url: '',
        ),
      ),
      // https://www.deezer.com//artist//3830821
      // AudioSource.uri(
      //   Uri.parse(
      //       "https://mp3teluguwap.net/mp3/2021/Jathi%20Ratnalu/Chitti%20-%20SenSongsMp3.Com.mp3"),
      //   tag: AudioMetadata(
      //     album: "Jathi Ratnalu",
      //     title: "Chitti",
      //     artwork:
      //         "https://sensongsmp3.audio/wp-content/uploads/2021/01/Jathi-Ratnalu-songs-download.jpg",
      //   ),
      // ),
    ],
  );
  // int _addedCount = 0;
  // late MusicStream _musicStream;

  createSession() {
    if (_player == null) {
      _player = AudioPlayer();
      // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      //   statusBarColor: Colors.black,
      // ));
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Color(0xFF1DB954),
      ));
      notifyListeners();
      _init();
    }
  }

  Future<void> _init() async {
    final session = await AudioSession.instance;
    await session.configure(AudioSessionConfiguration.speech());
    try {
      await _player?.setAudioSource(_playlist);
    } catch (e) {
      print("An error occured $e");
    }
    notifyListeners();
    print('Notified listeners');
  }

  AudioPlayer? get playerInstance {
    if (_player == null) {
      createSession();
      return _player;
    }
    return _player;
  }

  playSong({AlbumMetadata? metadata}) async {
    final play = playerInstance;
    if (play!.playing) {
      play.pause();
    }
    _playlist.clear();

    _playlist.add(AudioSource.uri(
      Uri.parse(metadata!.url!),
      tag: metadata,
    ));
    play.setAudioSource(_playlist);

    play.play();
    notifyListeners();
  }

  addSongToQueue({AlbumMetadata? metadata}) async {
    _playlist.add(AudioSource.uri(
      Uri.parse(metadata!.url!),
      tag: metadata,
    ));
    notifyListeners();
  }

  disposePlayer() async {
    _player!.dispose();
    print("disposed");
  }

  // pauseMusic() async {
  //   print('hello');
  //   await _player!.pause();
  //   notifyListeners();
  //   print('notifyed');
  // }

  ConcatenatingAudioSource get songsListInstance {
    return _playlist;
  }
}

// class AudioMetadata {
//   final String album, title, artwork;

//   AudioMetadata(
//       {required this.album, required this.title, required this.artwork});
// }

// class DataSong {
//   final String? album_image, album_name, artist_names, song_name, type, url;

//   DataSong({
//     this.album_image,
//     this.album_name,
//     this.artist_names,
//     this.song_name,
//     this.type,
//     this.url,
//   });
// }

// class Songs {
//   static const String bollywood = "bollywood",
//       tollywood = "tollywood",
//       hollywood = "hollywood";

//   List<DataSong> data = [
//     DataSong(
//       url:
//           "https://mp3teluguwap.net/mp3/2021/Tuck%20Jagadish/Tuck%20Jagadish/1%20-%20Inkosaari%20Inkosaari%20-%20SenSongsMp3.Com_94.mp3",
//       artist_names: "Shreya Ghoshal,Kaala Bhairava",
//       song_name: "Inkosaari Inkosaari",
//       album_name: "Tuck Jagadish (2021)",
//       album_image:
//           "https://upload.wikimedia.org/wikipedia/en/b/be/Tuck_Jagadish_poster.jpg",
//       type: tollywood,
//     ),
//     DataSong(
//       url:
//           "https://mp3teluguwap.net/mp3/2021/Tuck%20Jagadish/Tuck%20Jagadish/Kolo%20Kolanna%20Kolo%20-%20SenSongsMp3.Com.mp3",
//       artist_names: "Armaan Malik, Harini Ivvaturi",
//       song_name: "Kolo Kolanna Kolo",
//       album_name: "Tuck Jagadish (2021)",
//       album_image:
//           "https://upload.wikimedia.org/wikipedia/en/b/be/Tuck_Jagadish_poster.jpg",
//       type: tollywood,
//     ),
//     DataSong(
//       url:
//           "https://sensongsmp3.in.net/mp3/Telugu%20Mp3/2021/Love%20Story/Love%20Story/Saranga%20Dariya%20-%20SenSongsMp3.Com.mp3",
//       artist_names: "Mangli",
//       song_name: "Saranga Dariya",
//       album_name: "Love Story (2021)",
//       album_image:
//           "https://upload.wikimedia.org/wikipedia/en/thumb/4/44/Love_Story_Poster.jpeg/330px-Love_Story_Poster.jpeg",
//       type: tollywood,
//     ),
//     DataSong(
//       url:
//           "https://mp3teluguwap.net/mp3/2020/Love%20Story%20(2020)/Love%20Story%20(2020)/Ay%20Pilla%20-%20SenSongsMp3.Co.mp3",
//       artist_names: "Haricharan",
//       song_name: "Ay Pilla",
//       album_name: "Love Story (2021)",
//       album_image:
//           "https://upload.wikimedia.org/wikipedia/en/thumb/4/44/Love_Story_Poster.jpeg/330px-Love_Story_Poster.jpeg",
//       type: tollywood,
//     ),
//     DataSong(
//       url:
//           "https://mp3teluguwap.net/mp3/2021/Uppena/Uppena%20(2021)/Nee%20Kannu%20Neeli%20Samudram%20-%20SenSongsMp3.Com.mp3",
//       artist_names: "Javed Ali",
//       song_name: "Nee Kannu Neeli Samudram",
//       album_name: "Uppena (2021)",
//       album_image:
//           "https://upload.wikimedia.org/wikipedia/en/thumb/e/e5/Uppena_Poster.jpeg/330px-Uppena_Poster.jpeg",
//       type: tollywood,
//     ),
//     DataSong(
//       url:
//           "https://mp3teluguwap.net/mp3/2021/Jathi%20Ratnalu/Chitti%20-%20SenSongsMp3.Com.mp3",
//       artist_names: "Ram Miriyala",
//       song_name: "Chitti",
//       album_name: "Jathi Ratnalu (2021)",
//       album_image:
//           "https://upload.wikimedia.org/wikipedia/en/7/7e/Jathi_Ratnalu_poster.jpg",
//       type: tollywood,
//     ),
//     DataSong(
//       url:
//           "https://mp3teluguwap.net/mp3/2021/Jathi%20Ratnalu/Mana%20JathiRatnalu.mp3",
//       artist_names: "Rahul Sipligunj",
//       song_name: "Mana Jathi Ratnalu",
//       album_name: "Jathi Ratnalu (2021)",
//       album_image:
//           "https://upload.wikimedia.org/wikipedia/en/7/7e/Jathi_Ratnalu_poster.jpg",
//       type: tollywood,
//     ),
//     DataSong(
//       url:
//           "https://djsathi.me/files/download/id/21473&volume=75&showstop=1&showvolume=1",
//       artist_names: "Arijit Singh",
//       song_name: "Enna Sona",
//       album_name: "Ok Jaanu",
//       album_image:
//           "https://upload.wikimedia.org/wikipedia/en/b/b8/Ok_Jaanu_poster.jpg",
//       type: bollywood,
//     ),
//     DataSong(
//       url:
//           "https://djsathi.me/files/download/id/46280&volume=75&showstop=1&showvolume=1",
//       artist_names: "Arijit Singh",
//       song_name: "Chal Wahan Jaate Hain",
//       album_name: "Private",
//       album_image:
//           "https://new-img.patrika.com/upload/images/2015/07/18/tiger-1437205248_835x547.jpg",
//       type: bollywood,
//     ),
//     DataSong(
//       url:
//           "https://djsathi.me/files/download/id/39558&volume=75&showstop=1&showvolume=1",
//       artist_names: "Arijit Singh",
//       song_name: "Khairiyat Puchho",
//       album_name: "Chhichhore",
//       album_image:
//           "https://upload.wikimedia.org/wikipedia/en/3/3d/Chhichhore_Poster.jpg",
//       type: bollywood,
//     ),
//     DataSong(
//       url:
//           "https://djsathi.me/files/download/id/37557&volume=75&showstop=1&showvolume=1",
//       artist_names: "Arijit Singh",
//       song_name: "Sooraj Dooba Hain Yaaron",
//       album_name: "Roy",
//       album_image:
//           "https://upload.wikimedia.org/wikipedia/en/c/c5/Roy_film_poster.jpg",
//       type: bollywood,
//     ),
//     DataSong(
//       url:
//           "https://djsathi.me/files/download/id/32571&volume=75&showstop=1&showvolume=1",
//       artist_names: "Arijit Singh",
//       song_name: "Pachtaoge",
//       album_name: "Private",
//       album_image:
//           "https://m.media-amazon.com/images/M/MV5BMDRjZjQyOTQtNjFjNS00YThjLWJkODAtNTIyNDgyYTI0ZjkwXkEyXkFqcGdeQXVyMTA5NzIyMDY5._V1_UY268_CR43,0,182,268_AL__QL50.jpg",
//       type: bollywood,
//     ),
//     DataSong(
//       url:
//           "https://djsathi.me/files/download/id/28405&volume=75&showstop=1&showvolume=1",
//       artist_names: "Arijit Singh",
//       song_name: "Ae Dil Hai Mushkil",
//       album_name: "Ae Dil Hai Mushkil",
//       album_image:
//           "https://upload.wikimedia.org/wikipedia/en/e/ec/Ae_Dil_Hai_Mushkil.jpg",
//       type: bollywood,
//     ),
//   ];

//   addSongsToFirebase() async {
    // final ref = FirebaseFirestore.instance.collection('songs');
    // for (var song in data) {
    //   // final s = song.a
    //   List<String> search = [];
    //   final l1 = List.generate(song.album_name!.length,
    //       (index) => song.album_name!.toLowerCase().substring(0, index + 1));
    //   final l2 = List.generate(song.song_name!.length,
    //       (index) => song.song_name!.toLowerCase().substring(0, index + 1));
    //   search = [...l1, ...l2];
    //   await ref.add({
    //     'url': song.url,
    //     'artist_names': song.artist_names,
    //     'song_name': song.song_name,
    //     'album_name': song.album_name,
    //     'album_image': song.album_image,
    //     'type': song.type,
    //     'search': search,
    //   });
    // }
//   }
// }

// DataSong(
//       url: "",
//       artist_names: "",
//       song_name: "",
//       album_name: "",
//       album_image: "",
//       type: bollywood,
//     ),
