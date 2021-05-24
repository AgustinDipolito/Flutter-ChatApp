import 'package:flutter/material.dart';
import 'package:flutter_chat/pages/ChatPage.dart';
import 'package:flutter_chat/pages/LoadingPage.dart';
import 'package:flutter_chat/pages/LoginPage.dart';
import 'package:flutter_chat/pages/RegisterPage.dart';
import 'package:flutter_chat/pages/UsuariosPage.dart';

final Map<String, Widget Function(BuildContext)> appRoutes = {
  "usuarios": (_) => UsuariosPage(),
  "chat": (_) => ChatPage(),
  "login": (_) => LoginPage(),
  "loading": (_) => LoadingPage(),
  "register": (_) => RegisterPage(),
};
