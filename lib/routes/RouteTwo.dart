import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RouteTwo extends StatefulWidget {
  @override
  _RouteTwoState createState() => _RouteTwoState();
}

class _RouteTwoState extends State<RouteTwo> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TextFormField(
                autofocus: true,
                decoration: InputDecoration(labelText: 'What activity?'),
                validator: (value) {
                  return value.contains('fish') ? null : 'I Was expecting fish';
                },
              ),
              DropdownButtonFormField(
                items: [
                  DropdownMenuItem(
                    child: Text('food'),
                  ),
                  DropdownMenuItem(
                    child: Text('fruit'),
                  ),
                  DropdownMenuItem(
                    child: Text('Loops'),
                  ),
                ],
                onChanged: (value) {
                  print('changed dropdown');
                },

              ),
              ButtonBar(
                children: [
                  RaisedButton(
                    child: Text('Submit'),
                    onPressed: () {
                      FocusScope.of(context).unfocus();
                      SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);

                      if(_formKey.currentState.validate()) {
                        print(_formKey.currentState);
                      } else {
                        print('you did no win at putting in data');
                      }
                    },
                  )
                ],
              )
            ],
          ),
        )
      ),
    );
  }
}

