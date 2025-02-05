import 'dart:io';

abstract class Barang {
  String nama;
  int harga;

  Barang(this.nama, this.harga);

  int hitungHarga(int jumlah);
}

class BarangMakanan extends Barang {
  BarangMakanan(String nama, int harga) : super(nama, harga);

  @override
  int hitungHarga(int jumlah) {
    return harga * jumlah;
  }
}

class BarangMinuman extends Barang {
  BarangMinuman(String nama, int harga) : super(nama, harga);

  @override
  int hitungHarga(int jumlah) {
    return harga * jumlah;
  }
}

List<Barang> daftarBarang = [
  BarangMakanan("Kopi", 15000),
  BarangMakanan("Roti", 10000),
  BarangMinuman("Susu", 12000),
  BarangMinuman("Teh Botol", 7000),
  BarangMakanan("Mie Instan", 3500),
  BarangMakanan("Beras 5Kg", 60000),
  BarangMinuman("Air Mineral 600ml", 3500),
];

List<Map<String, dynamic>> keranjang = [];

void main() {
  login();
}

void menu() {
  print("### Menu Utama ###");
  print("1. Transaksi Pembayaran");
  print("2. Top Up");
  stdout.write("Masukkan Pilihan => ");
  String pilihan = stdin.readLineSync() ?? "";

  switch (pilihan) {
    case "1":
      transaksi();
      break;
    case "2":
      topUp();
      break;
    default:
      print("Pilihan tidak valid");
      menu();
  }
}

void login() {
  print("### LOGIN ###");
  stdout.write("Masukkan Pin: ");
  String pin = stdin.readLineSync() ?? "";

  if (pin == "Admin123") {
    print("Pin benar");
    menu();
  } else {
    print("Pin salah, silakan coba lagi");
    login();
  }
}

void transaksi() {
  print("### TRANSAKSI ###");
  print("### Pilih Barang ###");

  int total = 0;
  while (true) {
    int index = 1;
    daftarBarang.forEach((barang) {
      print("$index. ${barang.nama} - Rp${barang.harga}");
      index++;
    });

    stdout.write("Pilih nomor barang atau ketik 'selesai': ");
    String pilihan = stdin.readLineSync() ?? "";

    if (pilihan.toLowerCase() == "selesai") {
      break;
    }

    int? nomorBarang = int.tryParse(pilihan);
    if (nomorBarang == null || nomorBarang < 1 || nomorBarang > daftarBarang.length) {
      print("Pilihan tidak valid, coba lagi.");
      continue;
    }

    Barang barangDipilih = daftarBarang[nomorBarang - 1];
    stdout.write("Masukkan jumlah: ");
    int jumlah = int.tryParse(stdin.readLineSync() ?? "") ?? 0;

    if (jumlah <= 0) {
      print("Jumlah harus lebih dari 0!");
      continue;
    }

    int subtotal = barangDipilih.hitungHarga(jumlah);
    total += subtotal;

    keranjang.add({
      "nama": barangDipilih.nama,
      "harga": barangDipilih.harga,
      "jumlah": jumlah,
      "subtotal": subtotal,
    });

    print("$jumlah x ${barangDipilih.nama} - Rp$subtotal ditambahkan ke keranjang.");
    print("Total Belanja saat ini: Rp$total");
  }

  bayar(total);
}

void bayar(int total) {
  print("\n=== STRUK BELANJA ===");
  keranjang.forEach((item) {
    print("${item['jumlah']}x ${item['nama']} - Rp${item['subtotal']}");
  });

  print("-------------------------");
  print("Total Belanja: Rp$total");
  print("Terima kasih telah berbelanja!");
}

void topUp() {
  print("\n### TOP UP ###");
  stdout.write("Masukkan jumlah top up: ");
  int? jumlah = int.tryParse(stdin.readLineSync() ?? "");

  if (jumlah == null || jumlah <= 0) {
    print("Jumlah tidak valid!");
    return topUp();
  }

  print("Top up Rp$jumlah berhasil!");
  menu();
}
