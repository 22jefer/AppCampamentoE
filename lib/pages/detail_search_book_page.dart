import 'package:campamento_estelar/models/result.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DetailSearchBookPage extends StatelessWidget {
  final Items book;

  const DetailSearchBookPage(this.book);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(book.volumeInfo?.title ?? "Detalle"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            Image.network(
              book.volumeInfo?.imageLinks?.smallThumbnail ?? "",
              errorBuilder: (BuildContext context, Object exception,
                StackTrace? stackTrace) {
                  return const Image(image: AssetImage("assets/images/logo.png")
              );
            },
          ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Autor: ${book.volumeInfo?.authors?[0]}",
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 17.0, fontStyle: FontStyle.italic),
            ),
          ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Publicado el : ${book.volumeInfo?.publishedDate?[0]}",
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 17.0, fontStyle: FontStyle.italic),
            ),
          ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
              book.volumeInfo?.description ?? "No hay descripcion",
              textAlign: TextAlign.justify,
              style: const TextStyle(
                  fontSize: 17.0, fontStyle: FontStyle.italic),
            ),
          ),
          ],
        ),),
    ),);
  }
}
