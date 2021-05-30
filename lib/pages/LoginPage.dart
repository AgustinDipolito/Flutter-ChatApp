import 'package:flutter/material.dart';
import 'package:flutter_chat/helpers/mostrar_alerta.dart';
import 'package:flutter_chat/services/auth_service.dart';
import 'package:flutter_chat/services/socket_services.dart';
import 'package:flutter_chat/widgets/botonLogin.dart';
import 'package:flutter_chat/widgets/custom_input.dart';
import 'package:flutter_chat/widgets/logo.dart';
import 'package:flutter_chat/widgets/labels.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo[50],
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.9,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Logo(
                  titulo: "Log in",
                ),
                _Form(),
                Labels(
                  ruta: "register",
                  titulo: "First time?",
                  subTitulo: "Register now!",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Form extends StatefulWidget {
  @override
  __FormState createState() => __FormState();
}

class __FormState extends State<_Form> {
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);
    final socketService = Provider.of<SocketServices>(context);

    return Container(
      margin: EdgeInsets.only(top: 40),
      padding: EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        children: <Widget>[
          CustomInput(
            icon: Icons.mail_rounded,
            placeHolder: "Email",
            isPassword: false,
            keyboardType: TextInputType.emailAddress,
            textController: emailCtrl,
          ),
          CustomInput(
            icon: Icons.lock,
            placeHolder: "Password",
            isPassword: true,
            textController: passCtrl,
          ),
          BotonLogin(
            text: "Login",
            onPressed: authService.autenticando
                ? null
                : () async {
                    FocusScope.of(context).unfocus();
                    final loginOk = await authService.login(
                      emailCtrl.text.trim(),
                      passCtrl.text.trim(),
                    );

                    if (loginOk) {
                      socketService.connect();
                      Navigator.pushReplacementNamed(context, "usuarios");
                    } else {
                      mostrarAlerta(
                        context,
                        "Login Fail",
                        " Error on email or password",
                      );
                    }
                  },
          ),
        ],
      ),
    );
  }
}
