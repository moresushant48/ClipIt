import 'package:clipit/utilities/constants.dart';
import 'package:clipit/utilities/utility.dart';
import 'package:dio/dio.dart';

class Request {
  Future<Dio> getApiClient(bool isPublic) async {
    Dio dio = Dio(Constants.networkOptions);
    dio.interceptors.clear();
    var token = await Utility.getCookies('token');
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        if (!isPublic) {
          options.headers["Authorization"] = "Bearer " + token;
        }
        return handler.next(options);
      },
      onResponse: (response, handler) {
        return handler.next(response);
      },
      onError: (error, handler) {
        if (Utility.isNullEmptyOrFalse(error.response)) {
          // Fluttertoast.showToast(
          //     msg: error.message,
          //     toastLength: Toast.LENGTH_SHORT,
          //     gravity: ToastGravity.BOTTOM,
          //     timeInSecForIosWeb: 1,
          //     backgroundColor: Colors.red,
          //     textColor: Colors.white,
          //     fontSize: 16.0);
        } else if (!Utility.isNullEmptyOrFalse(error.response) &&
            !Utility.isNullEmptyOrFalse(error.response?.data['message'])) {
          // var errorMessage = error.response.data['message'];
          // Fluttertoast.showToast(
          //     msg: error.response.data['message'],
          //     toastLength: Toast.LENGTH_SHORT,
          //     gravity: ToastGravity.BOTTOM,
          //     timeInSecForIosWeb: 1,
          //     backgroundColor: Colors.red,
          //     textColor: Colors.white,
          //     fontSize: 16.0);
        } else {
          return handler.next(error);
        }
      },
    ));
    return dio;
  }
}
