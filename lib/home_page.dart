// import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:places_in_jakarta/remote_service.dart';
import 'package:places_in_jakarta/model/places.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Places in Jakarta'),
        centerTitle: true,
      ),
      body: FutureBuilder<List<Place>>(
        future: callService().callNetwork(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Center(
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data!.length,
                  itemBuilder: (BuildContext, index) {
                    //print(snapshot.data?[index].photo?.constructImageUrl());
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Card(
                        child: Container(
                            padding: EdgeInsets.all(10),
                            // height: 400,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              // crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                snapshot.data?[index].photo != null
                                    ? Image(
                                        height: 300,
                                        image: NetworkImage(snapshot
                                            .data![index].photo!
                                            .constructImageUrl()))
                                    : Image.asset('asset/placeholderImage.png',
                                        height: 300),
                                SizedBox(
                                  height: 5,
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    snapshot.data![index].name,
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                // SizedBox(
                                //   height: 10,
                                // ),
                                Row(
                                  //crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children:
                                              snapshot.data![index].categories
                                                  .map((cat) => Container(
                                                        // height: 265,
                                                        // alignment: Alignment.center,
                                                        child: Text(
                                                          cat.name,
                                                        ),
                                                      ))
                                                  .toList()),
                                    ),

                                    if (snapshot.data?[index].rating != null)
                                      Container(
                                        // color: Colors.grey.withOpacity(0.1),
                                        alignment: Alignment.center,
                                        padding: EdgeInsets.all(3),
                                        child: Text(
                                          snapshot.data?[index].rating != null
                                              ? snapshot.data![index].rating
                                                  .toString()
                                              : '',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        decoration: BoxDecoration(
                                            color:
                                                Colors.green.withOpacity(0.5)),
                                      )
                                    // else
                                    //   Visibility(
                                    //       visible: true,
                                    //       child: Container(child: null)),

                                    // Container(
                                    //   //color: Colors.grey.withOpacity(0.1),
                                    //   alignment: Alignment.center,
                                    //   padding: EdgeInsets.all(3),

                                    //   child: Text(
                                    //     snapshot.data?[index].rating != null
                                    //         ? snapshot.data![index].rating
                                    //             .toString()
                                    //         : "",
                                    //     style: TextStyle(
                                    //         fontWeight: FontWeight.bold),
                                    //   ),
                                    //   decoration: BoxDecoration(
                                    //       color: Colors.grey.withOpacity(0.5)),
                                    // )
                                  ],
                                )
                              ],
                            )),
                      ),
                    );
                  }),
            );
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }
          return Text('....');
        },
      ),
    );
  }
}
