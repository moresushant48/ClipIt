class UserModel {
  late int id;
  late bool enabled;
  late bool isDeleted;
  late String email;
  late String password;
  late int createdBy;
  late String createdTimestamp;
  late int updatedBy;
  late String updatedTimestamp;

  UserModel({
    this.id = 0,
    this.enabled = true,
    this.isDeleted = false,
    this.email = '',
    this.password = '',
    this.createdBy = 0,
    this.createdTimestamp = '',
    this.updatedBy = 0,
    this.updatedTimestamp = '',
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    enabled = json['enabled'];
    isDeleted = json['isDeleted'];
    email = json['email'];
    password = json['password'];
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
    data['email'] = email;
    data['password'] = password;
    // data['createdBy'] = createdBy;
    // data['createdTimestamp'] = createdTimestamp;
    // data['updatedBy'] = updatedBy;
    // data['updatedTimestamp'] = updatedTimestamp;
    return data;
  }
}

class UserResponseModel {
  String accessToken = '';
  UserModel user = UserModel();
}
