// import 'package:dio/dio.dart';
// import 'package:flutter/cupertino.dart';

// class diohelper {
//   static Dio? dio;
//   //بنيت الديو
//   static init() {
//     dio = Dio(
//       BaseOptions(
//         baseUrl: 'https://billingsystemproject1.000webhostapp.com/api/',
//         receiveDataWhenStatusError: true,
//       ),
//     );
//   }

//   static Future<Response> getData({
//     @required String? url,
//     @required query,
//     String? token,
//   }) async {
//     dio!.options.headers = {'Authorization': 'Bearer $token'};
//     return dio!.get(url!, queryParameters: query);
//   }

//   static Future<Response<dynamic>> postData(
//       {@required String? url,
//       @required data,
//       @required query,
//       String? token,
//       String? content_type}) async {
//     dio!.options.headers = {
//       'Authorization': 'Bearer $token',
//       'contentType': content_type
//     };
//     return dio!.post(url!, data: data);
//   }

//   static Future<Response<dynamic>> deleteData(
//       {@required url,
//       @required data,
//       @required query,
//       String? token,
//       String? content_type}) async {
//     dio!.options.headers = {
//       'Authorization': 'Bearer $token',
//       'contentType': content_type
//     };
//     return dio!.delete(url!, data: data);
//   }

//   static Future<Response<dynamic>> putData(
//       {@required String? url,
//       data,
//       query,
//       String? token,
//       String? content_type}) async {
//     dio!.options.headers = {
//       'Authorization': 'Bearer $token',
//       'contentType': content_type
//     };
//     return dio!.put(url!, data: data);
//   }
// }
