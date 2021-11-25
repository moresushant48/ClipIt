import 'package:clipit/utilities/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';
// import 'package:shared_preferences/shared_preferences.dart';

class Utility {
  static const storage = FlutterSecureStorage();
  static bool isNullEmptyOrFalse(Object? o) {
    return o == null || false == o || "" == o || "null" == o || "false" == o;
  }

  static bool isNotNullEmptyOrFalse(Object? o) {
    return !isNullEmptyOrFalse(o);
  }

  static String getInitials(String fullName) => fullName.isNotEmpty
      ? fullName.trim().split(' ').map((l) => l[0]).take(2).join().toUpperCase()
      : '';

  static String getFormattedDate(String date, {bool forCard = true}) {
    var localDate = DateTime.parse(date).toLocal();

    var inputFormat = DateFormat('yyyy-MM-dd HH:mm');
    var inputDate = inputFormat.parse(localDate.toString());

    var outputFormat = forCard
        ? DateFormat(
            "dd'${getDayOfMonthSuffix(int.parse(DateFormat("dd").format(inputDate)))}' MMMM")
        : DateFormat(
            "dd'${getDayOfMonthSuffix(int.parse(DateFormat("dd").format(inputDate)))}' MMMM, yyyy");
    var outputDate = outputFormat.format(inputDate);

    return outputDate.toString();
  }

  static String getDayOfMonthSuffix(int dayNum) {
    if (!(dayNum >= 1 && dayNum <= 31)) {
      throw Exception('Invalid day of month');
    }

    if (dayNum >= 11 && dayNum <= 13) {
      return 'th';
    }

    switch (dayNum % 10) {
      case 1:
        return 'st';
      case 2:
        return 'nd';
      case 3:
        return 'rd';
      default:
        return 'th';
    }
  }

  static int count(any) {
    var count = 0;
    any.forEach((app) {
      if (app['status'] == 0) {
        count++;
      }
    });
    return count;
  }

  static int notificationscount(any) {
    var count = 0;
    count = any.length;
    return count;
  }

  static Future storeCookie(String cookieName, String cookieValue) async {
    Future added = storage.write(key: cookieName, value: cookieValue);
    return added;
  }

  static Future<String> getCookies(String cookieName) async {
    String? cookies = await storage.read(key: cookieName);
    if (cookies != null) {
      return cookies;
    } else {
      return '';
    }
  }

  static Future<void> deleteCookie(String cookieName) async {
    await storage.delete(
      key: cookieName,
    );
  }

  static String formateDate(DateTime date) {
    final DateFormat formatter = DateFormat('dd MMM yyyy');
    return formatter.format(date);
  }

  static logout(context) async {
    storage.deleteAll().then((value) {
      Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
    });
  }

  static String getQuery(Params query) {
    String url = '?';
    if (isNotNullEmptyOrFalse(query)) {
      if (isNotNullEmptyOrFalse(query.page)) {
        url += 'page=${query.page}&';
      }
      if (isNotNullEmptyOrFalse(query.limit)) {
        url += 'limit=${query.limit}&';
      }
      if (isNotNullEmptyOrFalse(query.offset)) {
        url += 'offset=${query.offset}&';
      }
      if (isNotNullEmptyOrFalse(query.sorts) && query.sorts.isNotEmpty) {
        for (var sort in query.sorts) {
          url += 'sort=${sort.field},${sort.type}&';
        }
      }
      if (isNotNullEmptyOrFalse(query.filters) && query.filters.isNotEmpty) {
        for (var filter in query.filters) {
          url +=
              'filter=${filter.field}||${filter.condition}||${filter.value}&';
        }
      }
    }
    return url;
  }

  static int getGenderByNumber(String genderText) {
    var gender = 0;
    switch (genderText) {
      case 'Male':
        gender = 0;
        break;
      case 'Female':
        gender = 1;
        break;
      case 'Rather not say':
        gender = 2;
        break;
    }
    return gender;
  }
}

class Params {
  int page = 1;
  int limit = Constants.pageLimit;
  int offset = 0;
  List<Sort> sorts = [];
  List<Filter> filters = [];
  Params() {
    filters.add(Filter('enabled', '\$eq', 'true'));
  }
}

class Filter {
  String field;
  String condition;
  String value;
  Filter(this.field, this.condition, this.value);
}

class Sort {
  String field;
  String type;
  Sort(this.field, this.type);
}

class PageResponseModel<P> {
  List<P> data = [];
  int total = 0;
  int count = 0;
  int page = 0;
  int pageCount = 0;
}
