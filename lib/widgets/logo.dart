import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  final String titulo;

  const Logo({
    Key key,
    this.titulo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            Icon(
              Icons.mail_outline_rounded,
              size: 100,
              color: Colors.blue[700],
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              this.titulo,
              style: TextStyle(
                  color: Colors.blue[700],
                  fontSize: 25,
                  fontWeight: FontWeight.w800),
            )
          ],
        ),
      ),
    );
  }
}
