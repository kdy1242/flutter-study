
class Group {
  String admin;
  String groupId;
  String groupName;
  List members;
  String? recentMessage;
  String? recentMessageSender;
  String? recentMessageTime;

  Group({
    required this.admin,
    required this.groupId,
    required this.groupName,
    required this.members,
    this.recentMessage,
    this.recentMessageSender,
    this.recentMessageTime,
  });

  Map<String, dynamic> toMap() {
    return {
      'admin': this.admin,
      'groupId': this.groupId,
      'groupName': this.groupName,
      'members': this.members,
      'recentMessage': this.recentMessage,
      'recentMessageSender': this.recentMessageSender,
      'recentMessageTime': this.recentMessageTime,
    };
  }

  factory Group.fromMap(Map<String, dynamic> map) {
    return Group(
      admin: map['admin'] as String,
      groupId: map['groupId'] as String,
      groupName: map['groupName'] as String,
      members: map['members'] as List,
      recentMessage: map['recentMessage'] as String?,
      recentMessageSender: map['recentMessageSender'] as String?,
      recentMessageTime: map['recentMessageTime'] as String?,
    );
  }
}
