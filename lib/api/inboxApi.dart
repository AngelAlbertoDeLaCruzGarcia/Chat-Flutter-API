import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:api_bim/data/inbox.dart';
import 'package:api_bim/utils/constants.dart';
import 'package:api_bim/data/message.dart';

class InboxApi {
  var url;
  var response;
  List<dynamic> body = [];
  List<dynamic> body2 = [];
  List<Inbox> inbox = [];
  List<Inbox> inbox2 = [];
  List<Message> msg = [];
  int chat = 0;
  Future<List<Message>> getInbox(int person) async {
    msg.clear();
    url = Uri.parse('${API_URL}/inboxs/person?person=${person}');
    response = await http.get(url);
    if (response.statusCode == 200) {
      body = jsonDecode(response.body);
      inbox = body.map((dynamic item) => Inbox.fromJson(item)).toList();
      for (var i = 0; i < inbox.length; i++) {
        url = Uri.parse('${API_URL}/msgs/inboxs?chat=${inbox[i].chat?['id']}');
        response = await http.get(url);
        if (response.statusCode == 200) {
          body = jsonDecode(response.body);
          msg.add(Message.fromJson(body[0]));
          if (inbox[i].chat?['name'] == null) {
            url = Uri.parse(
                '${API_URL}/inboxs/name?chat=${inbox[i].chat?['id']}&person=${person}');
            response = await http.get(url);
            body2 = jsonDecode(response.body);
            inbox2 = body2.map((dynamic item) => Inbox.fromJson(item)).toList();
            msg[i].personR =
                '${inbox2[0].person?['name']} ${inbox2[0].person?['firstname']}';
          }
        }
      }
      msg.sort((a, b) {
        //sorting in descending order
        return DateTime.parse(b.createAt.toString())
            .compareTo(DateTime.parse(a.createAt.toString()));
      });
      return msg;
    } else {
      throw Exception('errror');
    }
  }
}
