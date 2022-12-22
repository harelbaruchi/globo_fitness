import 'package:shared_preferences/shared_preferences.dart';
import 'session.dart';
import 'dart:convert';

class SPHelper {
  static late SharedPreferences prefs;

  Future init() async {
    prefs = await SharedPreferences.getInstance();
  }

  Future writeSession(Session session) async {
    prefs.setString(session.id.toString(), json.encode(session.toJson()));
  }

  List<Session> getSession(){
    List<Session> sessions=[];
    Set<String> keys=prefs.getKeys();
    keys.forEach((String key) {
      Session session=
       Session.fromJson(json.decode(prefs.getString(key)??''));
       sessions.add(session);
    });
    return sessions;
  }
}
