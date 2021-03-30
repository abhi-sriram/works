import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

import 'dart:math';

import 'package:listen/models/album_metadata.dart';
import 'package:listen/provider/music_stream.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';

class SongScreen extends StatefulWidget {
  @override
  _SongScreenState createState() => _SongScreenState();
}

class _SongScreenState extends State<SongScreen> {
  AudioPlayer? _player;
  late ConcatenatingAudioSource _playlist;
  // final _playlist = ConcatenatingAudioSource(children: [
  //   // ClippingAudioSource(
  //   //   start: Duration(seconds: 60),
  //   //   end: Duration(seconds: 90),
  //   //   child: AudioSource.uri(Uri.parse(
  //   //       "https://pwdown.com/113501/Aabaad%20Barbaad%20-%20Arijit%20Singh.mp3")),
  //   //   tag: AudioMetadata(
  //   //     album: "Science Friday",
  //   //     title: "A Salute To Head-Scratching Science (30 seconds)",
  //   //     artwork:
  //   //         "https://media.wnyc.org/i/1400/1400/l/80/1/ScienceFriday_WNYCStudios_1400.jpg",
  //   //   ),
  //   // ),
  //   AudioSource.uri(
  //     Uri.parse(
  //         "https://mp3teluguwap.net/mp3/2020/Rang%20de/Emito%20Idhi%20-%20SenSongsMp3.Com.mp3"),
  //     tag: AudioMetadata(
  //       album: "Rang de",
  //       title: "Emito Idhi",
  //       artwork:
  //           "https://sensongsmp3.audio/wp-content/uploads/2021/03/Rang-de-songs-download-nithin-keerthy-suresh-devi-sri-prasad-sid-sriram-2021.jpg",
  //     ),
  //   ),
  //   AudioSource.uri(
  //     Uri.parse(
  //         "https://mp3teluguwap.net/mp3/2021/Jathi%20Ratnalu/Chitti%20-%20SenSongsMp3.Com.mp3"),
  //     tag: AudioMetadata(
  //       album: "Jathi Ratnalu",
  //       title: "Chitti",
  //       artwork:
  //           "https://sensongsmp3.audio/wp-content/uploads/2021/01/Jathi-Ratnalu-songs-download.jpg",
  //     ),
  //   ),
  // ]);
  // int _addedCount = 0;

  late MusicStream _musicStream;

  // @override
  // void initState() {
  //   super.initState();

  //   _player = AudioPlayer();
  //   SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
  //     statusBarColor: Colors.black,
  //   ));
  //   _init();
  // }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    _musicStream = Provider.of<MusicStream>(context);
    _player = _musicStream.playerInstance;
    _playlist = _musicStream.songsListInstance;
    super.didChangeDependencies();
  }

  // Future<void> _init() async {
  //   final session = await AudioSession.instance;
  //   await session.configure(AudioSessionConfiguration.speech());
  //   try {
  //     await _player.setAudioSource(_musicStream.songsListInstance);
  //   } catch (e) {
  //     // catch load errors: 404, invalid url ...
  //     print("An error occured $e");
  //   }
  // }

  // @override
  // void dispose() {
  //   _player.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        StreamBuilder<SequenceState?>(
          stream: _player?.sequenceStateStream,
          builder: (context, snapshot) {
            final state = snapshot.data;
            if (state?.sequence.isEmpty ?? true) return SizedBox();
            final metadata = state!.currentSource!.tag as AlbumMetadata;

            return Column(
              children: [
                Text(
                  metadata.album_name!,
                  style: Theme.of(context).textTheme.subtitle2,
                ),
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Container(
                    height: 250,
                    width: 250,
                    decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(4),
                        image: DecorationImage(
                          image: NetworkImage(
                            metadata.album_image!,
                          ),
                          fit: BoxFit.cover,
                        )),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  metadata.song_name!,
                  style: Theme.of(context).textTheme.subtitle2,
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  metadata.artist_names!,
                  style: Theme.of(context).textTheme.subtitle1,
                ),
              ],
            );
          },
        ),
        ControlButtons(_player!),
        StreamBuilder<Duration?>(
          stream: _player!.durationStream,
          builder: (context, snapshot) {
            final duration = snapshot.data ?? Duration.zero;
            return StreamBuilder<PositionData>(
              stream: Rx.combineLatest2<Duration, Duration, PositionData>(
                  _player!.positionStream,
                  _player!.bufferedPositionStream,
                  (position, bufferedPosition) =>
                      PositionData(position, bufferedPosition)),
              builder: (context, snapshot) {
                final positionData =
                    snapshot.data ?? PositionData(Duration.zero, Duration.zero);
                var position = positionData.position;
                if (position > duration) {
                  position = duration;
                }
                var bufferedPosition = positionData.bufferedPosition;
                if (bufferedPosition > duration) {
                  bufferedPosition = duration;
                }
                return SeekBar(
                  duration: duration,
                  position: position,
                  bufferedPosition: bufferedPosition,
                  onChangeEnd: (newPosition) {
                    _player!.seek(newPosition);
                  },
                );
              },
            );
          },
        ),
      ],
    );
  }
}

class ControlButtons extends StatelessWidget {
  final AudioPlayer player;

  ControlButtons(this.player);

