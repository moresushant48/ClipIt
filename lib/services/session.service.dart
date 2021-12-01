import 'package:clipit/models/session.model.dart';
import 'package:clipit/utilities/endpoints.dart';
import 'package:clipit/utilities/request.dart';
import 'package:clipit/utilities/shared_widgets.dart';
import 'package:clipit/utilities/utility.dart';
import 'package:dio/dio.dart';

class SessionService {
  Future<SessionModel?> getNewSession() async {
    try {
      Dio dio = await Request().getApiClient(true);
      Response response = await dio.get(Endpoints.sessionsCreate);

      if (Utility.isNotNullEmptyOrFalse(response.data) &&
          response.data['responseCode'] == 200) {
        return SessionModel.fromJson(response.data['session']);
      } else if (response.data['responseCode'] == 401) {
        SharedWidgets.failureToast(response.data['message']);
        return null;
      } else if (response.data['responseCode'] == 400) {
        SharedWidgets.somethingWentWrong();
        return null;
      }
    } catch (e) {
      print(e);
      SharedWidgets.somethingWentWrong();
      return null;
    }
    return null;
  }

  Future<bool> setUserForSession(String sessionId) async {
    try {
      Dio dio = await Request().getApiClient(false);
      Response response = await dio
          .post(Endpoints.sessionsSetUser, data: {'sessionId': sessionId});

      if (Utility.isNotNullEmptyOrFalse(response.data) &&
          response.data['responseCode'] == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      SharedWidgets.somethingWentWrong();
      return false;
    }
  }
}
