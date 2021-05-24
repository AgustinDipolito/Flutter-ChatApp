import 'package:flutter/material.dart';

class BotonLogin extends StatelessWidget {
  final String text;
  final Function onPressed;
  const BotonLogin({
    Key key,
    @required this.text,
    @required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: Colors.blue[700],
        shape: StadiumBorder(),
      ),
      child: Container(
        width: double.infinity,
        height: 55,
        child: Center(
          child: Text(
            this.text,
            style: TextStyle(
              color: Colors.white,
              fontSize: 17,
            ),
          ),
        ),
      ),
      onPressed: this.onPressed,
    );
  }
}
