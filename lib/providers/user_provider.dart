import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/user_model.dart';

class UserProvider extends ChangeNotifier {
  List<UserModel> _users = [];

  List<UserModel> get users => _users;

  Future<void> getUsers() async {
    _users.clear();
    Uri uri = Uri.parse(
        "https://simple-crud-7dc79-default-rtdb.asia-southeast1.firebasedatabase.app/users.json");

    await http.get(uri).then((val) {
      if (val.body != "null") {
        var hasil = json.decode(val.body) as Map<String, dynamic>;
        hasil.forEach((key, value) {
          _users.add(UserModel(
              id: key,
              avatar: value["avatar"],
              nama: value["nama"],
              email: value["email"],
              alamat: value["alamat"]));
        });
        notifyListeners();
      }
    });
  }

  Future<void> delUser(String id) async {
    Uri uri = Uri.parse(
        "https://simple-crud-7dc79-default-rtdb.asia-southeast1.firebasedatabase.app/users/$id.json");

    await http.delete(uri).then((val) {
      _users.removeWhere((element) => element.id == id);
      notifyListeners();
    });
  }

  Future<void> postUser(String u, String p, String r, {String? a}) async {
    Uri uri = Uri.parse(
        "https://simple-crud-7dc79-default-rtdb.asia-southeast1.firebasedatabase.app/users.json");

    Map param;
    if (a == "") {
      a = "https://cdn.iconscout.com/icon/free/png-256/laptop-user-1-1179329.png";
    }
    param = {"avatar": a, "nama": u, "email": p, "alamat": r};
    await http.post(uri, body: json.encode(param)).then((_) {
      getUsers();
    });
  }

  Future<void> patchUser(String id, String u, String p, String r,
      {String? a}) async {
    Uri uri = Uri.parse(
        "https://simple-crud-7dc79-default-rtdb.asia-southeast1.firebasedatabase.app/users/$id.json");

    Map param;
    if (a == "") {
      a = "https://cdn.iconscout.com/icon/free/png-256/laptop-user-1-1179329.png";
    }
    param = {"avatar": a, "nama": u, "email": p, "alamat": r};
    await http.patch(uri, body: json.encode(param)).then((_) {
      getUsers();
      notifyListeners();
    });
  }

  UserModel selectUser(String id) {
    return _users.firstWhere((element) => element.id == id);
  }
}
