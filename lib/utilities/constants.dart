import 'package:dio/dio.dart';

class Constants {
  static const pageLimit = 10;
  static const baseUrl = "http://192.168.1.101:3020";
  static BaseOptions networkOptions = BaseOptions(
    baseUrl: baseUrl,
    connectTimeout: 150000,
    receiveTimeout: 100000,
  );
}
