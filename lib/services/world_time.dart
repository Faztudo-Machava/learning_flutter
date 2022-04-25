// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:http/http.dart';
import 'package:intl/intl.dart';

class WorldTime {
  String? location; //location name for the UI
  String? time; //The time in that location
  String? flag; //url to an asset flag icon
  String? url; //location url for api endpoint
  bool? isDayTime;

  WorldTime({this.location, this.flag, this.url});

  Future<void> getTime() async {
    try {
      Uri uri = Uri.http('www.worldtimeapi.org', '/api/timezone/$url');
      Response response = await get(uri);
      Map data = jsonDecode(response.body);
      var datetime = data['datetime'];
      var offset = data['utc_offset'].substring(1, 3);

      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(offset)));

      //Set time property
      isDayTime = now.hour > 6 && now.hour < 18 ? true : false;
      time = DateFormat().add_jm().format(now);
    } catch (e) {
      print('Erro: $e');
      time = 'Falha ao carregar os dados.';
    }
  }
}
