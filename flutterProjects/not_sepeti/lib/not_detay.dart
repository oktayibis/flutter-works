import 'package:flutter/material.dart';
import 'package:not_sepeti/models/kategori.dart';
import 'package:not_sepeti/utils/databsae_helper.dart';
import 'package:sqflite/sqflite.dart';

import 'models/notlar.dart';

class NotDetay extends StatefulWidget {
  String baslik;
  NotDetay({this.baslik});

  @override
  _NotDetayState createState() => _NotDetayState();
}

class _NotDetayState extends State<NotDetay> {
  List<Kategori> tumKategoriler;
  DatabaseHelper databaseHelper;
  int kategoriID = 1;
  int oncelik = 1;
  String notBaslik, notIcerik;
  static var _oncelik = ["Düşük", "Orta", "Yüksek"];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tumKategoriler = List<Kategori>();
    databaseHelper = DatabaseHelper();
    databaseHelper.kategoriGetir().then((kategorileriIcerenMap) {
      //databasen tum kategorileri cagirdik ve listeye ekledik
      for (Map okunanMap in kategorileriIcerenMap) {
        tumKategoriler.add(Kategori.fromMap(okunanMap));
      }
      setState(() {
        //her seferinde calismasini gerekli olan metod. bos olsa da buraya yazilarak bu blogun calismasini saglar
      });
    });
  }

  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text(widget.baslik),
      ),
      body: tumKategoriler.length <= 0
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              child: Form(
                key: formKey,
                child: Column(
                  children: <Widget>[
                    //kategori secme
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(shape: BoxShape.circle),
                          child: Text(
                            'Kategori Seciniz : ',
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(shape: BoxShape.circle),
                          child: DropdownButton<int>(
                            items: kategoriItemleriOlustur(),
                            onChanged: (secilenKategoriID) {
                              setState(() {
                                kategoriID = secilenKategoriID;
                              });
                            },
                            value: kategoriID,
                          ),
                          padding: EdgeInsets.all(5),
                        ),
                      ],
                    ),
                    //oncelik secme
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(shape: BoxShape.circle),
                          child: Text(
                            'Oncelik Seciniz : ',
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(shape: BoxShape.circle),
                          child: DropdownButton<int>(
                              items: _oncelik.map((oncelik) {
                                return DropdownMenuItem<int>(
                                  child: Text(
                                    oncelik,
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  value: _oncelik.indexOf(oncelik),
                                );
                              }).toList(),
                              value: oncelik,
                              onChanged: (secilenOncelikID) {
                                setState(() {
                                  oncelik = secilenOncelikID;
                                });
                              }),
                          padding: EdgeInsets.all(5),
                        ),
                      ],
                    ),
                    Padding(
                      //baslik girme
                      padding: const EdgeInsets.all(10.0),
                      child: TextFormField(
                        validator: (text) {
                          if (text.length < 3) {
                            return 'Baslik 3 karetker olmalidir..';
                          }
                        },
                        onSaved: (text) {
                          setState(() {
                            notBaslik = text;
                          });
                        },
                        decoration: InputDecoration(
                            hintText: 'Baslik Giriniz',
                            labelText: 'Baslik',
                            helperText: 'Ornek: Ev Ihtiyaclari',
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)))),
                        autocorrect: true,
                      ),
                    ),
                    Padding(
                      //icerik girme
                      padding: const EdgeInsets.all(10.0),
                      child: TextFormField(
                        maxLines: 5,
                        onSaved: (text) {
                          setState(() {
                            notIcerik = text;
                          });
                        },
                        decoration: InputDecoration(
                            hintText: 'Icerik Giriniz',
                            labelText: 'Icerik',
                            helperText: 'Ornek: Ekmek, Su, Havuc',
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)))),
                        autocorrect: true,
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ButtonBar(
                        children: <Widget>[
                          RaisedButton.icon(
                            onPressed: () {
                              if (formKey.currentState.validate()) {
                                formKey.currentState.save();

                                var suan = DateTime.now();
                                Not eklenencekNot = Not(
                                  kategoriID,
                                  notBaslik,
                                  notBaslik,
                                  oncelik,
                                  suan.toString(),
                                );
                                print(eklenencekNot);
                                databaseHelper
                                    .notEkle(eklenencekNot)
                                    .then((kaydedilenNotID) {
                                  if (kaydedilenNotID != 0) {
                                    Navigator.pop(context);
                                  }
                                });
                              }
                            },
                            icon: Icon(
                              Icons.save,
                              color: Colors.white,
                            ),
                            label: Text('Kaydet'),
                            color: Colors.green,
                          ),
                          RaisedButton.icon(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: Icon(Icons.cancel, color: Colors.white),
                              label: Text('Iptal'),
                              color: Colors.redAccent),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  List<DropdownMenuItem<int>> kategoriItemleriOlustur() {
    return tumKategoriler
        .map((kategori) => DropdownMenuItem<int>(
              value: kategori.kategoriID,
              child: Text(
                kategori.kategoriBaslik,
                style: TextStyle(fontSize: 16),
              ),
            ))
        .toList();
  }

  oncelikListesiniGoster() {
    //oncelik listesini asagidaki gibi olusturur. buraaya oncelik eklenip cikartilabilir
    var oncelikListesi = ['Dusuk', 'Orta', 'Yuksek', 'Cok Yuksek'];
    return oncelikListesi.map((oncelik) {
      return DropdownMenuItem<int>(
        value: oncelikListesi.indexOf(oncelik),
        child: Text(
          oncelik,
          style: TextStyle(fontSize: 20),
        ),
      );
    }).toList();
  }
}