  void _showSliderDialog({
    required BuildContext context,
    required String title,
    required int divisions,
    required double min,
    required double max,
    String valueSuffix = '',
    required Stream<double> stream,
    required ValueChanged<double> onChanged,
  }) {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title, textAlign: TextAlign.center),
        content: StreamBuilder<double>(
          stream: stream,
          builder: (context, snapshot) => Container(
            height: 100.0,
            child: Column(
              children: [
                Text('${snapshot.data?.toStringAsFixed(1)}$valueSuffix',
                    style: TextStyle(
                        fontFamily: 'Fixed',
                        fontWeight: FontWeight.bold,
                        fontSize: 24.0)),
                Slider(
                  divisions: divisions,
                  min: min,
                  max: max,
                  value: snapshot.data ?? 1.0,
                  onChanged: onChanged,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
            icon: Icon(
              Icons.ac_unit,
              color: Colors.transparent,
            ),
            onPressed: null),
        StreamBuilder<SequenceState?>(
          stream: player.sequenceStateStream,
          builder: (context, snapshot) => IconButton(
            icon: Icon(Icons.skip_previous),
            onPressed: player.hasPrevious ? player.seekToPrevious : null,
          ),
        ),
        StreamBuilder<PlayerState>(
          stream: player.playerStateStream,
          builder: (context, snapshot) {
            final playerState = snapshot.data;
            final processingState = playerState?.processingState;
            final playing = playerState?.playing;
            if (processingState == ProcessingState.loading ||
                processingState == ProcessingState.buffering) {
              return Container(
                margin: EdgeInsets.all(8.0),
                width: 54.0,
                height: 54.0,
                child: CircularProgressIndicator(),
              );
            } else if (playing != true) {
              return IconButton(
                icon: Icon(Icons.play_arrow_rounded),
                iconSize: 64.0,
                onPressed: () {
                  player.play();
                },
              );
            } else if (processingState != ProcessingState.completed) {
              return IconButton(
                icon: Icon(Icons.pause_rounded),
                iconSize: 64.0,
                onPressed: () {
                  player.pause();
                },
              );
            } else {
              return IconButton(
                icon: Icon(Icons.play_arrow_rounded),
                iconSize: 64.0,
                onPressed: () => player.seek(Duration.zero,
                    index: player.effectiveIndices!.first),
              );
            }
          },
        ),
        StreamBuilder<SequenceState?>(
          stream: player.sequenceStateStream,
          builder: (context, snapshot) => IconButton(
            icon: Icon(Icons.skip_next),
            onPressed: player.hasNext ? player.seekToNext : null,
          ),
        ),
        IconButton(
          icon: Icon(Icons.volume_up),
          onPressed: () {
            _showSliderDialog(
              context: context,
              title: "Adjust volume",
              divisions: 10,
              min: 0.0,
              max: 1.0,
              stream: player.volumeStream,
              onChanged: player.setVolume,
            );
          },
        ),
      ],
    );
  }
}

// class AudioMetadata {
//   final String album, title, artwork;

//   AudioMetadata(
//       {required this.album, required this.title, required this.artwork});
// }

class PositionData {
  final Duration position;
  final Duration bufferedPosition;

  PositionData(this.position, this.bufferedPosition);
}

class SeekBar extends StatefulWidget {
  final Duration duration;
  final Duration position;
  final Duration bufferedPosition;
  final ValueChanged<Duration>? onChanged;
  final ValueChanged<Duration>? onChangeEnd;

  SeekBar({
    required this.duration,
    required this.position,
    required this.bufferedPosition,
    this.onChanged,
    this.onChangeEnd,
  });

  @override
  _SeekBarState createState() => _SeekBarState();
}

class _SeekBarState extends State<SeekBar> {
  double? _dragValue;
  late SliderThemeData _sliderThemeData;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _sliderThemeData = SliderTheme.of(context).copyWith(
      trackHeight: 2.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SliderTheme(
          data: _sliderThemeData.copyWith(
            thumbShape: HiddenThumbComponentShape(),
            activeTrackColor: Colors.black,
            inactiveTrackColor: Colors.grey.shade300,
          ),
          child: ExcludeSemantics(
            child: Slider(
              min: 0.0,
              max: widget.duration.inMilliseconds.toDouble(),
              value: widget.bufferedPosition.inMilliseconds.toDouble(),
              onChanged: (value) {
                setState(() {
                  _dragValue = value;
                });
                if (widget.onChanged != null) {
                  widget.onChanged!(Duration(milliseconds: value.round()));
                }
              },
              onChangeEnd: (value) {
                if (widget.onChangeEnd != null) {
                  widget.onChangeEnd!(Duration(milliseconds: value.round()));
                }
                _dragValue = null;
              },
            ),
          ),
        ),
        SliderTheme(
          data: _sliderThemeData.copyWith(
            inactiveTrackColor: Colors.transparent,
          ),
          child: Slider(
            min: 0.0,
            max: widget.duration.inMilliseconds.toDouble(),
            value: min(_dragValue ?? widget.position.inMilliseconds.toDouble(),
                widget.duration.inMilliseconds.toDouble()),
            onChanged: (value) {
              setState(() {
                _dragValue = value;
              });
              if (widget.onChanged != null) {
                widget.onChanged!(Duration(milliseconds: value.round()));
              }
            },
            onChangeEnd: (value) {
              if (widget.onChangeEnd != null) {
                widget.onChangeEnd!(Duration(milliseconds: value.round()));
              }
              _dragValue = null;
            },
          ),
        ),
        Positioned(
          right: 16.0,
          bottom: 0.0,
          child: Text(
            RegExp(r'((^0*[1-9]\d*:)?\d{2}:\d{2})\.\d+$')
                    .firstMatch("$_remaining")
                    ?.group(1) ??
                '$_remaining',
            style: TextStyle(
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),
      ],
    );
  }

  Duration get _remaining => widget.duration - widget.position;
}

class HiddenThumbComponentShape extends SliderComponentShape {
  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) => Size.zero;

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    required bool isDiscrete,
    required TextPainter labelPainter,
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required TextDirection textDirection,
    required double value,
    required double textScaleFactor,
    required Size sizeWithOverflow,
  }) {}
}
