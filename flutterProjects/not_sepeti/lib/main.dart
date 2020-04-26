import 'package:flutter/material.dart';
import 'package:not_sepeti/models/kategori.dart';
import 'package:not_sepeti/utils/databsae_helper.dart';
import 'package:sqflite/sqflite.dart';

import 'not_detay.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    DatabaseHelper databaseHelper = DatabaseHelper();
    databaseHelper.kategoriGetir();

    return MaterialApp(
      title: "Not Sepeti Uygulamasi",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.orange,
        accentColor: Colors.blueAccent,
      ),
      home: NotListesi(),
    );
  }
}

class NotListesi extends StatefulWidget {
  @override
  _NotListesiState createState() => _NotListesiState();
}

class _NotListesiState extends State<NotListesi> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  var _scaffoldState = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldState,
      appBar: AppBar(
        title: Center(
          child: Text('Not Sepeti'),
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton(
            heroTag: 'KategoriEkle',
            tooltip: 'Kategori Ekle',
            onPressed: () {
              kategoriEkleDialog(context); //kategori ekmele fonksiyonu
            },
            child: Icon(Icons.add_circle),
            mini: true,
          ),
          FloatingActionButton(
            heroTag: 'NotEkle', //birdenfazla floatactionbutton varsa tagliyoruz
            tooltip: 'Not Ekle',
            onPressed: () {
              sayfayaGit(context);
            },
            child: Icon(Icons.add),
          ),
        ],
      ),
      body: Container(),
    );
  }

  void kategoriEkleDialog(BuildContext context) {
    var formkey =
        GlobalKey<FormState>(); //kaydetme ve validate islemleri icin kullanir
    var yeniKategoriAdi; //girilecek kategoriyi tutacak
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: Text(
              'Kategori Ekle',
              style: TextStyle(
                  letterSpacing: 5, fontWeight: FontWeight.bold, fontSize: 20),
            ),
            children: <Widget>[
              Form(
                key: formkey,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    onSaved: (girilenad) {
                      yeniKategoriAdi = girilenad;
                    },
                    decoration: InputDecoration(
                      labelText: 'Kategori Adi',
                      border: OutlineInputBorder(),
                    ),
                    validator: (girilenAd) {
                      if (girilenAd.length < 3) {
                        return "Kategori Adi en az 3 karekter olmalidir";
                      }
                    },
                  ),
                ),
              ),
              ButtonBar(
                children: <Widget>[
                  RaisedButton(
                    child: Text("Kaydet"),
                    onPressed: () {
                      if (formkey.currentState.validate()) {
                        formkey.currentState.save();
                        databaseHelper
                            .kategoriEkle(Kategori(yeniKategoriAdi))
                            .then((onvalue) {
                          if (onvalue > 0) {
                            _scaffoldState.currentState.showSnackBar(
                              SnackBar(
                                backgroundColor: Colors.lightGreen,
                                content: Text(
                                    'Kategori Eklendi. Kategori No: $onvalue'),
                                duration: Duration(seconds: 2),
                              ),
                            );
                          } else {
                            _scaffoldState.currentState.showSnackBar(
                              SnackBar(
                                backgroundColor: Colors.redAccent,
                                duration: Duration(seconds: 2),
                                content: Text(
                                    'Hata Alindi, programi kapatip tekrar deneyin.'),
                              ),
                            );
                          }
                        });
                        Navigator.pop(context);
                      }
                    },
                    color: Colors.lightGreen,
                  ),
                  RaisedButton(
                    child: Text("Vazgec"),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    color: Colors.red[300],
                  )
                ],
              )
            ],
          );
        });
  }

  void sayfayaGit(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => NotDetay(
                  baslik: 'Yeni Not Ekle',
                )));
  }
}
