import 'dart:convert';

import 'package:clipit/models/user.model.dart';
import 'package:clipit/utilities/endpoints.dart';
import 'package:clipit/utilities/request.dart';
import 'package:clipit/utilities/shared_widgets.dart';
import 'package:clipit/utilities/utility.dart';
import 'package:dio/dio.dart';

class UserService {
  Future<UserResponseModel?> addUser(UserModel user) async {
    UserResponseModel userResponseModel = UserResponseModel();
    try {
      Dio dio = await Request().getApiClient(true);
      Response response = await dio.post(Endpoints.usersAdd, data: {
        'email': user.email,
        'password': user.password,
      });

      if (Utility.isNotNullEmptyOrFalse(response.data) &&
          response.data['responseCode'] == 200) {
        userResponseModel.accessToken = response.data['user']['accessToken'];
        userResponseModel.user = UserModel.fromJson(response.data['user']);

        Utility.storeCookie('token', userResponseModel.accessToken);
        Utility.storeCookie('email', userResponseModel.user.email);

        return userResponseModel;
      } else if (response.data['responseCode'] == 300) {
        SharedWidgets.failureToast(response.data['message']);
        return null;
      }
    } catch (e) {
      SharedWidgets.somethingWentWrong();
      return null;
    }
    return null;
  }
}
