class Song {
  final String artist;
  final String title;
  final String fileName;
  Duration duration;
  Duration position;
  bool isPaused;
  bool hasStarted;
  bool hasEnded;

  Song(
      {required this.artist,
      required this.title,
      required this.duration,
      required this.position,
      required this.fileName,
      required this.isPaused,
      required this.hasStarted,
      required this.hasEnded});

  String getDurationToString() {
    String seconds;
    if (duration.inSeconds % 60 < 10) {
      seconds = '0' + (duration.inSeconds % 60).toString();
    } else {
      seconds = (duration.inSeconds % 60).toString();
    }
    String minutes = duration.inMinutes.toString();
    return minutes + ':' + seconds;
  }

  String getPositionToString() {
    String seconds;
    if (position.inSeconds % 60 < 10) {
      seconds = '0' + (position.inSeconds % 60).toString();
    } else {
      seconds = (position.inSeconds % 60).toString();
    }
    String minutes = position.inMinutes.toString();
    return minutes + ':' + seconds;
  }
}
