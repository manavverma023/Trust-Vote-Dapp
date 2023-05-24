// import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class VoterProfile extends StatefulWidget {
  const VoterProfile({Key? key}) : super(key: key);

  @override
  _VoterProfileState createState() => _VoterProfileState();
}

class _VoterProfileState extends State<VoterProfile> {
  String? email;
  String? publicKey;
  String? joindate;
  bool loading = true;

  fetchData() async {
    if (FirebaseAuth.instance.currentUser != null) {
      email = FirebaseAuth.instance.currentUser!.email;
      DocumentSnapshot<Map<String, dynamic>> userSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(email)
          .get();
      if (userSnapshot.exists) {
        publicKey = userSnapshot.data()?['publicKey'] as String;
        String jd = userSnapshot.data()?['joiningDate'] as String;
        joindate = jd.substring(0,10);
        //print(joindate);
      }
      setState(() => loading = false);
    
  }}

  @override
  void initState() {
    // TODO: implement initState
    email = FirebaseAuth.instance.currentUser!.email;
    super.initState();
    fetchData();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      padding: const EdgeInsets.only(top: 10, bottom: 10, left: 15, right: 15),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
      child: Card(
        elevation: 0.5,
        color: Colors.lightBlue[100],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: ListView(children: <Widget>[
              const SizedBox(height: 50),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.black, width: 1.5)),
                child: Center(
                //     child: CachedNetworkImage(
                //   width: 150,
                //   height: 150,
                //   imageUrl: "http://placebeard.it/640",
                //   fit: BoxFit.fitHeight,
                //   placeholder: (context, url) => CircularProgressIndicator(),
                // )
                    child: Icon(Icons.person,
                        size: 170, color: Theme.of(context).accentColor),
                    ),
              ),
              const SizedBox(height: 50),
              const Center(
                child: Text('VOTER EMAIL',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Colors.black)),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 12),
                child: Center(
                    child: Text(email ?? "Email",
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: Colors.grey))),
              ),
              const SizedBox(height: 20),
              const Center(
                child: Text('VOTER WALLET ADDRESS',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Colors.black)),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 12),
                child: Center(
                    child: Text(publicKey ?? "Public Key",
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: Colors.grey))),
              ),
              const SizedBox(height: 20),

              const Center(
                child: Text('JOINED ON:',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Colors.black)),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 12),
                child: Center(
                    child: Text(joindate ?? "joining date",
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: Colors.grey))),
              ),
              const SizedBox(height: 20),
              // Center(
              //   child: Text('VOTED TOWARDS',
              //       style: TextStyle(
              //           fontSize: 20,
              //           fontWeight: FontWeight.w700,
              //           color: Colors.black)),
              // ),
              // Padding(
              //   padding: const EdgeInsets.symmetric(
              //       vertical: 10.0, horizontal: 12),
              //   child: Center(
              //       child: Text(
              //           state.voterProfile.voteTowards == 0
              //               ? ( BigInt.parse(state.voterProfile
              //                       .delegateAddress)
              //                   .toInt() ==
              //               0 ? "Not voted yet" : "Vote delegated")
              //               : state.voterProfile.voteTowards
              //                   .toString(),
              //           textAlign: TextAlign.center,
              //           style: TextStyle(
              //               fontSize: 20,
              //               fontWeight: FontWeight.w700,
              //               color: Theme.of(context)
              //                   .accentColor))),
              // ),
              const SizedBox(
                height: 20,
              ),
            ])),
      ),
    ));
  }
}