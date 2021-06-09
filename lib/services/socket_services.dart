import 'package:flutter_chat/global/environment.dart';
import 'package:flutter_chat/services/auth_service.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import 'package:flutter/material.dart';

enum ServerStatus { Online, Offline, Connecting }

class SocketServices with ChangeNotifier {
  ServerStatus _serverStatus = ServerStatus.Connecting;
  ServerStatus get serverStatus => this._serverStatus;

  IO.Socket _socket;
  IO.Socket get socket => this._socket;

  Function get emit => this._socket.emit;

  void connect() async {
    final token = await AuthService.getToken();

    this._socket = IO.io(
        Environment.socketUrl,
        IO.OptionBuilder()
            .setTransports(["websocket"])
            .enableForceNew()
            .enableAutoConnect()
            .setExtraHeaders({
              "foo": "bar",
              "x-token": token,
            })
            .build());
    this._socket.connect();

    this._socket.onConnect(
      (_) {
        this._serverStatus = ServerStatus.Online;
        print("$_serverStatus");
        notifyListeners();
      },
    );

    this._socket.onDisconnect(
      (_) {
        this._serverStatus = ServerStatus.Offline;
        print("$_serverStatus");
        notifyListeners();
      },
    );
    print("$_serverStatus");
  }

  void disconnect() {
    this.socket.disconnect();
  }
}
