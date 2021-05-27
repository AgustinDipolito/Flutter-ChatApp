import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat/global/environment.dart';
import 'package:flutter_chat/models/login_response.dart';
import 'package:flutter_chat/models/usuario.dart';
import 'package:http/http.dart' as http;

class AuthService with ChangeNotifier {
  final _storage = new FlutterSecureStorage();

  Usuario usuario;
  bool _autenticando = false;

  bool get autenticando => this._autenticando;

  set autenticando(bool valor) {
    this._autenticando = valor;
  }

  //getters del token estaticos
  static Future<String> getToken() async {
    final _storage = new FlutterSecureStorage();
    final token = await _storage.read(key: "token");
    return token;
  }

  static Future<void> deleteToken() async {
    final _storage = new FlutterSecureStorage();
    await _storage.delete(key: "token");
  }

//login
  Future<bool> login(String email, String password) async {
    this.autenticando = true;
    final data = {
      "email": email,
      "password": password,
    };

    final resp = await http.post(
      Uri.parse("${Environment.apiUrl}/login"),
      body: jsonEncode(data),
      headers: {"Content-Type": "application/json"},
    );

    print(resp.body);
    this.autenticando = false;

    if (resp.statusCode == 200) {
      final loginResponse = loginResponseFromJson(resp.body);
      this.usuario = loginResponse.usuario;

      await this._guardarToken(loginResponse.token);
      return true;
    } else {
      return false;
    }
  }

//REGISTRO
  Future register(String nombre, String email, String password) async {
    this.autenticando = true;
    final data = {
      "nombre": nombre,
      "email": email,
      "password": password,
    };
    final resp = await http.post(
      Uri.parse("${Environment.apiUrl}/login/new"),
      body: jsonEncode(data),
      headers: {"Content-Type": "application/json"},
    );

    print(resp.body);
    this.autenticando = false;

    if (resp.statusCode == 200) {
      final loginResponse = loginResponseFromJson(resp.body);
      this.usuario = loginResponse.usuario;

      await this._guardarToken(loginResponse.token);
      return true;
    } else {
      final respBody = jsonDecode(resp.body);
      return respBody["msg"];
    }
  }

//is logged
  Future<bool> isLoggedIn() async {
    final token = await this._storage.read(key: "token");

    final resp = await http.get(
      Uri.parse("${Environment.apiUrl}/login/renew"),
      headers: {"Content-Type": "application/json", "x-token": token},
    );

    print(resp.body);
    this.autenticando = false;

    if (resp.statusCode == 200) {
      final loginResponse = loginResponseFromJson(resp.body);
      this.usuario = loginResponse.usuario;

      await this._guardarToken(loginResponse.token);
      return true;
    } else {
      this.logOut();
      return false;
    }
  }

  Future _guardarToken(String token) async {
    return await _storage.write(
      key: "token",
      value: token,
    );
  }

  Future logOut() async {
    await _storage.delete(
      key: "token",
    );
  }
}
