import 'package:flutter/material.dart';

class Labels extends StatelessWidget {
  final String ruta;
  final String titulo;
  final String subTitulo;

  const Labels({
    Key key,
    @required this.ruta,
    @required this.titulo,
    @required this.subTitulo,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Text(
            this.titulo,
          ),
          SizedBox(
            height: 1,
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushReplacementNamed(context, ruta);
            },
            child: Text(
              this.subTitulo,
              style: TextStyle(
                color: Colors.blue[700],
                fontWeight: FontWeight.w300,
                fontSize: 15,
              ),
            ),
          ),
          SizedBox(
            height: 5,
          ),
        ],
      ),
    );
  }
}
