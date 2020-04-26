class Kategori {
  int kategoriID;
  String kategoriBaslik;

  Kategori(
      this.kategoriBaslik); //kategori olustururken id sql tarafindan olusturacak

  Kategori.WithId(
      this.kategoriID, this.kategoriBaslik); //kategori okunurken id gerekebilir

  Map<String, dynamic> toMap() {
    //kategori nesnesini mape cevir
    var map = Map<String, dynamic>();
    map['kategoriID'] = kategoriID;
    map['kategoriBaslik'] = kategoriBaslik;

    return map;
  }

  Kategori.fromMap(Map<String, dynamic> map) {
    //mapten alarak kategori nesnesi olustur
    this.kategoriID = map['kategoriID'];
    this.kategoriBaslik = map['kategoriBaslik'];
  }

  @override
  String toString() {
    return 'Kategori{kategoriID: $kategoriID, kategoriBaslik: $kategoriBaslik}';
  }
}
