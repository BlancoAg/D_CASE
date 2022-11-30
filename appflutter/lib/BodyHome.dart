import 'package:flutter/material.dart';

import 'Constantes.dart';
import 'Map.dart';

class BodyHomeWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          Align(
            alignment: Alignment(0, 0),
            child: ListView(
              padding: EdgeInsets.zero,
              scrollDirection: Axis.vertical,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 40, 20, 0),
                  child: Container(
                    width: 100,
                    height: MediaQuery.of(context).size.height * 0.24,
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: Image(
                            image: AssetImage('images/map/PB.jpg'),
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height * 1,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Align(
                            alignment: Alignment(0, 0),
                            child: Text("Low Level",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 30))),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 1,
                          child: OutlineButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        zoomeableMap("images/map/PB.jpg")),
                              );
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                  child: Container(
                    width: 100,
                    height: MediaQuery.of(context).size.height * 0.24,
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: Image(
                            image: AssetImage('images/map/P1.jpg'),
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height * 1,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Align(
                            alignment: Alignment(0, 0),
                            child: Text("Floor 1",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 30))),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 1,
                          child: OutlineButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      zoomeableMap("images/map/P1.jpg"),
                                ),
                              );
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                  child: Container(
                    width: 100,
                    height: MediaQuery.of(context).size.height * 0.24,
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: Image(
                            image: AssetImage('images/map/P2.jpg'),
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height * 1,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Align(
                            alignment: Alignment(0, 0),
                            child: Text("Floor 2",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 30,
                                ))),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 1,
                          child: OutlineButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      zoomeableMap("images/map/P2.jpg"),
                                ),
                              );
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          // Align(
          //   alignment: Alignment(0.91, -0.91),
          //   child: FloatingActionButton(
          //     onPressed: () {
          //       print('FloatingActionButton pressed ...');
          //     },
          //     backgroundColor: Color(appbarcolor),
          //     elevation: 8,
          //   ),
          // )
        ],
      ),
    );
  }
}
