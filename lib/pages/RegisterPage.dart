import 'package:flutter/material.dart';
import 'package:flutter_chat/helpers/mostrar_alerta.dart';
import 'package:flutter_chat/services/auth_service.dart';
import 'package:flutter_chat/services/socket_services.dart';
import 'package:flutter_chat/widgets/botonLogin.dart';
import 'package:flutter_chat/widgets/custom_input.dart';
import 'package:flutter_chat/widgets/logo.dart';
import 'package:flutter_chat/widgets/labels.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatelessWidget {
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
                  titulo: "Sign up",
                ),
                _Form(),
                Labels(
                  ruta: "login",
                  titulo: "Already have one?",
                  subTitulo: "Log in!",
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
  final nameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();
  final repPassCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);

    return Container(
      margin: EdgeInsets.only(top: 40),
      padding: EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        children: <Widget>[
          CustomInput(
            icon: Icons.person_pin,
            placeHolder: "Name",
            isPassword: false,
            keyboardType: TextInputType.text,
            textController: nameCtrl,
          ),
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
            keyboardType: TextInputType.visiblePassword,
            textController: passCtrl,
          ),
          CustomInput(
            icon: Icons.lock,
            placeHolder: "Repeat password",
            isPassword: true,
            keyboardType: TextInputType.visiblePassword,
            textController: repPassCtrl,
          ),
          BotonLogin(
            text: "Sign up",
            onPressed: passCtrl.text == repPassCtrl.text
                ? authService.autenticando
                    ? null
                    : () async {
                        final regristroOk = await authService.register(
                          nameCtrl.text,
                          emailCtrl.text,
                          repPassCtrl.text,
                        );
                        if (regristroOk == true) {
                          final socketService = Provider.of<SocketServices>(
                            context,
                            listen: false,
                          );
                          socketService.connect();
                          Navigator.pushReplacementNamed(context, "usuarios");
                        } else {
                          mostrarAlerta(
                              context, "Register failed", regristroOk);
                        }
                      }
                : mostrarAlerta(
                    context, "Register failed", "Passwords does not match"),
          ),
        ],
      ),
    );
  }
}
