import 'package:flutter/material.dart';

mostrarAlerta(BuildContext context, String titulo, String subtitulo) {
  showDialog(
    context: context,
    builder: (_) => AlertDialog(
      title: Text(titulo),
      content: Text(subtitulo),
      actions: <Widget>[
        MaterialButton(
          child: Text("close"),
          elevation: 5,
          textColor: Colors.blue[900],
          onPressed: () => Navigator.pop(context),
        ),
      ],
    ),
  );
}
