import 'dart:io';
import 'dart:convert';
import 'package:firstapp/localdb.dart';
import 'package:firstapp/models/fichesurveillance.dart';
import 'package:firstapp/vues/delegue/pagepdf.dart';
import 'package:firstapp/vues/prof/pdfsurveillance.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class PagePdfSurveillance extends StatefulWidget {
  const PagePdfSurveillance({
    Key? key,
    required this.chefSalle,
    required this.salle,
    required this.date,
    required this.session,
    required this.codeCours,
    required this.intitule,
    required this.confidentialite,
  }) : super(key: key);

  final String chefSalle;
  final String salle;
  final DateTime date;
  final String session;
  final String codeCours;
  final String intitule;
  final int confidentialite;

  @override
  State<PagePdfSurveillance> createState() {
    return _PagePdfSurveillance();
  }
}

class _PagePdfSurveillance extends State<PagePdfSurveillance> {
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
                final directory = await getExternalStorageDirectory();
                const dossierPers = 'ICT FOLLOW UP/fiches de surveillance';
                final cheminPers = '${directory?.path}/$dossierPers';
                if (!Directory(cheminPers).existsSync()) {
                  Directory(cheminPers).createSync();
                }
                final fichePdf = pw.Document();
                Directory dossier = Directory(cheminPers);
                List<FileSystemEntity> element = await dossier.list().toList();
                int nombreFiche = element.length;
                final cheminpdf = '$cheminPers/fiche $nombreFiche.pdf';

                final file = File(cheminpdf);

                FicheSurveillance ficheSurveillance = FicheSurveillance(
                    chefDeSalle: widget.chefSalle,
                    salle: widget.salle,
                    date: widget.date,
                    session: widget.session,
                    codeCours: widget.codeCours,
                    intituleUE: widget.intitule,
                    confirmation: true);

                // ignore: use_build_context_synchronously
                await LocalDataBase(context)
                    .addFicheSurveillance(ficheSurveillance, context);

                final ByteData data =
                    await rootBundle.load("assets/images/logouniv.jpg");
                Uint8List image = Uint8List.fromList(data.buffer.asInt8List());
                fichePdf.addPage(
                  pw.MultiPage(
                    pageFormat: PdfPageFormat.a4,
                    build: (context) {
                      return [
                        PdfSurveillance(
                            chefSalle: widget.chefSalle,
                            salle: widget.salle,
                            date: widget.date,
                            session: widget.session,
                            codeCours: widget.codeCours,
                            intitule: widget.intitule,
                            confirmation: widget.confidentialite,
                            logo: image)
                      ];
                    },
                  ),
                );

                // ignore: use_build_context_synchronously
                showCupertinoModalPopup(
                  context: context,
                  builder: (_) {
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
                              Navigator.of(context).pop();
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

                await file.writeAsBytes(await fichePdf.save());
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
                          "BLABLABLA",
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
                          "BLABLABLA",
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
                  "FICHE DE SURVEILLANCE ",
                  style: TextStyle(
                      fontSize: 30,
                      fontFamily: 'Times New Roman',
                      fontWeight: FontWeight.w300),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              MyWidgetSec(
                  text: "Chef de salle :",
                  content: widget.chefSalle,
                  un: 1,
                  deux: 2),
              const SizedBox(
                height: 10,
              ),
              MyWidgetSec(
                  text: "Salle :", content: widget.salle, un: 1, deux: 2),
              const SizedBox(
                height: 10,
              ),
              MyWidgetSec(
                  text: "Date :",
                  content: widget.date.toString(),
                  un: 1,
                  deux: 1),
              const SizedBox(
                height: 10,
              ),
              MyWidgetSec(
                  text: "Session :", content: widget.session, un: 1, deux: 2),
              const SizedBox(
                height: 10,
              ),
              MyWidgetSec(
                  text: "Code de l'unité d'enseignement :",
                  content: widget.codeCours,
                  un: 2,
                  deux: 1),
              const SizedBox(
                height: 10,
              ),
              MyWidgetSec(
                  text: "Intitulé de l'unité d'enseignement :",
                  content: widget.intitule,
                  un: 1,
                  deux: 1)
            ],
          ),
        ),
      ),
    );
  }
}