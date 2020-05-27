import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';

class PhysicalStatelessWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              TextWrapper(
                child: Text('Top Left'),
              ),
              TextWrapper(
                child: Text('Top Right'),
              ),
            ],
          ),
          DraggableCard(
            child: FlutterLogo(
              size: 123,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              TextWrapper(
                child: Text('Bottom Left'),
              ),
              TextWrapper(
                child: Text('Bottom Right'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class TextWrapper extends StatelessWidget {
  final Widget child;

  TextWrapper({this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.yellow,
        ),
      ),
      child: this.child,
    );
  }
}

class DraggableCard extends StatefulWidget {
  final Widget child;

  const DraggableCard({Key key, this.child}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _DraggableCardState();
  }
}

class _DraggableCardState extends State<DraggableCard>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Alignment _dragAlignment = Alignment.center;
  Animation<Alignment> _animation;
  Size size;

  Alignment _align(Offset position) {

    var x = 2 * position.dx / size.width - 1.0;
    var y = 2 * position.dy / size.height - 1.0;

    if (x > 1.0) {
      x = 1.0;
    } else if (x < -1.0) {
      x = -1.0;
    }

    if (y > 1.0) {
      y = 1.0;
    } else if (y < -1.0) {
      y = -1.0;
    }

    var alignment = Alignment(x, y);
    print('---------------------------------');
    print('local....: ${position.dx} x ${position.dy}');
    print('size.....: ${size.width} x ${size.height}');
    print('align....: $alignment');

    return alignment;
  }

  @override
  Widget build(BuildContext context) {

    return new GestureDetector(
      onPanDown: (details) {
        _introAnimation(
          _align(details.localPosition),
        );

      },
      onPanUpdate: (details) {
        setState(() {
          _dragAlignment = _align(details.localPosition);
        });
      },
      onPanEnd: (details) {
        _runAnimation(details.velocity.pixelsPerSecond, size);
      },
      child: Container(
        height: 450,
        child: LayoutBuilder(
          builder: (context, constraints) {
            size = Size(constraints.maxWidth, constraints.maxHeight);

            return Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.orange,
                ),
              ),
              child: Align(
                alignment: _dragAlignment,
                child: Card(
                  child: widget.child,
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _introAnimation(Alignment end) {
    _animation = _animationController.drive(AlignmentTween(
      begin: Alignment.center,
      end: end,
    ));
    _animationController.reset();
    _animationController.forward();

    const spring = SpringDescription(
      mass: 30,
      stiffness: 1,
      damping: 1,
    );

    final simulation = SpringSimulation(spring, 0, 1, 1);
    _animationController.animateWith(simulation);
  }

  void _runAnimation(Offset pixelsPerSecond, Size size) {
    _animation = _animationController.drive(AlignmentTween(
      begin: _dragAlignment,
      end: Alignment.center,
    ));
    _animationController.reset();
    _animationController.forward();

    // Calculate the velocity relative to the unit interval, [0,1],
    // used by the animation controller.
    final unitsPerSecondX = pixelsPerSecond.dx / size.width;
    final unitsPerSecondY = pixelsPerSecond.dy / size.height;
    final unitsPerSecond = Offset(unitsPerSecondX, unitsPerSecondY);
    final unitVelocity = unitsPerSecond.distance;

    const spring = SpringDescription(
      mass: 30,
      stiffness: 1,
      damping: 1,
    );

    final simulation = SpringSimulation(spring, 0, 1, -unitVelocity);
    _animationController.animateWith(simulation);
  }

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 1));

    _animationController.addListener(() {
      setState(() {
        _dragAlignment = _animation.value;
      });
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
