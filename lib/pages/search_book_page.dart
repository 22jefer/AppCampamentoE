import 'package:campamento_estelar/models/result.dart';
import 'package:campamento_estelar/repository/books_api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'detail_search_book_page.dart';

class SearchBookPage extends StatefulWidget {
  const SearchBookPage({Key? key}) : super(key: key);

  @override
  State<SearchBookPage> createState() => _SearchBookPageState();
}

class _SearchBookPageState extends State<SearchBookPage> {

  BookApi _bookApi = BookApi();

  final _parametro = TextEditingController();

  List<Items> listBooks = <Items> [];

  Future _searchBooks() async {

    Result resultFuture = await _bookApi.getBooks(_parametro.text);
    setState(() {
      resultFuture.items?.forEach((element) {
        listBooks.add(element);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Google Api Books"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 7 ),
        child: Center(
          child: Column(children: [
            TextFormField(
              controller: _parametro,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Ingrese un autor o Titulo"),
              keyboardType: TextInputType.text,
            ),
            const SizedBox(
              height: 15.0,
            ),
            ElevatedButton(
                style: TextButton.styleFrom(
                    textStyle: const TextStyle(fontSize: 20)
                ),
                onPressed: (){
                  _searchBooks();
                },
                child: const Text("Buscar libro")
            ),
            //Pintar Busqueda
            Expanded(
              child: ListView.builder(
                itemCount: listBooks.length,
                itemBuilder: (BuildContext context, int index) {
                  Items book = listBooks[index];
                  return Card(
                    child: ListTile(
                      leading: Image.network(
                        book.volumeInfo?.imageLinks?.smallThumbnail ?? "",
                        errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                          return const Image(image: AssetImage("assets/images/logo.png")
                          );
                        },
                      ),
                      title: Text(book.volumeInfo?.title ?? "No title"),
                      subtitle: Text(book.volumeInfo?.publishedDate ?? "No publishedDate"),
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => DetailSearchBookPage(book)));
                      },
                    ),
                  );
                },
              ),
            ),
          ],),
        ),
      ),
    );
  }
}


