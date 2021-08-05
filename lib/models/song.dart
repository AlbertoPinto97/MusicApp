class Song {
  final String artist;
  final String title;
  final String file;
  String duration;
  bool isPaused;
  bool hasStarted;

  Song(
      {required this.artist,
      required this.title,
      required this.duration,
      required this.file,
      required this.isPaused,
      required this.hasStarted});

  setDuration(int durationMinutes, int durationSeconds) {
    String seconds;
    if (durationSeconds % 60 < 10) {
      seconds = '0' + (durationSeconds % 60).toString();
    } else {
      seconds = (durationSeconds % 60).toString();
    }
    String minutes = durationMinutes.toString();
    this.duration = minutes + ':' + seconds;
    print(this.duration);
  }
}
