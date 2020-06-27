import 'dart:async';
import 'package:mpengdup/src/models/complaint.dart';
import 'package:mpengdup/src/models/response.dart';
import 'package:mpengdup/src/resources/repositories/complain_repository.dart';

class ComplaintBloc  {
  ComplainRepository _complainRepository;
  StreamController  _complaintFetcher;
  StreamController _complaintStreamController;

  StreamSink<Response<List<Complaint>>> get complaintListSink => _complaintFetcher.sink;
  Stream<Response<List<Complaint>>> get allComplaint => _complaintFetcher.stream;

  StreamSink<Response<Complaint>> get complaintSink => _complaintStreamController.sink;
  Stream<Response<Complaint>> get getComplaint => _complaintStreamController.stream;

  ComplaintBloc(){
    _complaintFetcher = StreamController<Response<List<Complaint>>>();
    _complainRepository = ComplainRepository();
    _complaintStreamController = StreamController<Response<Complaint>>();
    fetchAllComplaint();
  }

  fetchAllComplaint() async {
    try {
      List<Complaint> complaint = await _complainRepository.fetchAllComplaint();
      _complaintFetcher.add(Response.completed(complaint));
    }
    catch (e) {
      print("error catch " + e.toString());
    }
  }

  updateComplaint(String url, Complaint i) async {

    try {
      Complaint m = await _complainRepository.updateComplaint(url, i);
      _complaintStreamController.add(Response.completed(m));
    }
    catch (e) {
      print("error catch saat update " + e.toString());
    }
  }

  dispose() {
    _complaintFetcher?.close();
    _complaintStreamController?.close();
  }
}