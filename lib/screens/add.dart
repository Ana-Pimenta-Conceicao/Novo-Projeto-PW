import 'package:flutter/material.dart';
import 'package:appcrudsqlite/data/dblivros.dart';

class Add extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _Add();
  }
}

class _Add extends State<Add> {
  TextEditingController titulo = TextEditingController();

  TextEditingController autor = TextEditingController();

  TextEditingController genero = TextEditingController();

  TextEditingController preco = TextEditingController();

  TextEditingController roll_no = TextEditingController();

  //test editing controllers for form

  DbLivros mydb = DbLivros(); //mydb new object from db.dart

  @override
  void initState() {
    mydb.open(); //initilization database

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Inserir Livros"),
        ),
        body: Container(
          padding: EdgeInsets.all(30),
          child: Column(
            children: [
              TextField(
                controller: titulo,
                decoration: const InputDecoration(
                  hintText: "Título",
                ),
              ),
               TextField(
                controller: autor,
                decoration: const InputDecoration(
                  hintText: "Autor",
                ),
              ),
              TextField(
                controller: genero,
                decoration: const InputDecoration(
                  hintText: "Gênero",
                ),
              ),
               TextField(
                controller: preco,
                decoration: const InputDecoration(
                  hintText: "Preço(R\$)",
                ),
              ),
              TextField(
                controller: roll_no,
                decoration: const InputDecoration(
                  hintText: "Código",
                ),
              ),
             
              ElevatedButton(
                  onPressed: () {
                    mydb.db.rawInsert(
                        "INSERT INTO livro(titulo, autor, genero, preco, roll_no) VALUES (?, ?, ?, ?, ?);",
                        [
                          titulo.text,
                          autor.text,
                          genero.text,
                          preco.text,
                          roll_no.text                      

                        ]); //add student from form to database

                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Livro Adicionado")));

                    titulo.text = "";
                    autor.text = "";
                    genero.text = "";
                    preco.text = "";
                    roll_no.text = "";
                  },
                  child: Text("Salvar Livro")),
            ],
          ),
        ));
  }
}
