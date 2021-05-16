import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatPage extends StatefulWidget {
  ChatPage(this._userName);
  final String _userName;

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('チャットページ'),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          children: <Widget>[
            Flexible(
              child: StreamBuilder<QuerySnapshot>(
                // documentに更新があったときにリアルタイムで画面の描写を更新
                stream: Firestore.instance
                    .collection("chat_room")
                    .orderBy("created_at", descending: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) return Container();
                  return ListView.builder(
                    padding: EdgeInsets.all(8.0),
                    reverse: true,
                    itemBuilder: (_, int index) {
                      DocumentSnapshot document =
                          snapshot.data.documents[index];
                      bool isOwnMessage = false;

                      if (document['user_name'] == widget._userName) {
                        isOwnMessage = true;
                      }

                      return isOwnMessage
                          ? _ownMessage(
                              document['message'], document['user_name'])
                          : _message(
                              document['message'], document['user_name']);
                    },
                    itemCount: snapshot.data.documents.length,
                  );
                },
              ),
            ),
            Divider(
              height: 1.0,
            ),
            Container(
              margin: EdgeInsets.only(bottom: 20.0, right: 10, left: 10),
              child: Row(
                children: <Widget>[
                  Flexible(
                      child: TextField(
                    controller: _controller,
                    onSubmitted: _handleSubmit,
                    decoration: InputDecoration.collapsed(hintText: "メッセージの送信"),
                  )),
                  Container(
                    child: IconButton(
                      icon: Icon(
                        Icons.send,
                        color: Colors.blue,
                      ),
                      onPressed: () {
                        _handleSubmit(_controller.text);
                      },
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _message(String message, String userName) {
    return Row(
      children: <Widget>[
        Icon(Icons.person),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 10.0,
            ),
            Text(userName),
            Text(message),
          ],
        )
      ],
    );
  }

  Widget _ownMessage(String message, String userName) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 10.0,
            ),
            Text(userName),
            Text(message),
          ],
        ),
        Icon(Icons.person)
      ],
    );
  }

  _handleSubmit(String message) {
    _controller.text = "";
    var db = Firestore.instance;
    db.collection("chat_room").add({
      "user_name": widget._userName,
      "message": message,
      "created_at": DateTime.now(),
    }).then((value) {
      print("成功！！");
    }).catchError((e) {
      print(e);
    });
  }
}
