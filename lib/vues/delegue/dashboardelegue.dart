import 'dart:io';

import 'package:firstapp/vues/delegue/fiche_suivi.dart';
import 'package:firstapp/vues/delegue/fiches.dart';
import 'package:firstapp/vues/delegue/fichetravaux.dart';
import 'package:firstapp/vues/delegue/profile.dart';
import 'package:flutter/material.dart';
import 'package:firstapp/models/fiche.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:path_provider/path_provider.dart';

class DashboardDelegue extends StatefulWidget {
  const DashboardDelegue({super.key});

  @override
  State<DashboardDelegue> createState() {
    return _DashboardDelegue();
  }
}

class _DashboardDelegue extends State<DashboardDelegue> {
  List<Fiche>? fiches;
  TextEditingController search = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 2, 53, 95),
          title: const Text(
            "ACCUEIL",
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
        ),
        body: Container(
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 189, 209, 243),
          ),
          child: ListView(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 40),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.90,
                    height: MediaQuery.of(context).size.height * 0.08,
                    margin: const EdgeInsets.all(25),
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 254, 250, 213),
                      border: Border(
                        top: BorderSide(color: Colors.yellow, width: 3.0),
                        left: BorderSide(color: Colors.yellow, width: 3.0),
                        bottom: BorderSide(color: Colors.yellow, width: 3.0),
                        right: BorderSide(color: Colors.yellow, width: 3.0),
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    child: Row(
                      children: [
                        const Text(
                          "FICHE DE SUIVI",
                          style: TextStyle(fontSize: 18),
                        ),
                        const Spacer(),
                        IconButton(
                          icon: const Icon(Icons.add),
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => const FicheSuivi(),
                              ),
                            );
                          },
                          iconSize: 35,
                          style: ButtonStyle(
                            visualDensity:
                                const VisualDensity(horizontal: 0, vertical: 0),
                            alignment: Alignment.centerLeft,
                            iconColor: MaterialStateProperty.all(Colors.yellow),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(10),
                    padding: const EdgeInsets.only(left: 30, right: 30),
                    child: const Text(
                      "Cette fiche permet de suivre les informations importantes concernant une séance d'enseignement.",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.90,
                    height: MediaQuery.of(context).size.height * 0.08,
                    margin: const EdgeInsets.all(25),
                    padding: const EdgeInsets.only(left: 20, right: 10),
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 202, 229, 251),
                      border: Border(
                        top: BorderSide(color: Colors.blue, width: 2.0),
                        left: BorderSide(color: Colors.blue, width: 2.0),
                        bottom: BorderSide(color: Colors.blue, width: 2.0),
                        right: BorderSide(color: Colors.blue, width: 2.0),
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    child: Row(
                      children: [
                        const Flexible(
                          flex: 3,
                          child: Text(
                            "FICHE DE TRAVAUX PRATIQUES",
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                        const Spacer(),
                        IconButton(
                          icon: const Icon(Icons.add),
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => const FicheTravaux(),
                              ),
                            );
                          },
                          iconSize: 35,
                          style: ButtonStyle(
                            visualDensity:
                                const VisualDensity(horizontal: 0, vertical: 0),
                            alignment: Alignment.centerRight,
                            iconColor: MaterialStateProperty.all(Colors.blue),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(10),
                    padding: const EdgeInsets.only(left: 30, right: 30),
                    child: const Text(
                      "Cette fiche est conçue pour enregistrer les details des travaux pratiques réalisés en laboratoires ou en salle spécialisée.",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        bottomNavigationBar: Container(
          decoration:
              const BoxDecoration(color: Color.fromARGB(127, 189, 187, 187)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                padding: const EdgeInsets.only(left: 20, right: 20),
                iconSize: 40,
                color: const Color.fromARGB(255, 5, 48, 69),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => const DashboardDelegue(),
                    ),
                  );
                },
                icon: const Icon(Icons.home),
              ),
              IconButton(
                padding: const EdgeInsets.only(left: 20, right: 20),
                iconSize: 40,
                color: const Color.fromARGB(255, 5, 48, 69),
                onPressed: () async {
                  List<String> pdfname = await readPdf();
                  // ignore: use_build_context_synchronously
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => Fiches(
                        pdfname: pdfname,
                      ),
                    ),
                  );
                },
                icon: const Icon(Icons.book),
                style: ButtonStyle(
                    iconSize: MaterialStateProperty.all(30),
                    iconColor: MaterialStateProperty.all(Colors.purple)),
              ),
              IconButton(
                padding: const EdgeInsets.only(left: 20, right: 20),
                iconSize: 40,
                color: const Color.fromARGB(255, 5, 48, 69),
                onPressed: () {},
                icon: const Icon(Icons.delete),
                style: ButtonStyle(
                    iconSize: MaterialStateProperty.all(30),
                    iconColor: MaterialStateProperty.all(Colors.purple)),
              ),
              IconButton(
                padding: const EdgeInsets.only(left: 20, right: 20),
                iconSize: 40,
                color: const Color.fromARGB(255, 5, 48, 69),
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (_) => const Profile()));
                },
                icon: const Icon(Icons.person),
                style: ButtonStyle(
                    iconSize: MaterialStateProperty.all(30),
                    iconColor: MaterialStateProperty.all(Colors.purple)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Future<List<String>> readPdf() async {
  List<String> pdfText = [];
  //final directory = await getExternalStorageDirectories();
  final directory = await getApplicationDocumentsDirectory();
  const dossierPers = 'ICT FOLLOW UP';
  final cherminPers = '${directory.path}/$dossierPers';
  if (!Directory(cherminPers).existsSync()) {
    Directory(cherminPers).createSync();
  }
  print("entrée ");
  try {
    await for (var file in Directory(cherminPers).list()) {
      print("chemin d'accès");
      if (file.path.endsWith('.pdf')) {
        //final List<int> bytes = await File(file.path).readAsBytes();
        String fileName = file.uri.pathSegments.last;
        for (int i = 0; i < pdfText.length; i++) {
          if (!pdfText.contains(fileName)) {
            pdfText.add(fileName);
          }
        }
      }
    }
  } catch (Exep) {
    print("une exception est arrivée");
  }

  return pdfText;
}