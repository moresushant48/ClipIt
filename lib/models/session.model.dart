import 'package:clipit/utilities/utility.dart';

class SessionModel {
  late int id;
  late bool enabled;
  late bool isDeleted;
  late String sessionId;
  late int userID;
  late int createdBy;
  late String createdTimestamp;
  late int updatedBy;
  late String updatedTimestamp;

  SessionModel({
    this.id = 0,
    this.enabled = true,
    this.isDeleted = false,
    this.sessionId = "",
    this.userID = 0,
    this.createdBy = 0,
    this.createdTimestamp = "",
    this.updatedBy = 0,
    this.updatedTimestamp = "",
  });

  SessionModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    enabled = json['enabled'];
    isDeleted = json['isDeleted'];
    sessionId = json['sessionId'];
    userID = Utility.isNotNullEmptyOrFalse(json['userID']) ? json['userID'] : 0;
    // createdBy = json['createdBy'];
    // createdTimestamp = json['createdTimestamp'];
    // updatedBy = json['updatedBy'];
    // updatedTimestamp = json['updatedTimestamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    // data['id'] = id;
    data['enabled'] = enabled;
    data['isDeleted'] = isDeleted;
    data['sessionId'] = sessionId;
    data['userID'] = userID;
    // data['createdBy'] = createdBy;
    // data['createdTimestamp'] = createdTimestamp;
    // data['updatedBy'] = updatedBy;
    // data['updatedTimestamp'] = updatedTimestamp;
    return data;
  }
}
