import 'package:flutter/material.dart';

class ChatMessage extends StatelessWidget {
  final String texto;
  final String uid;

  const ChatMessage({
    Key key,
    this.texto,
    this.uid,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: this.uid == "123" ? _myMessage() : _notMyMessage(),
    );
  }

  Widget _myMessage() {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        padding: EdgeInsets.all(8),
        margin: EdgeInsets.only(
          bottom: 5,
          left: 50,
          right: 7,
        ),
        child: Text(this.texto),
        decoration: BoxDecoration(
          color: Colors.indigo[50],
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }

  Widget _notMyMessage() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.all(8),
        margin: EdgeInsets.only(
          bottom: 5,
          left: 7,
          right: 50,
        ),
        child: Text(this.texto),
        decoration: BoxDecoration(
          color: Colors.indigo[100],
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}
