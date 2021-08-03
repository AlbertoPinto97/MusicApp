import 'package:flutter/material.dart';

class PlayScreen extends StatefulWidget {
  PlayScreen({Key? key}) : super(key: key);

  @override
  _PlayScreenState createState() => _PlayScreenState();
}

class _PlayScreenState extends State<PlayScreen> {
  bool isPlay = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Music App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FloatingActionButton(
                      onPressed: () => {print('previous')},
                      child: Icon(
                        Icons.skip_previous_rounded,
                      )),
                  SizedBox(
                    width: 25,
                  ),
                  FloatingActionButton(
                      onPressed: () => {
                            setState(() {
                              this.isPlay = !this.isPlay;
                            })
                          },
                      child: isPlay
                          ? Icon(
                              Icons.play_arrow_rounded,
                            )
                          : Icon(
                              Icons.pause_rounded,
                            )),
                  SizedBox(
                    width: 25,
                  ),
                  FloatingActionButton(
                      onPressed: () => {print('next')},
                      child: Icon(
                        Icons.skip_next_rounded,
                      )),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
