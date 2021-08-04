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
              'Title of the song',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 40,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              'Artist',
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
                            '0:24',
                            style: TextStyle(color: Colors.white),
                          ),
                          Text(
                            '3:52',
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
                            onTap: () => {
                                  setState(() {
                                    this.isPlay = !this.isPlay;
                                  })
                                },
                            child: isPlay
                                ? Icon(
                                    Icons.play_circle_filled_rounded,
                                    color: Colors.white,
                                    size: 60,
                                  )
                                : Icon(
                                    Icons.pause_circle_filled_rounded,
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
