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
  final player = AudioPlayer();
  Song currentSong = new Song(
      artist: 'DIVIIK',
      title: 'City of the Dead',
      duration: '0:00',
      file: 'Eurielle City of The Dead.mp3',
      isPaused: true,
      hasStarted: false);

  @override
  initState() {
    super.initState();
    loadSong();
  }

  loadSong() async {
    var duration =
        await player.setAsset('assets/audios/Eurielle City of The Dead.mp3');
    if (duration != null) {
      setState(() {
        this.currentSong.setDuration(duration.inMinutes, duration.inSeconds);
      });
    }
  }

  playPauseMusic() async {
    if (this.currentSong.isPaused) {
      print("RESUME");
      setState(() {
        this.currentSong.isPaused = false;
      });
      await player.play();
    } else {
      print("PAUSE");
      setState(() {
        this.currentSong.isPaused = true;
      });
      await player.pause();
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
              currentSong.title,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 40,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              currentSong.artist,
              style: TextStyle(color: Colors.grey[400], fontSize: 25),
            ),
            Container(
                padding: EdgeInsets.symmetric(vertical: 30),
                child: Column(
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: 20,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          width: 305,
                          height: 10,
                        ),
                        SizedBox(
                          width: 15,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '0:00',
                            style: TextStyle(color: Colors.white),
                          ),
                          Text(
                            currentSong.duration,
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
                            child: !this.currentSong.isPaused
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
