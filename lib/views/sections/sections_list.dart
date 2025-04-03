import 'package:auster_education/views/D.M.L.T/dmlt_section.dart';
import 'package:auster_education/views/D_Pharmacy/d_pharmacy_section.dart';
import 'package:auster_education/views/DegreeCollege/degree_section.dart';
import 'package:auster_education/views/Jr.College/jrCollege.dart';
import 'package:auster_education/views/schoolSection/school_section.dart';
import 'package:auster_education/views/sections/sections.dart';
import 'package:flutter/material.dart';

class SectionListView extends StatefulWidget {
  const SectionListView({Key? key}) : super(key: key);

  @override
  _SectionListViewState createState() => _SectionListViewState();
}

class _SectionListViewState extends State<SectionListView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sections"),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.search_rounded)),
        ],
      ),
      body: ListView.builder(
          itemCount: studentsSection.length,
          itemBuilder: (context, index) {
            return Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: BorderSide(color: Colors.black, width: 2)),
              color: Colors.deepPurpleAccent,
              child: ListTile(
                leading: studentsSectionIcon[index],
                title: Text(
                  "${studentsSection[index]}",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontStyle: FontStyle.italic),
                ),
                onTap: () {
                  _navigator(index);
                },
              ),
            );
          }),
    );
  }

  _navigator(int index) {
    switch (index) {
      case 0:
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => SchoolSectionView()));

        break;
      case 1:
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => DMLTSectionView()));

        break;
      case 2:
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => DPharmacySectionView()));

        break;
      case 3:
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => JRCollegeSectionView()));

        break;
      case 4:
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => DegreeSectionView()));

        break;
      default:
    }
  }
}
