import 'package:flutter/material.dart';

class RouteOne extends StatefulWidget {
  const RouteOne({Key key, @required this.notifyLoadingStatus}) : super(key: key);

  final notifyLoadingStatus;

  @override
  _RouteOneState createState() => _RouteOneState(notifyLoadingStatus);
}

class _RouteOneState extends State<RouteOne> {
  _RouteOneState(this.notifyLoadingStatus);

  final notifyLoadingStatus;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.delayed(Duration(milliseconds: 750), () {
        notifyLoadingStatus(false);
      }),
      builder: (context, snapshot) {
        return Container(
          child: Column(
            children: [
              Text('here is route 1'),
              IconButton(
                icon: Icon(Icons.zoom_in),
                onPressed: () {
                  notifyLoadingStatus(true);
                },
              ),
              IconButton(
                icon: Icon(Icons.zoom_out),
                onPressed: () {
                  notifyLoadingStatus(false);
                },
              )
            ],
          ),
        );
      },
    );

    /*
    Container(
      child: Text('here is route 1'),
    );
     */
  }
}
