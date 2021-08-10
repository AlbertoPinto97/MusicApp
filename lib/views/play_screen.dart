import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:music/models/song.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music/service/songManagement.dart';

class PlayScreen extends StatefulWidget {
  PlayScreen({Key? key}) : super(key: key);

  @override
  _PlayScreenState createState() => _PlayScreenState();
}

class _PlayScreenState extends State<PlayScreen> {
  SongManagement _songManagement = SongManagement();
  bool _isRepeating = false;
  bool _isRandom = false;
  final _player = AudioPlayer();
  Song _currentSong = new Song(
      artist: '',
      title: '',
      duration: Duration(seconds: 0),
      position: Duration(seconds: 0),
      filePath: '',
      isPaused: true,
      hasStarted: false);

  @override
  initState() {
    super.initState();
    _initAll();
  }

  void _initAll() async {
    this._currentSong = await _initSongs();
    _loadSong();
  }

  Future<Song> _initSongs() async {
    return await this._songManagement.initSongs();
  }

  void _previousSong() {
    this._player.stop();
    this._currentSong =
        this._songManagement.getPreviousSong(this._currentSong.isPaused);
    if (!this._currentSong.isPaused) this._player.play();
    _loadSong();
  }

  void _nextSong() {
    this._player.stop();
    this._currentSong =
        this._songManagement.getNextSong(this._currentSong.isPaused);
    if (!this._currentSong.isPaused) this._player.play();
    _loadSong();
  }

  void _shuffleSong() {
    setState(() {
      this._isRandom = !this._isRandom;
    });
  }

  void _repeatSong() {
    setState(() {
      this._isRepeating = !this._isRepeating;
    });
    this._isRepeating
        ? this._player.setLoopMode(LoopMode.all)
        : this._player.setLoopMode(LoopMode.off);
  }

  void _loadSong() async {
    var duration = await _player.setFilePath(this._currentSong.filePath);
    //Sets the duration of the song
    if (duration != null) {
      this._currentSong.duration = duration;
    }
    // Listener of the current position
    this._player.positionStream.listen((position) {
      // Song ends
      if (this._currentSong.position.inSeconds ==
          this._currentSong.duration.inSeconds) {
        if (!this._isRepeating) {
          this._currentSong.position = Duration(seconds: 0);
          this._nextSong();
        }
      }
      setState(() {
        this._currentSong.position = this._player.position;
      });
    });
  }

  void playPauseMusic() async {
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
            child: _songUI(),
          )),
    );
  }

  Widget _songUI() {
    return ListView(
      //mainAxisAlignment: MainAxisAlignment.end,
      //TODO: Change ListView to Column after name cleaning of the songs
      children: <Widget>[
        Text(
          'Music Player',
          style: TextStyle(
              color: Colors.white, fontSize: 45, fontWeight: FontWeight.w300),
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
              color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold),
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
                        value: this._currentSong.position.inSeconds.toDouble(),
                        min: 0.0,
                        max: this._currentSong.duration.inSeconds.toDouble(),
                        onChanged: (double value) {},
                        onChangeEnd: (double value) {
                          if (value <=
                              this._currentSong.duration.inSeconds.toDouble()) {
                            setState(() {
                              Duration newDuration =
                                  Duration(seconds: value.toInt());
                              this._player.seek(newDuration);
                              value = value;
                            });
                          }
                        },
                      ),
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
                        onTap: () => {_shuffleSong()},
                        child: this._isRandom
                            ? Icon(
                                Icons.shuffle,
                                color: Colors.orange,
                                size: 25,
                              )
                            : Icon(
                                Icons.shuffle,
                                color: Colors.white,
                                size: 25,
                              )),
                    SizedBox(
                      width: 30,
                    ),
                    InkWell(
                      child: Icon(
                        Icons.skip_previous_rounded,
                        color: Colors.white,
                        size: 40,
                      ),
                      onTap: () => {_previousSong()},
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
                      onTap: () => {_nextSong()},
                      child: Icon(
                        Icons.skip_next_rounded,
                        color: Colors.white,
                        size: 40,
                      ),
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    InkWell(
                        onTap: () => {_repeatSong()},
                        child: this._isRepeating
                            ? Icon(
                                Icons.repeat,
                                color: Colors.orange,
                                size: 25,
                              )
                            : Icon(
                                Icons.repeat,
                                color: Colors.white,
                                size: 25,
                              )),
                  ],
                ),
              ],
            )),
      ],
    );
  }
}
