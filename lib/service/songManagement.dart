import 'dart:io';
import 'package:music/models/song.dart';
import 'package:permission_handler/permission_handler.dart';

class SongManagement {
  String _directoryPath = "/storage/0123-4567/musica";
  List<Song> _songs = [];
  int _index = 0;

  Future<Song> initSongs() async {
    // External storage directory: /storage/emulated/0
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
    }
    Directory directory = Directory(_directoryPath);
    await for (var file
        in directory.list(recursive: true, followLinks: false)) {
      this._songs.add(new Song(
          artist: 'DIVIIK',
          title: file.path.split(_directoryPath + '/')[1].split(".mp3")[0],
          duration: Duration(seconds: 1),
          position: Duration(seconds: 0),
          filePath: file.path,
          isPaused: true,
          hasStarted: false));
    }
    return this._songs[_index];
  }

  Song getNextSong(bool isPaused) {
    _index++;
    if (_index > this._songs.length - 1) {
      _index = 0;
    }
    this._songs[_index].isPaused = isPaused;
    return this._songs[_index];
  }

  Song getPreviousSong(bool isPaused) {
    _index--;
    if (_index < 0) {
      _index = this._songs.length - 1;
    }
    this._songs[_index].isPaused = isPaused;
    return this._songs[_index];
  }
}
