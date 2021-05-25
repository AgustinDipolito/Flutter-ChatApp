import 'package:flutter/material.dart';
import 'package:flutter_chat/routes/routes.dart';

void main() => runApp(Myapp());

class Myapp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Chat App',
      initialRoute: "chat",
      routes: appRoutes,
    );
  }
}
