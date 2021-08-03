import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/user_provider.dart';
import 'add_edit_user_page.dart';
import 'detail_user_page.dart';

class HomePages extends StatefulWidget {
  @override
  _HomePagesState createState() => _HomePagesState();
}

class _HomePagesState extends State<HomePages> {
  bool isLoading = true;

  @override
  void didChangeDependencies() {
    Provider.of<UserProvider>(context, listen: false).getUsers().then((_) {
      setState(() {
        isLoading = false;
      });
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final dataUser = Provider.of<UserProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text("HOME", style: TextStyle(color: Colors.white)),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(AddUser.routeName);
            },
            tooltip: "Tambah",
            icon: Icon(Icons.add),
          ),
          IconButton(
            onPressed: () {
              setState(() {
                isLoading = true;
              });
              dataUser.getUsers().then((_) {
                setState(() {
                  isLoading = false;
                });
              });
            },
            tooltip: "Refresh",
            icon: Icon(Icons.restart_alt),
          ),
        ],
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Text(
                  "Geser ke kanan untuk menghapus data.",
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
                Expanded(child: ListUser(dataUser: dataUser)),
              ],
            ),
    );
  }
}

class ListUser extends StatelessWidget {
  const ListUser({required this.dataUser});

  final UserProvider dataUser;

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(builder: (_, val, __) {
      return ListView.separated(
          itemBuilder: (c, i) {
            return Dismissible(
              key: Key(val.users[i].id),
              direction: DismissDirection.startToEnd,
              background: Container(
                alignment: Alignment.centerLeft,
                color: Colors.red,
                child: Icon(
                  Icons.delete,
                  color: Colors.white,
                ),
              ),
              onDismissed: (_) {
                dataUser.delUser(val.users[i].id);
              },
              confirmDismiss: (_) {
                return showDialog(
                    context: context,
                    builder: (c) {
                      return AlertDialog(
                        title: Text("Hapus User ?"),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.of(c).pop(true),
                            child: Text("Ya"),
                          ),
                          TextButton(
                            onPressed: () => Navigator.of(c).pop(false),
                            child: Text("Tidak"),
                          ),
                        ],
                      );
                    }).then((value) => value);
              },
              child: ListTile(
                onTap: () {
                  Navigator.pushNamed(context, DetailUser.routeName,
                      arguments: val.users[i].id);
                },
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(val.users[i].avatar),
                ),
                title: Text(val.users[i].nama),
                subtitle: Text(val.users[i].email),
                trailing: IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, AddUser.routeName,
                        arguments: val.users[i].id);
                  },
                  icon: Icon(Icons.edit),
                ),
              ),
            );
          },
          separatorBuilder: (_, __) => Divider(height: 1.0),
          itemCount: dataUser.users.length);
    });
  }
}
