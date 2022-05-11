import 'dart:convert';

import 'package:http/http.dart' as http;

class UsuarioProvider {

  Future nuevoUsuario(String email, String password)async{

    final String _firebaseToken = 'AIzaSyBLuXGydlERYwkqSjQjOWZly86CpsVAnzs';

    final authData = {
     'email'     : email,
     'password' : password,
     'returnSecureToken' : true
    };

    final resp = await http.post(
     Uri.parse(
        'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=$_firebaseToken'),
      body: json.encode(authData));

      Map <String, dynamic> decodeResp = json.decode(resp.body); 
      print(decodeResp);

      if(decodeResp.containsKey('idToken')){
        // TODO: salvar el token storage
        return {'ok': true, 'token' : decodeResp ['idToken'] };
      }else{
        return {'ok': false, 'mensaje' : decodeResp['error']['message'] };
      }
  }

}