import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:music/models/song.dart';
import 'package:just_audio/just_audio.dart';

class PlayScreen extends StatefulWidget {
  PlayScreen({Key? key}) : super(key: key);

  @override
  _PlayScreenState createState() => _PlayScreenState();
}

class _PlayScreenState extends State<PlayScreen> {
  final _player = AudioPlayer();
  Song _currentSong = new Song(
      artist: 'DIVIIK',
      title: 'City of the Dead',
      duration: Duration(seconds: 0),
      position: Duration(seconds: 0),
      fileName: 'Eurielle City of The Dead.mp3',
      isPaused: true,
      hasStarted: false);

  @override
  initState() {
    super.initState();
    _loadSong();
  }

  _loadSong() async {
    var duration =
        await _player.setAsset('assets/audios/' + this._currentSong.fileName);
    // Listener of the current position
    this._player.positionStream.listen((position) {
      if (this._currentSong.position == this._currentSong.duration) {
        this._currentSong.isPaused = true;
      }
      setState(() {
        this._currentSong.position = this._player.position;
      });
    });
    if (duration != null) {
      //Gets the duration of the song
      this._currentSong.duration = duration;
    }
  }

  playPauseMusic() async {
    if (this._currentSong.isPaused) {
      print("RESUME");
      setState(() {
        this._currentSong.isPaused = false;
      });
      await _player.play();
    } else {
      print("PAUSE");
      setState(() {
        this._currentSong.isPaused = true;
      });
      await _player.pause();
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Scaffold(
        body: Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.orange, Colors.purple],
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Text(
              'Music Player',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 45,
                  fontWeight: FontWeight.w300),
            ),
            SizedBox(
              height: 100,
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(30.0),
              child: Image.asset('assets/images/background_image.jpg'),
            ),
            SizedBox(
              height: 25,
            ),
            Text(
              _currentSong.title,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 40,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              _currentSong.artist,
              style: TextStyle(color: Colors.grey[400], fontSize: 25),
            ),
            Container(
                padding: EdgeInsets.only(bottom: 30, top: 10),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Slider(
                              activeColor: Colors.orange,
                              inactiveColor: Colors.white,
                              value: this
                                  ._currentSong
                                  .position
                                  .inSeconds
                                  .toDouble(),
                              min: 0.0,
                              max: this
                                  ._currentSong
                                  .duration
                                  .inSeconds
                                  .toDouble(),
                              onChanged: (double value) {
                                setState(() {
                                  Duration newDuration =
                                      Duration(seconds: value.toInt());
                                  this._player.seek(newDuration);
                                  value = value;
                                });
                              }),
                        )
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            _currentSong.getPositionToString(),
                            style: TextStyle(color: Colors.white),
                          ),
                          Text(
                            _currentSong.getDurationToString(),
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        InkWell(
                          child: Icon(
                            Icons.skip_previous_rounded,
                            color: Colors.white,
                            size: 40,
                          ),
                          onTap: () => {print('previous')},
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        InkWell(
                            onTap: () => {playPauseMusic()},
                            child: !this._currentSong.isPaused
                                ? Icon(
                                    Icons.pause_circle_filled_rounded,
                                    color: Colors.white,
                                    size: 60,
                                  )
                                : Icon(
                                    Icons.play_circle_filled_rounded,
                                    color: Colors.white,
                                    size: 60,
                                  )),
                        SizedBox(
                          width: 20,
                        ),
                        InkWell(
                          onTap: () => {print('next')},
                          child: Icon(
                            Icons.skip_next_rounded,
                            color: Colors.white,
                            size: 40,
                          ),
                        ),
                      ],
                    ),
                  ],
                )),
          ],
        ),
      ),
    ));
  }
}
