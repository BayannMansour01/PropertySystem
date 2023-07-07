// import 'package:shared_preferences/shared_preferences.dart';

// class CacheHelper {
//   static late SharedPreferences prefs;
//   static init() async {
//     final prefs = await SharedPreferences.getInstance();
//   }

//   static getData({required key}) {
//     return prefs.get(key);
//   }

//   static Future<bool> savedata(
//       {required String key, required dynamic value}) async {
//     if (value is String) {
//       return await prefs.setString(key, value);
//     }
//     if (value is int) {
//       return await prefs.setInt(key, value);
//     }
//     if (value is bool) {
//       return await prefs.setBool(key, value);
//     }
//     return await prefs.setDouble(key, value);
//   }
// }
