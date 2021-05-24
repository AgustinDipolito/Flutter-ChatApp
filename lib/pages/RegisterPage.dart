import 'package:flutter/material.dart';
import 'package:flutter_chat/widgets/botonLogin.dart';
import 'package:flutter_chat/widgets/custom_input.dart';
import 'package:flutter_chat/widgets/logo.dart';
import 'package:flutter_chat/widgets/labels.dart';

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
            textController: passCtrl,
          ),
          CustomInput(
            icon: Icons.lock,
            placeHolder: "Repeat password",
            isPassword: true,
            textController: repPassCtrl,
          ),
          BotonLogin(
            text: "Sign up",
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
