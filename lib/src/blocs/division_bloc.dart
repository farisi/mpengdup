import 'dart:async';
import 'package:mpengdup/src/models/division.dart';
import 'package:mpengdup/src/models/response.dart';
import 'package:mpengdup/src/resources/repositories/divisi_repository.dart';

class DivisionBloc {
  DivisionRepository divisiRepo;
  StreamController _divisionFetcher;

  StreamSink<Response<List<Division>>> get divisionListSink => _divisionFetcher.sink;
  Stream<Response<List<Division>>> get divisionListStream => _divisionFetcher.stream;

  DivisionBloc(){
    divisiRepo = DivisionRepository();
    _divisionFetcher = StreamController<Response<List<Division>>>();
    FetchAllDivision();
  }

  FetchAllDivision() async{
    try {
      List<Division> complaint = await divisiRepo.fetchAllComplaint();
      _divisionFetcher.add(Response.completed(complaint));
    }
    catch (e) {
      print("error catch " + e.toString());
    }
  }

  dispose(){
    _divisionFetcher?.close();
  }
}
