import 'dart:async';
import 'package:mpengdup/src/models/complaint.dart';
import 'package:mpengdup/src/network_utils/api.dart';

class ComplainRepository {
  final apiProvider = Network();

  Future<List<Complaint>> fetchAllComplaint() async {
    final response = await apiProvider.getAllComplaint();
    return ChuckComplaints.fromJson(response).data;
  }

  Future<Complaint> updateComplaint(String url, Complaint com) async {
    final response = await apiProvider.updateData(com.toJson(),url);
    return Complaint.fromJson(response);
  }
}