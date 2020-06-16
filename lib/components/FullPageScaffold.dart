import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../main.dart';

class FullPageScaffold extends StatefulWidget {
  final Widget child;

  const FullPageScaffold({Key key, @required this.child}) : super(key: key);

  @override
  _FullPageScaffoldState createState() => _FullPageScaffoldState();
}

class _FullPageScaffoldState extends State<FullPageScaffold>
    with SingleTickerProviderStateMixin {
  static const _opacityContentDuration = Duration(milliseconds: 3000);
  static const _opacityLoaderDuration = Duration(milliseconds: 3550);

  var _isShow = true;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final loadModel = Provider.of<LoaderModel>(context, listen: true);

    return Container(
      color: theme.primaryColor,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          print('top tap');
        },
        child: SafeArea(
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              print('safe tap');
            },
            child: Stack(children: [
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  print('stack one tap');
                },
                child: AnimatedOpacity(
                  curve: Curves.easeOutCubic,
                  duration: _opacityContentDuration,
                  opacity: loadModel.contentOpacity,
                  child: Scaffold(
                    appBar: AppBar(
                      title: Text('Full Page Scaffold'),
                    ),
                    persistentFooterButtons: [
                      IconButton(
                        icon: Icon(Icons.assignment_late),
                        onPressed: () {
                          print('pressy pressy');
                          var lm = Provider.of<LoaderModel>(context, listen: false);
                          _isShow = !_isShow;
                          if (_isShow) {
                            lm.stopLoading();
                          } else {
                            lm.startLoading();
                          }
                        },
                      ),
                    ],
                    body: widget.child,
                  ),
                ),
              ),
              GestureDetector(
                onTap:() {
                  print('stack two tap');
                },
                child: AnimatedOpacity(
                  curve: Curves.easeOut,
                  opacity: loadModel.loadOpacity,
                  duration: _opacityLoaderDuration,
                  child: GestureDetector(
                    onTap: () {
                      print('column tap');

                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('loading column'),
                      ],
                    ),
                  ),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
