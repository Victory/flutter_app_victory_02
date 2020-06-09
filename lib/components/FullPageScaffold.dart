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

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final loadModel = Provider.of<LoaderModel>(context, listen: true);

    return Container(
      color: theme.primaryColor,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text('Full Page Scaffold'),
          ),
          persistentFooterButtons: [
            IconButton(
              icon: Icon(Icons.assignment_late),
              onPressed: () {
              },
            ),
          ],
          body: Stack(
              children: [
                AnimatedOpacity(
                  curve: Curves.easeOut,
                  opacity: loadModel.loadOpacity,
                  duration: _opacityLoaderDuration,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('Loading....'),
                      /*
                      SpinKitCircle(
                        size: mq.size.shortestSide - 150,
                        color: theme.primaryColor,
                      ),
                       */
                    ],
                  ),
                ),
                AnimatedOpacity(
                  curve: Curves.easeOutCubic,
                  duration: _opacityContentDuration,
                  opacity: loadModel.contentOpacity,
                  child: widget.child,
                ),
              ],
            ),
        ),
      ),
    );
  }
}
