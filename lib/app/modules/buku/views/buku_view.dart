import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../data/model/response_buku.dart';
import '../../../routes/app_pages.dart';
import '../controllers/buku_controller.dart';

class BukuView extends GetView<BukuController> {
  const BukuView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFD0E2E5),
      appBar: AppBar(
        backgroundColor: Color(0xFF0098DA),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Get.offAllNamed(Routes.HOME);  // Kembali ke halaman sebelumnya
          },
            color: Colors.white
        ),
        title: Text(
          'BUKU',
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
                    itemBuilder: (context, index) {
                      DataBuku dataBuku = state[index];
                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.0),
                        // Tambahkan jarak vertikal
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
                          child: InkWell(
                            onTap: () {
                              Get.toNamed(Routes.DETAIL_BUKU, arguments: {
                                'id': (dataBuku.id ?? 0).toString(),
                                'judul': dataBuku.judul ?? '-',
                                'penulis': dataBuku.penulis ?? '-',
                                'penerbit': dataBuku.penerbit ?? '-',
                                'image': dataBuku.image ?? '-',
                                'tahun_terbit':
                                    dataBuku.tahunTerbit.toString() ?? '-',
                                'deskripsi': dataBuku.deskripsi ?? '-',
                                'kategoriId': dataBuku.kategoriId ?? '-',
                                'kategoriNama': dataBuku.kategori?.nama ?? '-'
                              });
                            },
                            child: ListTile(
                              leading: CachedNetworkImage(
                                imageUrl: "${dataBuku.image}",
                                placeholder: (context, url) =>
                                    CircularProgressIndicator(),
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.error),
                              ),
                              title: Text("${dataBuku.judul}"),
                              subtitle: Text(
                                  "Penulis ${dataBuku.penulis}\nPenerbit ${dataBuku.penerbit}\nTahun Terbit ${dataBuku.tahunTerbit}"),
                            ),
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
          Get.toNamed(Routes.ADD_BUKU);
        },
        child: Icon(Icons.add),
        backgroundColor: Color(0xFF0098DA),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    );
  }
}

