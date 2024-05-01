import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:jagadbuku_admin/app/data/model/response_user.dart';
// import 'package:jagadbuku_admin/routes/app_pages.dart';
import 'package:jagadbuku_admin/app/modules/home/controllers/home_controller.dart';

import '../../../routes/app_pages.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFD0E2E5),
      appBar: AppBar(
        backgroundColor: Color(0xFF0098DA),
        title: const Text(
            'HOME',
          style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        ),
        centerTitle: true,
      ),
      body:       // Jika dataUser tidak null, tampilkan informasi pengguna
          Column(
            children: [
              SizedBox(height: 12),

              Container(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    crossAxisSpacing: 40,
                    mainAxisSpacing: 30,
                    children: [
                      _itemDashboard(
                        context,
                        'Kategori',
                        Icons.category,
                        Colors.deepOrange,
                        onTap: () => Get.toNamed(Routes.KATEGORI),
                      ),
                      _itemDashboard(
                        context,
                        'BUKU',
                        Icons.menu_book,
                        Colors.green,
                        onTap: () => Get.toNamed(Routes.BUKU),
                      ),
                      _itemDashboard(
                        context,
                        'Audience',
                        CupertinoIcons.person_2,
                        Colors.purple,
                        onTap: () => print("Audience clicked"),
                      ),
                    ],
                  ),
                ),
              ),
            ],
        // onLoading: const Center(
        //   child: CircularProgressIndicator(),
        // ),
        // onError: (error) => Center(
        //   child: Text("Error: $error"),
        // ),
      ),
    );
  }

  Widget _itemDashboard(
      BuildContext context,
      String title,
      IconData iconData,
      Color background,
      {required Function() onTap}
      ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 5),
              color: Theme.of(context).primaryColor.withOpacity(.2),
              spreadRadius: 2,
              blurRadius: 5,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: background,
                shape: BoxShape.circle,
              ),
              child: Icon(iconData, color: Colors.white),
            ),
            const SizedBox(height: 8),
            Text(
              title.toUpperCase(),
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),
      ),
    );
  }
}
