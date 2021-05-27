import 'package:flutter/material.dart';
import 'package:flutter_chat/routes/routes.dart';
import 'package:flutter_chat/services/auth_service.dart';
import 'package:provider/provider.dart';

void main() => runApp(Myapp());

class Myapp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AuthService(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Chat App',
        initialRoute: "loadin",
        routes: appRoutes,
      ),
    );
  }
}
