import 'package:flutter/material.dart';

class Janeinfragewidget extends StatefulWidget {
  Map<String, bool> booleanfactors;
  String keyentry;
  String text;
  Janeinfragewidget(this.booleanfactors, this.keyentry, this.text, {Key key})
      : super(key: key);

  @override
  _JaneinfragewidgetState createState() => _JaneinfragewidgetState();
}

class _JaneinfragewidgetState extends State<Janeinfragewidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(widget.text),
          ToggleButtons(
            borderColor: Colors.black,
            borderWidth: 2,
            selectedBorderColor: Colors.black,
            borderRadius: BorderRadius.circular(0),
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Ja',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Nein',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
            onPressed: (int index) {
              setState(() {
                widget.booleanfactors[widget.keyentry] =
                    index == 0 ? true : false;
              });
            },
            isSelected: [
              widget.booleanfactors[widget.keyentry],
              !widget.booleanfactors[widget.keyentry]
            ],
          ),
        ],
      ),
    );
  }
}
