import 'package:flutter/material.dart';
import '../data/shared_prefs.dart';
import '../screens/password_details.dart';
import '../data/sembast_db.dart';
import '../models/password.dart';

class PasswordsScreen extends StatefulWidget {
  @override
  _PasswordsScreenState createState() => _PasswordsScreenState();
}

class _PasswordsScreenState extends State<PasswordsScreen> {
  late SembastDb db;
  int settingColor = 0xff1976d2;
  double fontSize = 16;
  SPSettings settings = SPSettings();
  @override
  void initState() {
    db = SembastDb();
    settings.init().then((value) {
      setState(() {
        settingColor = settings.getColor();
        fontSize = settings.getFontSize();
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Passwords List'),
        backgroundColor: Color(settingColor),
      ),
      body: FutureBuilder(
          future: getPasswords(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            List<Password> passwords = snapshot.data ?? [];
            return ListView.builder(
                itemCount: passwords == [] ? 0 : passwords.length,
                itemBuilder: (_, index) {
                  return Dismissible(
                    key: Key(passwords[index].id.toString()),
                    onDismissed: (_) {
                      db.deletePassword(passwords[index]);
                    },
                    child: ListTile(
                        title: Text(
                          passwords[index].name,
                          style: TextStyle(
                            fontSize: fontSize,
                          ),
                        ),
                        trailing: Icon(Icons.edit),
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return PasswordDetailDialog(
                                  passwords[index], false);
                            },
                          );
                        }),
                  );
                });
          }),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          backgroundColor: Color(settingColor),
          onPressed: () {
            showDialog(
                context: context,
                builder: (context) {
                  return PasswordDetailDialog(Password('', ''), true);
                });
          }),
    );
  }

  Future<List<Password>> getPasswords() async {
    List<Password> passwords = await db.getPasswords();
    return passwords;
  }
}
