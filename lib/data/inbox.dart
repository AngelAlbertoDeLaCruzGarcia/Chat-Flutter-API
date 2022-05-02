class Inbox {
  int? id;
  String? createAt;
  String? updateAt;
  String? deleteAt;
  Map? chat;
  Map? person;
  Inbox(
      {this.id,
      this.createAt,
      this.updateAt,
      this.deleteAt,
      this.chat,
      this.person});

  factory Inbox.fromJson(Map<String, dynamic> json) {
    return Inbox(
        id: json['id'],
        createAt: json['createAt'],
        updateAt: json['updateAt'],
        deleteAt: json['deleteAt'],
        chat: json['chat'] as Map,
        person: json['person'] as Map);
  }
}
