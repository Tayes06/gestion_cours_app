import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:gestion_cours_app/helper_functions.dart';
import 'package:gestion_cours_app/views/acceuil/acceuil.dart';
import 'package:gestion_cours_app/views/compte/compte.dart';
import 'package:gestion_cours_app/views/paiement/paiement.dart';
import 'package:gestion_cours_app/views/programme/programme.dart';
import 'package:gestion_cours_app/views/validation/validation.dart';
import 'package:get/get.dart';

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());
    final darkMode = ThelperFunctions.isDarkMode(context);

    return Scaffold(
      bottomNavigationBar: Obx(
        () => NavigationBar(
          height: 80,
          elevation: 0,
          selectedIndex: controller.selectedIndex.value,
          onDestinationSelected: (index) =>
              controller.selectedIndex.value = index,
              backgroundColor: darkMode ? TColors.black : Colors.white,
          destinations: [
            NavigationDestination(icon: Icon(Icons.home), label: 'Acceuil'),
            NavigationDestination(
                icon: Icon(Icons.view_agenda), label: 'Programme'),
            NavigationDestination(
                icon: Icon(Icons.vertical_distribute), label: 'Validation'),
            NavigationDestination(icon: Icon(Icons.payment), label: 'Paiement'),
            NavigationDestination(icon: Icon(Icons.person), label: 'Compte'),
          ],
        ),
      ),
      body: Obx(() => controller.screens[controller.selectedIndex.value]),
    );
  }
}

class NavigationController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;

  final screens = [
    const HomePage(),
    const Programme(),
    const ValidationPage(),
    const PaiementPage(),
    const ComptePage(),
  ];
}
