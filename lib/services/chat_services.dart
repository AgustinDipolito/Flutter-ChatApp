import 'package:flutter/material.dart';
import 'package:flutter_chat/global/environment.dart';
import 'package:flutter_chat/models/mensajes_response.dart';
import 'package:flutter_chat/models/usuario.dart';
import 'package:flutter_chat/services/auth_service.dart';
import 'package:http/http.dart' as http;

class ChatService with ChangeNotifier {
  Usuario usuarioPara;

  Future<List<Msg>> getChat(String usuarioId) async {
    final resp = await http.get(
      "${Environment.apiUrl}/mensajes/$usuarioId",
      headers: {
        "Content-Type": "application-json",
        "x-token": await AuthService.getToken()
      },
    );

    final mensajesResp = mensajesResponseFromJson(resp.body);
    return mensajesResp.msg;
  }
}
