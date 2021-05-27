import 'package:flutter/material.dart';
import 'package:flutter_chat/models/usuario.dart';
import 'package:flutter_chat/services/auth_service.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class UsuariosPage extends StatefulWidget {
  @override
  _UsuariosPageState createState() => _UsuariosPageState();
}

class _UsuariosPageState extends State<UsuariosPage> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  final usuarios = [
    Usuario(nombre: "cr1", email: "cr7gmail.com", uid: "1", online: true),
    Usuario(nombre: "cr6", email: "cr6gmail.com", uid: "6", online: true),
    Usuario(nombre: "cr8", email: "cr8gmail.com", uid: "8", online: false),
  ];

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final usuario = authService.usuario;
    return Scaffold(
        appBar: AppBar(
          title: Text(
            usuario.nombre,
          ),
          elevation: 1,
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(
              Icons.exit_to_app,
              color: Colors.blue[700],
            ),
            onPressed: () {
              Navigator.pushReplacementNamed(context, "login");
              AuthService.deleteToken();
            },
          ),
          actions: <Widget>[
            Container(
              margin: EdgeInsets.only(right: 10),
              child: Icon(Icons.check_circle),
              color: Colors.blue[700],
              //child: Icon(Icons.offline_bolt),color: Colors.red[700],
            ),
          ],
        ),
        body: SmartRefresher(
            controller: _refreshController,
            enablePullDown: true,
            onRefresh: _cargarUsuarios,
            header: WaterDropHeader(
              complete: Icon(
                Icons.check,
                color: Colors.blue,
              ),
              waterDropColor: Colors.blue,
            ),
            child: _listViewUsuarios()));
  }

  ListView _listViewUsuarios() {
    return ListView.separated(
      itemBuilder: (_, i) => _usuarioListTile(usuarios[i]),
      separatorBuilder: (_, i) => Divider(),
      itemCount: usuarios.length,
    );
  }

  ListTile _usuarioListTile(Usuario usuario) {
    return ListTile(
      title: Text(usuario.nombre),
      subtitle: Text(usuario.email),
      leading: CircleAvatar(
        backgroundColor: Colors.indigo[50],
        child: Text(
          usuario.nombre.substring(0, 2),
        ),
      ),
      trailing: Container(
        height: 10,
        width: 10,
        decoration: BoxDecoration(
          color: usuario.online ? Colors.green : Colors.red,
          borderRadius: BorderRadius.circular(100),
        ),
      ),
    );
  }

  _cargarUsuarios() async {
    await Future.delayed(Duration(milliseconds: 1000));
    _refreshController.refreshCompleted();
  }
}
