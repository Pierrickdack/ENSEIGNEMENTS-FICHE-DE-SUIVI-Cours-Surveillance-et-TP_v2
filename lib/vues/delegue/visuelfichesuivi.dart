import 'dart:convert';
import 'dart:io';

import 'package:firstapp/localdb.dart';
import 'package:firstapp/models/fiche.dart';
import 'package:firstapp/vues/delegue/pagepdf.dart';
import 'package:firstapp/vues/delegue/pdfwidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class VisuelFicheSuivi extends StatefulWidget {
  const VisuelFicheSuivi({Key? key, required this.fiche}) : super(key: key);

  final Fiche fiche;

  State<VisuelFicheSuivi> createState() {
    return _VisuelFicheSuivi();
  }
}

class _VisuelFicheSuivi extends State<VisuelFicheSuivi> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            "APERCU",
            style: TextStyle(fontSize: 22, color: Colors.white),
          ),
          backgroundColor: const Color.fromARGB(255, 2, 53, 95),
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          actions: [
            TextButton(
              onPressed: () async {
                EasyLoading.init();
                final directory = await getExternalStorageDirectory();
                const dossierPers = 'ICT FOLLOW UP/fiches de suivi';
                final cherminPers = '${directory?.path}/$dossierPers';
                if (!Directory(cherminPers).existsSync()) {
                  Directory(cherminPers).createSync();
                }
                final fichepdf = pw.Document();
                Directory dossier = Directory(cherminPers);
                List<FileSystemEntity> element = await dossier.list().toList();
                int nombreFiche = element.length;
                final cheminpdf = '$cherminPers/fiche $nombreFiche.pdf';
                /*if (a != 0) {
                  File(cheminpdf).deleteSync();
                }*/
                final file = File(cheminpdf);

                final ByteData data =
                    await rootBundle.load("assets/images/logouniv.jpg");
                Uint8List image = Uint8List.fromList(
                  data.buffer.asUint8List(),
                );
                fichepdf.addPage(
                  pw.MultiPage(
                    pageFormat: PdfPageFormat.a4,
                    build: (context) {
                      return [Personal(fiche: widget.fiche, logo: image)];
                    },
                  ),
                );

                // ignore: use_build_context_synchronously
                showCupertinoModalPopup(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text(
                        "Confirmation",
                        style: TextStyle(
                          color: Colors.green,
                          fontSize: 30,
                        ),
                      ),
                      content: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            "Vous avez enregistré la fiche avec succès dans l'appareil",
                            style: TextStyle(fontSize: 16),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.green),
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text(
                              "OK",
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
                /*Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => DashboardDelegue()),
                );*/
                await file.writeAsBytes(await fichepdf.save());
              },
              child: const Text(
                "Enregistrer",
                style: TextStyle(
                  fontSize: 18,
                  color: Color.fromARGB(255, 206, 205, 205),
                ),
              ),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              Container(
                margin: const EdgeInsets.only(left: 15, right: 15),
                child: Row(
                  children: [
                    const Column(
                      children: [
                        Text(
                          "REPUBLIQUE DU CAMEROUN",
                          style: TextStyle(fontSize: 10, fontFamily: 'Arial'),
                        ),
                        Text(
                          "PAIX-TRAVAIL-PATRIE",
                          style: TextStyle(fontSize: 10, fontFamily: 'Arial'),
                        ),
                        Text(
                          "REPUBLIQUE DU CAMEROUN",
                          style: TextStyle(fontSize: 10),
                        )
                      ],
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Image.asset(
                      "assets/images/logouniv.jpg",
                      width: 90,
                      height: 90,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Column(
                      children: [
                        Text(
                          "REPUBLIQUE DU CAMEROUN",
                          style: TextStyle(fontSize: 10),
                        ),
                        Text(
                          "PAIX-TRAVAIL-PATRIE",
                          style: TextStyle(fontSize: 10),
                        ),
                        Text(
                          "REPUBLIQUE DU CAMEROUN",
                          style: TextStyle(fontSize: 10),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              const Center(
                child: Text(
                  "FICHE DE SUIVI ",
                  style: TextStyle(
                      fontSize: 30,
                      fontFamily: 'Times New Roman',
                      fontWeight: FontWeight.w300),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              MyWidget(
                  text: "Nom du professeur: ",
                  content: widget.fiche.enseignant),
              const SizedBox(
                height: 10,
              ),
              MyWidget(
                  text: "Code de la matière : ",
                  content: widget.fiche.codeCours),
              const SizedBox(
                height: 10,
              ),
              MyWidgetSec(
                text: "Titre de la séance : \n",
                content: widget.fiche.titreSeance,
                un: 1,
                deux: 2,
              ),
              const SizedBox(
                height: 10,
              ),
              MyWidget(
                  text: "Numéro de la salle : ", content: widget.fiche.salle),
              const SizedBox(
                height: 10,
              ),
              MyWidget(
                  text: "Heure de debut :",
                  content: widget.fiche.heureDebut.format(context)),
              const SizedBox(
                height: 10,
              ),
              MyWidget(
                  text: "Heure de fin :",
                  content: widget.fiche.heureFin.format(context)),
              const SizedBox(
                height: 10,
              ),
              MyWidget(text: "Date :", content: widget.fiche.date.toString()),
              const SizedBox(
                height: 10,
              ),
              MyWidget(
                  text: "Durée :",
                  content: widget.fiche.totalHeures.format(context)),
              const SizedBox(
                height: 10,
              ),
              MyWidget(
                  text: "Semestre : ",
                  content: widget.fiche.semestre.toString()),
              const SizedBox(
                height: 10,
              ),
              MyWidget(
                  text: "Nature du cours : ", content: widget.fiche.typeSeance),
              const SizedBox(
                height: 10,
              ),
              MyWidgetSec(
                  text: "Contenu : \n",
                  content: widget.fiche.contenu,
                  un: 1,
                  deux: 2),
              MyWidgetImg(
                  text: "Signature du professeur : ",
                  content: base64Decode(widget.fiche.signatureProf),
                  un: 1,
                  deux: 2),
              MyWidgetImg(
                  text: "Signature du Delegué : ",
                  content: base64Decode(widget.fiche.signatureDelegue),
                  un: 1,
                  deux: 2)
            ],
          ),
        ),
      ),
    );
  }
}