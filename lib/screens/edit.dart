import 'package:flutter/material.dart';
import 'package:appcrudsqlite/data/dblivros.dart';

class EditLivro extends StatefulWidget {
  int rollno;

  EditLivro({required this.rollno}); //constructor for class

  @override
  State<StatefulWidget> createState() {
    return _EditLivro();
  }
}

class _EditLivro extends State<EditLivro> {
  TextEditingController titulo = TextEditingController();

  TextEditingController rollno = TextEditingController();

   TextEditingController autor = TextEditingController();

  TextEditingController genero = TextEditingController();

  TextEditingController preco = TextEditingController();

  DbLivros mydb = new DbLivros();

  @override
  void initState() {
    mydb.open();

    Future.delayed(Duration(milliseconds: 500), () async {
      var data = await mydb.getLivro(
          widget.rollno); //widget.rollno is passed paramater to this class

      if (data != null) {
        titulo.text = data["titulo"];

        rollno.text = data["roll_no"].toString();

        autor.text = data["autor"];

        genero.text = data["genero"];

        preco.text = data["preco"];

        setState(() {});
      } else {
        print("Não encontrado dados com roll no: " + widget.rollno.toString());
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Editar Livros"),
        ),
        body: Container(
          padding: EdgeInsets.all(30),
          child: Column(
            children: [
              TextField(
                controller: titulo,
                decoration: InputDecoration(
                  hintText: "Titulo",
                ),
              ),
              TextField(
                controller: rollno,
                decoration: InputDecoration(
                  hintText: "Roll No.",
                ),
              ),
              TextField(
                controller: autor,
                decoration: InputDecoration(
                  hintText: "Autor",
                ),
              ),
              TextField(
                controller: genero,
                decoration: InputDecoration(
                  hintText: "Genero",
                ),
              ),
              TextField(
                controller: preco,
                decoration: InputDecoration(
                  hintText: "Preço(R\$)",
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    mydb.db.rawInsert(
                        "UPDATE livro SET titulo = ?, roll_no = ?, autor = ?, preco = ?, genero = ? WHERE roll_no = ?",
                        [
                          titulo.text,
                          rollno.text,
                          autor.text,
                          preco.text,
                          genero.text,
                          widget.rollno
                        ]);

                    //update table with roll no.

                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Veículo Alterado!")));
                  },
                  child: Text("Alterar Veículo")),
            ],
          ),
        ));
  }
}
