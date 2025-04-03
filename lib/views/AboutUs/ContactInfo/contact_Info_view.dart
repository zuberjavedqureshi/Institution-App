import 'package:flutter/material.dart';

class ContactInfoView extends StatefulWidget {
  const ContactInfoView({Key? key}) : super(key: key);

  @override
  _ContactInfoViewState createState() => _ContactInfoViewState();
}

class _ContactInfoViewState extends State<ContactInfoView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurpleAccent,
      appBar: AppBar(
        title: Text(
          "About Us",
          style: TextStyle(color: Colors.white),
        ),
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        children: [
          Center(
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width * .90,
                    height: 200,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.white, width: 2),
                        borderRadius: BorderRadius.circular(20)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Auster Education, Mumbai was established in the year 2009-2010 at Mumbai to provide correspondence education. In India, where individuals and their number one foundations are isolated by huge spans, frequently discouraging the standard kind of training, the distance instruction mode will end up being helpful by and large.",
                        style: TextStyle(color: Colors.white, fontSize: 17),
                        textAlign: TextAlign.justify,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Image(image: AssetImage("images/logo-02-removebg.png"))
        ],
      ),
    );
  }
}
