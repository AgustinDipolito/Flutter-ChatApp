import 'package:flutter/material.dart';
import 'package:flutter_chat/widgets/chat_messages.dart';

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with TickerProviderStateMixin {
  final _textController = new TextEditingController();
  final _focusNode = new FocusNode();
  bool _escribiendo = false;
  List<ChatMessage> _mensajes = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: <Widget>[
            CircleAvatar(
              child: Text(
                "te",
                style: TextStyle(
                  fontSize: 12,
                ),
              ),
              backgroundColor: Colors.indigo[50],
            ),
            SizedBox(
              height: 3,
            ),
            Text(
              "",
              style: TextStyle(color: Colors.black, fontSize: 12),
            )
          ],
        ),
        centerTitle: true,
        elevation: 1,
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Flexible(
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: _mensajes.length,
                itemBuilder: (_, i) => _mensajes[i],
                reverse: true,
              ),
            ),
            Divider(
              height: 1,
            ),
            Container(
              color: Colors.white,
              height: 50,
              child: _inputChat(),
            )
          ],
        ),
      ),
    );
  }

  Widget _inputChat() {
    return SafeArea(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          children: <Widget>[
            Flexible(
              child: TextField(
                controller: _textController,
                onSubmitted: _handleSubmit,
                onChanged: (String texto) {
                  setState(() {
                    if (texto.length > 0) {
                      _escribiendo = true;
                    } else {
                      _escribiendo = false;
                    }
                  });
                },
                decoration:
                    InputDecoration.collapsed(hintText: "Write a message"),
                focusNode: _focusNode,
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 4),
              child: IconTheme(
                data: IconThemeData(
                  color: Colors.blue[700],
                ),
                child: IconButton(
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  icon: Icon(Icons.send),
                  onPressed:
                      _escribiendo ? _handleSubmit(_textController.text) : null,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  _handleSubmit(String text) {
    if (text.length == 0) return;
    print(text);
    _textController.clear();
    _focusNode.requestFocus();

    final newMessage = new ChatMessage(
      uid: "123",
      texto: text,
      animationController: AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 400),
      ),
    );

    _mensajes.insert(0, newMessage);
    newMessage.animationController.forward();

    setState(() {
      _escribiendo = false;
    });
  }

  @override
  void dispose() {
    for (ChatMessage message in _mensajes) {
      message.animationController.dispose();
    }
    super.dispose();
  }
}
