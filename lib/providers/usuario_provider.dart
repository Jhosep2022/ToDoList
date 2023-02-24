import 'package:flutter/widgets.dart';
import '../constants.dart';
import '../models/usuario.dart';
import 'package:http/http.dart' as http;

final urlapi = url;

class Usuario_provider with ChangeNotifier {
  List<Usuario> usuarios = [];

  usuario_provider() {
    getUsuarios();
  }

  getUsuarios() async {
    final url1 = Uri.http(urlapi, 'api/usuario');
    final resp = await http.get(url1, headers: {
      "Access.Control.Allow.Origin": "*",
      "Access.Control.Allow.Credentials": "true",
      'Content-type': 'application/json',
      'Accept': 'application/json'
    });
    final response = UsuarioFromJson(resp.body);
    usuarios = response;
    notifyListeners();
  }
}
