import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:jagadbuku_admin/app/data/model/response_kategori.dart';

import '../../../routes/app_pages.dart';
import '../controllers/kategori_controller.dart';
import '../views/add_kategori.dart';

class KategoriView extends GetView<KategoriController> {
  const KategoriView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFD0E2E5),
      appBar: AppBar(
        backgroundColor: Color(0xFF0098DA),
        iconTheme: IconThemeData(
          color: Colors.white, // Ikon back berwarna putih
        ),
        title: Text(
          'List Kategori',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView(
        children: [

          Expanded(
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 1.0,
              child: controller.obx((state) => ListView.separated(
                itemCount: state!.length,
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                itemBuilder: (context, index){
                  DataKategori dataKategori = state[index];
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0), // Tambahkan jarak vertikal
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            offset: Offset(2, 2),
                            blurRadius: 5,
                          ),
                        ],
                      ),
                      child:  ListTile(
                        title: Text("${dataKategori.nama}"),
                        // subtitle: Text("Penulis ${data.book?.penulis}\nPenerbit ${dataBook.book?.penerbit}\nTahun Terbit ${dataBook.book?.tahunTerbit}"),
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) => SizedBox.shrink(),
              )),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.dialog(
            _buildAddForm(),
          );
        },
        child: Icon(Icons.add),
        backgroundColor: Color(0xFF0098DA),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    );
  }
}
Widget _buildAddForm() {
  final controller = Get.find<KategoriController>();
  final formKey = GlobalKey<FormState>();
  String? nama;

  return AlertDialog(
    title: Text('Tambah Kategori'),
    content: Form(
      key: formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            decoration: InputDecoration(labelText: 'Nama Kategori'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Nama kategori tidak boleh kosong';
              }
              return null;
            },
            onSaved: (value) {
              nama = value;
            },
          ),
        ],
      ),
    ),
    actions: [
      TextButton(
        onPressed: () {
          Get.toNamed(Routes.KATEGORI);
        },
        child: Text('Batal'),
      ),
      TextButton(
        onPressed: () {
          if (formKey.currentState!.validate()) {
            formKey.currentState!.save();
            controller.addKategori(nama!);
            Get.toNamed(Routes.KATEGORI);
          }
        },
        child: Text('Tambah'),
      ),
    ],
  );
}