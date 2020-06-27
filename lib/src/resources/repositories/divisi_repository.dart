import 'dart:async';
import 'package:mpengdup/src/models/division.dart';
import 'package:mpengdup/src/network_utils/api.dart';

class DivisionRepository {
  final apiProvider = Network();

  Future<List<Division>> fetchAllComplaint() async {
    final response = await apiProvider.get('/divisi');
    return ChuckDivision.fromJson(response).data;
  }
}