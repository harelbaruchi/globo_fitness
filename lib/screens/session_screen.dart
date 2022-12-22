import 'package:flutter/material.dart';
import '../data/sp_helper.dart';
import '../data/session.dart';

class SessionScreen extends StatefulWidget {
  const SessionScreen({super.key});

  @override
  State<SessionScreen> createState() => _SessionScreenState();
}

class _SessionScreenState extends State<SessionScreen> {
  List<Session> sessions=[];
  final TextEditingController txtDescription = TextEditingController();
  final TextEditingController txtDuration = TextEditingController();
  final SPHelper sp_helper= SPHelper();

  @override
  void initState() {
    sp_helper.init().then((value) {
      updateScreen();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Training Sessions'),
      ),
      body: ListView(
        children: getContent()
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (() {
          showSessionDialog(context);
        }),
      ),
    );
  }

  Future<dynamic> showSessionDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Insert Training Session'),
            content: SingleChildScrollView(
              child: Column(children: [
                TextField(
                  controller: txtDescription,
                  decoration: InputDecoration(hintText: 'Description'),
                ),
                TextField(
                  controller: txtDuration,
                  decoration: InputDecoration(hintText: 'Duration'),
                )
              ]),
            ),
          actions: [
            TextButton(
              child: Text('cancel'),
              onPressed: (() {
                Navigator.pop(context);
                txtDuration.text='';
                txtDescription.text='';
              }),
            ),
            ElevatedButton(
              child: Text('save'),
              onPressed: saveSession,
            )
          ],);
        });
  }
  Future saveSession() async {
    DateTime now = DateTime.now();
    String today = '${now.year}-${now.month}-${now.day}';
    Session newSession = Session(1, today,txtDescription.text, int.tryParse(txtDuration.text)?? 0);
    sp_helper.writeSession(newSession);
    txtDescription.text='';
    txtDuration.text='';
    Navigator.pop(context);
  }

  List<Widget> getContent() {
    List<Widget> tiles=[];
    sessions.forEach((session) {
      tiles.add(ListTile(
        title: Text(session.description),
        subtitle: Text('${session.date} -duration ${session.duration} min '), 
      ));
    });
    return tiles; 
  }

  void updateScreen(){
    sessions=sp_helper.getSession();
    setState(() {
      
    });
      }

  
}
