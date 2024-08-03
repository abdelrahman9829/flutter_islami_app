import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:islami_app/ui/home/tabs/quran_tab/quran_detalis/verses.dart';
import 'package:islami_app/ui/home/tabs/quran_tab/sura_title.dart';

class QuranDetails extends StatefulWidget {
  static const String routeName = '/quran';

  @override
  State<QuranDetails> createState() => _QuranDetailsState();
}

class _QuranDetailsState extends State<QuranDetails> {
  List<String> verses = [];

  @override
  Widget build(BuildContext context) {
    SuraArguments arguments =
        ModalRoute.of(context)?.settings.arguments as SuraArguments;
    if (verses.isEmpty) loadFile(arguments.index);
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.fill, image: AssetImage('assets/images/bg3.png'))),
      child: Scaffold(
        appBar: AppBar(
          title: Text('سورة ${arguments.suraTitle}'),
        ),
        body: verses.isEmpty
            ? Center(child: CircularProgressIndicator())
            : ListView.separated(
                itemBuilder: (context, index) => Verses(verse: verses[index]),
                separatorBuilder: (context, index) => Divider(
                      color: Color(0xFFB7935F),
                    ),
                itemCount: verses.length),
      ),
    );
  }

  void loadFile(int index) async {
    String fileContent =
        await rootBundle.loadString('assets/files/${index + 1}.txt');
    List<String> suraLines = fileContent.split('\n');
    verses = suraLines;
    verses.forEach(
      (element) => print(element),
    );
    setState(() {});
  }
}
