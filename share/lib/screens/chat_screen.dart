import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:uuid/uuid.dart';

class ChatScreen extends StatefulWidget {
  final String name, id;

  ChatScreen(this.name, this.id);
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _chats = FirebaseFirestore.instance.collection('chats');

  final _formKey = GlobalKey<FormState>();
  final _messageController = TextEditingController();

  validateMessage() {
    return _formKey.currentState.validate();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.name);
    print(widget.id);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(66, 39, 90, 1),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              '${widget.name}',
              style: TextStyle(
                fontFamily: 'Pacifico',
              ),
            ),
            Text(
              '•',
              style: TextStyle(
                color: Colors.green,
                fontSize: 50,
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
                child: StreamBuilder<QuerySnapshot>(
              stream: _chats.orderBy('timestamp', descending: true).snapshots(),
              builder: (ctx, snap) {
                if (!snap.hasData) {
                  return Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(
                        Color.fromRGBO(66, 39, 90, 1),
                      ),
                    ),
                  );
                }
                print('Data came');

                return ListView.separated(
                  reverse: true,
                  separatorBuilder: (ctx, index) {
                    return SizedBox(
                      height: 10,
                    );
                  },
                  itemBuilder: (ctx, index) {
                    if (widget.id == snap.data.docs[index].get('id')) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  '${snap.data.docs[index].get('name')}',
                                  style: TextStyle(
                                    fontFamily: 'Pacifico',
                                    color: Colors.grey,
                                  ),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                CircleAvatar(
                                  radius: 12,
                                  backgroundColor: Colors.grey,
                                  child: Center(
                                    child: Text(
                                      '${snap.data.docs[index].get('name')[0].toUpperCase()}',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontFamily: 'Pacifico',
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          BubbleNormal(
                            text: '${snap.data.docs[index].get('message')}',
                            isSender: true,
                            color: Colors.grey[200],
                            tail: true,
                          ),
                        ],
                      );
                    }
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              CircleAvatar(
                                radius: 12,
                                backgroundColor: Colors.black,
                                child: Center(
                                  child: Text(
                                    '${snap.data.docs[index].get('name')[0].toUpperCase()}',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontFamily: 'Pacifico',
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                '${snap.data.docs[index].get('name')}',
                                style: TextStyle(
                                  fontFamily: 'Pacifico',
                                ),
                              ),
                            ],
                          ),
                        ),
                        BubbleNormal(
                          text: '${snap.data.docs[index].get('message')}',
                          isSender: false,
                          color: Colors.grey[300],
                          tail: true,
                        ),
                      ],
                    );
                  },
                  itemCount: snap.data.docs.length,
                );
              },
            )),
          ),
          Container(
            padding: EdgeInsets.all(5),
            child: Form(
              key: _formKey,
              child: TextFormField(
                controller: _messageController,
                validator: (val) {
                  if (val.trim().length == 0) {
                    return 'Enter message';
                  }
                  return null;
                },
                cursorColor: Colors.black,
                autocorrect: true,
                style: TextStyle(
                  fontFamily: 'Pacifico',
                ),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: BorderSide(
                      color: Color.fromRGBO(66, 39, 90, 1),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: BorderSide(
                      color: Color.fromRGBO(66, 39, 90, 1),
                    ),
                  ),
                  hintText: 'message...',
                  focusColor: Color.fromRGBO(115, 75, 109, 1),
                  suffix: GestureDetector(
                    onTap: () async {
                      if (validateMessage()) {
                        await _chats.doc().set({
                          'timestamp': DateTime.now(),
                          'message': _messageController.text.trim(),
                          'id': widget.id,
                          'name': widget.name,
                        });
                        _messageController.text = "";
                      }
                    },
                    child: Icon(
                      Icons.send_rounded,
                      color: Color.fromRGBO(115, 75, 109, 1),
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
