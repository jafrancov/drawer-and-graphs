import 'package:http/http.dart' show Client;
import 'package:drawer/models/materia.dart';

class ApiService {
  final String ENDPOINT = "https://mtwdm-multi-android.azurewebsites.net/api/Materias";
  Client httpClient = Client();

  Future<List<Materia>> getMaterias() async {
    final response = await httpClient.get("$ENDPOINT");
    if (response.statusCode == 200) {
      return Materia.fromJson(response.body);
    } else {
      return null;
    }
  }
}
