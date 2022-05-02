class Message {
  int? id;
  String? message;
  String? url;
  String? createAt;
  String? updateAt;
  String? deleteAt;
  String? personR;
  Map? typeMsg;
  Map? chat;
  Map? person;
  Message(
      {this.id,
      this.message,
      this.url,
      this.createAt,
      this.updateAt,
      this.deleteAt,
      this.personR,
      this.typeMsg,
      this.chat,
      this.person});

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
        id: json['id'],
        message: json['message'],
        url: json['url'],
        createAt: json['createAt'],
        updateAt: json['updateAt'],
        deleteAt: json['deleteAt'],
        typeMsg: json['typeMsg'] as Map,
        chat: json['chat'] as Map,
        person: json['person'] as Map);
  }
}
