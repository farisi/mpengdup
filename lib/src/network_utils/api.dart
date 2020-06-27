import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mpengdup/src/resources/helpers/custom_exception.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'dart:io';

class Network{
  final String _url = 'http://192.168.43.89/e-pengaduan/public/api';
  //if you are using android studio emulator, change localhost to 10.0.2.2
  var token;
  var user;
  var role;

  _getToken() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    token = jsonDecode(localStorage.getString('token'));
  }

  authData(data, apiUrl) async {
    var fullUrl = _url + apiUrl;
    return await http.post(
        fullUrl,
        body: jsonEncode(data),
        headers: _setHeaders()
    );
  }

  Future<dynamic> updateData(data, apiUrl) async {
    var responseJson;
    var fullUrl = _url + apiUrl;
    print("url pada updateData " + fullUrl);
    print(data.toString());
    try {
      await _getToken();
      final response  =  await http.patch(
          fullUrl,
          body: jsonEncode(data),
          headers: _setHeaders()
      );

      responseJson = _response(response);
    }on SocketException {
      throw FetchDataException('No Internet connection');
    }

    return responseJson;
  }

  getData(apiUrl) async {
    var fullUrl = _url + apiUrl;
    await _getToken();
    return await http.get(
        fullUrl,
        headers: _setHeaders()
    );
  }

  Future<dynamic> get(apiUrl) async {
    var responseJson;
    var fullUrl = _url + apiUrl;

    try {
      await _getToken();
      final response  =  await http.get(fullUrl, headers: _setHeaders());
      print("contoh data dari internet " + response.body.toString());

      responseJson = _response(response);
    }on SocketException {
      throw FetchDataException('No Internet connection');
    }

    return responseJson;
  }

  Future<dynamic> getAllComplaint() async {
      var responseJson;
      var apiUrl='/complaint';
      var fullUrl = _url + apiUrl;

      try {
        await _getToken();
        final response  =  await http.get(fullUrl, headers: _setHeaders());
        responseJson = _response(response);
      }on SocketException {
        throw FetchDataException('No Internet connection');
      }

      return responseJson;
  }

  dynamic _response(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body.toString());
        print(responseJson);
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:

      case 403:
        throw UnauthorisedException(response.body.toString());
      case 500:

      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }

  _setHeaders() => {
    'Content-type' : 'application/json',
    'Accept' : 'application/json',
    'Authorization' : 'Bearer $token'
  };

}