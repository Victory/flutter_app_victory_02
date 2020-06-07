import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'RouteOne.dart';
import 'RouteTwo.dart';

class WelcomeRoute extends StatefulWidget {
  @override
  _WelcomeRouteState createState() => _WelcomeRouteState();
}

class _WelcomeRouteState extends State<WelcomeRoute>
    with SingleTickerProviderStateMixin {
  var _opacityContent = 0.0;
  final _opacityContentDuration = const Duration(milliseconds: 0);
  var _opacityLoader = 1.0;
  final _opacityLoaderDuration = const Duration(milliseconds: 1550);

  void _notifyLoadingStatus(isLoading) {
    setState(() {
      if (isLoading) {
        _opacityContent = 0.0;
        _opacityLoader = 1.0;
      } else {
        _opacityContent = 1.0;
        _opacityLoader = 0.0;
      }
    });
  }

  var _isR = false;

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final theme = Theme.of(context);

    return Container(
      color: theme.primaryColor,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text('Welcome Route'),
          ),
          persistentFooterButtons: [
            IconButton(
              icon: Icon(Icons.assignment_late),
              onPressed: () {
                _notifyLoadingStatus(true);
                setState(() {
                  _isR = !_isR;
                });
              },
            ),
          ],
          body: Stack(
            children: [
              AnimatedOpacity(
                curve: Curves.easeOut,
                opacity: _opacityLoader,
                duration: _opacityLoaderDuration,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SpinKitCircle(
                      size: mq.size.shortestSide - 150,
                      color: theme.primaryColor,
                    ),
                  ],
                ),
              ),
              AnimatedOpacity(
                curve: Curves.easeOutCubic,
                duration: _opacityContentDuration,
                opacity: _opacityContent,
                child: (_isR)
                    ? RouteTwo()
                    : RouteOne(
                        notifyLoadingStatus: _notifyLoadingStatus,
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
