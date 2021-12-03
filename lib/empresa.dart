import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'login_page.dart';
 import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
List? listaEstoque=<Estoque>[];
int qtdd=0;
int idd=0;
String nome='';
// ignore: camel_case_types
class empresa extends StatefulWidget {
  @override
  _empresaState createState() => _empresaState();
  
}

//Color.fromRGBO(195, 193, 193, 1),
// ignore: camel_case_types
class _empresaState extends State<empresa> {
  @override
  Widget build(BuildContext context) {
    _listarEstoque();
    return Scaffold(
        appBar: AppBar(title: Text('Empresa')),
        backgroundColor: Color.fromRGBO(195, 193, 193, 1),
        body: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height * .15,
            decoration: BoxDecoration(
              image: DecorationImage(
                
                image: AssetImage("imagens/pgi.PNG"),
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * .93,
            height: MediaQuery.of(context).size.height * 0.07,
            child: RaisedButton(
              shape: RoundedRectangleBorder(side: BorderSide(color: Colors.black)),
              onPressed: () {
               
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => cadastro()));

                //print("dados: ${widget.id} ${widget.nome} ${widget.qtd}");
              },
              child: Text(
                'Cadastrar Produto',
                style: TextStyle(fontSize: 20),
              ),
              color: Colors.lightBlue[100],
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * .93,
            height: MediaQuery.of(context).size.height * 0.07,
            child: RaisedButton(
              shape: RoundedRectangleBorder(side: BorderSide(color: Colors.black)),
              onPressed: () {
                
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => exclusao()));
              },
              child: Text(
                'Excluir produto',
                style: TextStyle(fontSize: 20),
              ),
              color: Colors.lightBlue[100],
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * .93,
            height: MediaQuery.of(context).size.height * .07,
            child: RaisedButton(
              shape: RoundedRectangleBorder(side: BorderSide(color: Colors.black)),
              onPressed: () {
                
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => remocao()));
              },
              child: Text(
                'Remover Produto do estoque',
                style: TextStyle(fontSize: 20),
              ),
              color: Colors.lightBlue[100],
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * .93,
            height: MediaQuery.of(context).size.height * .07,
            child: RaisedButton(
              shape: RoundedRectangleBorder(side: BorderSide(color: Colors.black)),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => adicao()));
              },
              child: Text(
                'Adicionar Produto ao estoque',
                style: TextStyle(fontSize: 20),
              ),
              color: Colors.lightBlue[100],
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * .93,
            height: MediaQuery.of(context).size.height * .07,
            child: RaisedButton(
              shape: RoundedRectangleBorder(side: BorderSide(color: Colors.black)),
              onPressed: () {
                
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => verestoque()));
              },
              child: Text(
                'Ver estoque',
                style: TextStyle(fontSize: 20),
              ),
              color: Colors.lightBlue[100],
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * .93,
            height: MediaQuery.of(context).size.height * .07,
            child: RaisedButton(
              shape: RoundedRectangleBorder(side: BorderSide(color: Colors.black)),
              onPressed: () {
                
                 Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => LoginPage()));
              },
              child: Text(
                'Perfil',
                style: TextStyle(fontSize: 20),
              ),
              color: Colors.lightBlue[100],
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * .4,
            height: MediaQuery.of(context).size.height * .18,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("imagens/Iconeempresatargethost1.png"),
                fit: BoxFit.fitWidth,
              ),
            ),
          )
        ]));
  }
}

//tela cadastro produto
//////////////////////////////////////////////////////////////////////////////////////

class cadastro extends StatefulWidget {
  const cadastro({Key? key}) : super(key: key);

  @override
  _cadastroState createState() => _cadastroState();
}

//Color.fromRGBO(195, 193, 193, 1),
// ignore: camel_case_types
class _cadastroState extends State<cadastro> {
  @override
  Widget build(BuildContext context) {
    //TextEditingController _controllerid = TextEditingController();
    String identificador='';
    return Scaffold(
        appBar: AppBar(title: Text('Cadastrar Produto')),
        backgroundColor: Color.fromRGBO(195, 193, 193, 1),
        body: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: ListView(shrinkWrap: true, scrollDirection: Axis.vertical, children: <Widget>[
              Column(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
                SizedBox(height: MediaQuery.of(context).size.height * .2),
                SizedBox(
                  width: MediaQuery.of(context).size.width * .89,
                  child: TextField(
                      
                      onChanged: (text) {
                        nome = text;
                      },
                      
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        enabledBorder: const OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.lightBlue, width: 2),
                        ),
                        contentPadding: EdgeInsets.fromLTRB(5, 40, 5, 0),
                        labelText: 'Nome do produto',
                        border: OutlineInputBorder(),
                      )),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * .05),
                SizedBox(
                  width: MediaQuery.of(context).size.width * .89,
                  child: TextField(
                     onChanged: (text) {
                        
                        identificador = text;
                        idd = int.parse(identificador);
                      },
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        enabledBorder: const OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.lightBlue, width: 2),
                        ),
                        contentPadding: EdgeInsets.fromLTRB(5, 40, 5, 0),
                        labelText: 'ID do produto',
                        border: OutlineInputBorder(),
                      )),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * .05),
                SizedBox(
                  width: MediaQuery.of(context).size.width * .89,
                  height: MediaQuery.of(context).size.height * .08,
                  // ignore: deprecated_member_use
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(side: BorderSide(color: Colors.blue)),
                    onPressed: () async {
                        String code = await FlutterBarcodeScanner.scanBarcode("#B3E5FC", "Cancelar",true, ScanMode.QR);
                         idd=int.parse(code.toString());
                    },
                    child: Text(
                      'QR Code',
                      style: TextStyle(fontSize: 25),
                    ),
                    color: Colors.lightBlue[100],
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * .27),
                SizedBox(
                  width: MediaQuery.of(context).size.width * .4,
                  height: MediaQuery.of(context).size.height * .08,
                  // ignore: deprecated_member_use
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(side: BorderSide(color: Colors.blue)),
                    onPressed: () {
                      showAlertDialog1(context);
                      
                      _salvarDados(idd, nome, 0);

                      //Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => empresa(id, produto, qtd)));
                    },
                    child: Text(
                      'Salvar',
                      style: TextStyle(fontSize: 25),
                    ),
                    color: Colors.lightBlue[100],
                  ),
                )
              ])
            ])));
  }
}

//////////////////////////////////////////////////////////////////////////////////////

//tela exclusão produto
//////////////////////////////////////////////////////////////////////////////////////

class exclusao extends StatefulWidget {
  const exclusao({Key? key}) : super(key: key);

  @override
  _exclusaoState createState() => _exclusaoState();
}

//Color.fromRGBO(195, 193, 193, 1),
// ignore: camel_case_types
class _exclusaoState extends State<exclusao> {
  @override
  Widget build(BuildContext context) {
    String identificador = '';
    return Scaffold(
        appBar: AppBar(title: Text('Excluir Produto')),
        backgroundColor: Color.fromRGBO(195, 193, 193, 1),
        body: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: ListView(shrinkWrap: true, scrollDirection: Axis.vertical, children: <Widget>[
              Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, children: <Widget>[
                SizedBox(height: MediaQuery.of(context).size.height * .25),
                SizedBox(
                  width: MediaQuery.of(context).size.width * .89,
                  child: TextField(
                      onChanged: (text) {
                        identificador = text;
                        idd = int.parse(identificador);
                      },
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        enabledBorder: const OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.lightBlue, width: 2),
                        ),
                        contentPadding: EdgeInsets.fromLTRB(5, 40, 5, 0),
                        labelText: 'ID do produto',
                        border: OutlineInputBorder(),
                      )),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * .05),
                SizedBox(
                  width: MediaQuery.of(context).size.width * .89,
                  height: MediaQuery.of(context).size.height * .08,
                  // ignore: deprecated_member_use
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(side: BorderSide(color: Colors.blue)),
                    onPressed: () async {
                        String code = await FlutterBarcodeScanner.scanBarcode("#B3E5FC", "Cancelar",true, ScanMode.QR);
                        idd=int.parse(code.toString());
                    },
                    child: Text(
                      'QR Code',
                      style: TextStyle(fontSize: 25),
                    ),
                    color: Colors.lightBlue[100],
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * .27),
                SizedBox(
                  width: MediaQuery.of(context).size.width * .4,
                  height: MediaQuery.of(context).size.height * .08,
                  // ignore: deprecated_member_use
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(side: BorderSide(color: Colors.blue)),
                    onPressed: () {
                      showAlertDialog2(context);
                      //print("codeeee: $ticket");
                      _excluirProduto(idd);
                    },
                    child: Text(
                      'Excluir',
                      style: TextStyle(fontSize: 25),
                    ),
                    color: Colors.lightBlue[100],
                  ),
                )
              ])
            ])));
  }
}

//////////////////////////////////////////////////////////////////////////////////////

//tela remoção de produto no estoque
//////////////////////////////////////////////////////////////////////////////////////
class remocao extends StatefulWidget {
  const remocao({Key? key}) : super(key: key);

  @override
  _remocaoState createState() => _remocaoState();
}

//Color.fromRGBO(195, 193, 193, 1),
// ignore: camel_case_types
class _remocaoState extends State<remocao> {
  @override
  Widget build(BuildContext context) {
    String identificador = '';
    return Scaffold(
        appBar: AppBar(title: Text('Remover Produto')),
        backgroundColor: Color.fromRGBO(195, 193, 193, 1),
        body: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: ListView(shrinkWrap: true, scrollDirection: Axis.vertical, children: <Widget>[
              Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, children: <Widget>[
                SizedBox(height: MediaQuery.of(context).size.height * .18),
                SizedBox(
                  width: MediaQuery.of(context).size.width * .89,
                  child: TextField(
                      onChanged: (text) {
                        identificador = text;
                        qtdd = int.parse(identificador);
                      },
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        enabledBorder: const OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.lightBlue, width: 2),
                        ),
                        contentPadding: EdgeInsets.fromLTRB(5, 40, 5, 0),
                        labelText: 'Quantidade que deseja remover do estoque',
                        border: OutlineInputBorder(),
                      )),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * .05),
                SizedBox(
                  width: MediaQuery.of(context).size.width * .89,
                  child: TextField(
                      onChanged: (text) {
                        identificador = text;
                        idd = int.parse(identificador);
                      },
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        enabledBorder: const OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.lightBlue, width: 2),
                        ),
                        contentPadding: EdgeInsets.fromLTRB(5, 40, 5, 0),
                        labelText: 'ID do produto',
                        border: OutlineInputBorder(),
                      )),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * .05),
                SizedBox(
                  width: MediaQuery.of(context).size.width * .89,
                  height: MediaQuery.of(context).size.height * .08,
                  // ignore: deprecated_member_use
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(side: BorderSide(color: Colors.blue)),
                    onPressed: () async {
                        String code = await FlutterBarcodeScanner.scanBarcode("#B3E5FC", "Cancelar",true, ScanMode.QR);
                       idd=int.parse(code.toString());
                    },
                    child: Text(
                      'QR Code',
                      style: TextStyle(fontSize: 25),
                    ),
                    color: Colors.lightBlue[100],
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * .27),
                SizedBox(
                  width: MediaQuery.of(context).size.width * .4,
                  height: MediaQuery.of(context).size.height * .08,
                  // ignore: deprecated_member_use
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(side: BorderSide(color: Colors.blue)),
                    onPressed: () {
                      showAlertDialog4(context);
                      
                      _removerProduto(idd, qtdd);
                      
                    },
                    child: Text(
                      'Remover',
                      style: TextStyle(fontSize: 25),
                    ),
                    color: Colors.lightBlue[100],
                  ),
                )
              ])
            ])));
  }
}
//////////////////////////////////////////////////////////////////////////////////////

//tela adição de produto no estoque
//////////////////////////////////////////////////////////////////////////////////////
class adicao extends StatefulWidget {
  const adicao({Key? key}) : super(key: key);

  @override
  _adicaoState createState() => _adicaoState();
}

//Color.fromRGBO(195, 193, 193, 1),
// ignore: camel_case_types
class _adicaoState extends State<adicao> {
  @override
  Widget build(BuildContext context) {
    String identificador = '';
    return Scaffold(
        appBar: AppBar(title: Text('Adicionar Produto')),
        backgroundColor: Color.fromRGBO(195, 193, 193, 1),
        body: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: ListView(shrinkWrap: true, scrollDirection: Axis.vertical, children: <Widget>[
              Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, children: <Widget>[
               SizedBox(height: MediaQuery.of(context).size.height * .18),
                SizedBox(
                  width: MediaQuery.of(context).size.width * .89,
                  child: TextField(
                      enableInteractiveSelection: false,
                      onChanged: (text) {
                        identificador = text;
                        qtdd = int.parse(identificador);
                      },
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        enabledBorder: const OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.lightBlue, width: 2),
                        ),
                        contentPadding: EdgeInsets.fromLTRB(5, 40, 5, 0),
                        labelText: 'Quantidade que deseja adicionar ao estoque',
                        border: OutlineInputBorder(),
                      )),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * .05),
                SizedBox(
                  width: MediaQuery.of(context).size.width * .89,
                  child: TextField(
                      onChanged: (text) {
                        identificador = text;
                        idd = int.parse(identificador);
                      },
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        enabledBorder: const OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.lightBlue, width: 2),
                        ),
                        contentPadding: EdgeInsets.fromLTRB(5, 40, 5, 0),
                        labelText: 'ID do produto',
                        border: OutlineInputBorder(),
                      )),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * .05),
                SizedBox(
                  width: MediaQuery.of(context).size.width * .89,
                  height: MediaQuery.of(context).size.height * .08,
                  // ignore: deprecated_member_use
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(side: BorderSide(color: Colors.blue)),
                    onPressed: () async {
                     String code = await FlutterBarcodeScanner.scanBarcode("#B3E5FC", "Cancelar",true, ScanMode.QR);
                       idd=int.parse(code.toString());
                       print("idd: $idd");
                    },
                    child: Text(
                      'QR Code',
                      style: TextStyle(fontSize: 25),
                    ),
                    color: Colors.lightBlue[100],
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * .27),
                SizedBox(
                  width: MediaQuery.of(context).size.width * .4,
                  height: MediaQuery.of(context).size.height * .08,
                  // ignore: deprecated_member_use
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(side: BorderSide(color: Colors.blue)),
                    onPressed: () {
                      showAlertDialog3(context);
                      print("idddd: $idd");
                      print("caodeeeee: $qtdd");
                      _adicionarProduto(idd, qtdd);
                    },
                    child: Text(
                      'Adicionar',
                      style: TextStyle(fontSize: 25),
                    ),
                    color: Colors.lightBlue[100],
                  ),
                )
              ])
            ])));
  }
}
//////////////////////////////////////////////////////////////////////////////////////

//tela ver estoque
//////////////////////////////////////////////////////////////////////////////////////
class verestoque extends StatefulWidget {
  const verestoque({Key? key}) : super(key: key);

  @override
  _verestoqueState createState() => _verestoqueState();
}

//Color.fromRGBO(195, 193, 193, 1),
// ignore: camel_case_types
class _verestoqueState extends State<verestoque> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      
      appBar: AppBar(title: Text('Ver estoque')),
      backgroundColor: Color.fromRGBO(195, 193, 193, 1),
      
      body: Column(
        children: <Widget> [
          
          Expanded(
            
            child: ListView.builder(
              itemCount: listaEstoque!.length,

              itemBuilder: (context, index){
                _listarEstoque();
                final Estoque est= listaEstoque![index]; 
                return Card(
                  child: ListTile(
                    title: Text("nome: " +est.nome),
                    subtitle: Text("id: " +est.id),
                    trailing: Text("quantidade: " +est.qtd),
                  ) 
                );
              }
            ),
          )
        ],     
      )
    );  
  }
}
//////////////////////////////////////////////////////////////////////////////////////
_recuperarBancoDados() async {
  final caminhoBD = await getDatabasesPath();
  final localBD = join(caminhoBD, "banco.db");
  var retorno = await openDatabase(localBD, version: 1, onCreate: (db, dbVersaoRecente) {
    String sql = "CREATE TABLE estoque(id INTEGER PRIMARY KEY, nome VARCHAR, qtd INTEGER)";
    db.execute(sql);
  });
  print("Aberto: " + retorno.isOpen.toString());
  return retorno;
}

showAlertDialog1(BuildContext context) {
  // configura o button
  Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context).pop(context);
      });
  // configura o  AlertDialog
  AlertDialog alerta = AlertDialog(
    title: Text("produto cadastrado com sucesso"),
    content: Text(""),
    actions: [
      okButton,
    ],
  );
  // exibe o dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alerta;
    },
  );
}

showAlertDialog2(BuildContext context) {
  // configura o button
  Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context).pop(context);
      });
  // configura o  AlertDialog
  AlertDialog alerta = AlertDialog(
    title: Text("produto excluído com sucesso"),
    content: Text(""),
    actions: [
      okButton,
    ],
  );
  // exibe o dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alerta;
    },
  );
}
showAlertDialog3(BuildContext context) {
  // configura o button
  Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context).pop(context);
      });
  // configura o  AlertDialog
  AlertDialog alerta = AlertDialog(
    title: Text("produto adicionado ao estoque"),
    content: Text(""),
    actions: [
      okButton,
    ],
  );
  // exibe o dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alerta;
    },
  );
}
showAlertDialog4(BuildContext context) {
  // configura o button
  Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context).pop(context);
      });
  // configura o  AlertDialog
  AlertDialog alerta = AlertDialog(
    title: Text("produto removido do estoque"),
    content: Text(""),
    actions: [
      okButton,
    ],
  );
  // exibe o dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alerta;
    },
  );
}
_salvarDados(int id, String nome, int qtd) async {
  Database bd = await _recuperarBancoDados();
  Map<String, dynamic> dadosProduto = {
    "id": id,
    "nome": nome,
    "qtd": qtd
  };
  int i = await bd.insert("estoque", dadosProduto);

  print("Salvo: $i ");
  _listarEstoque();

}

_excluirProduto(int id) async {
  Database bd = await _recuperarBancoDados();
  int retorno = await bd.delete("estoque", where: "id = ?", whereArgs: [
    id
  ]);
  print("Itens excluidos: " + retorno.toString());
  _listarEstoque();
}

_removerProduto(int id, int qtd) async {
  Database bd = await _recuperarBancoDados();
  List produtos = await bd.query("estoque",
      columns: [
        "id",
        "nome",
        "qtd"
      ],
      where: "id = ?",
      whereArgs: [
        id
      ]);
      var usu;
  for (usu in produtos) {
    
  }
  int qt = int.parse(usu['qtd'].toString());
  print(qt);
  //return qt;
  qt = qt - qtd;
  //print("${q}, ${id}, ${qtd}");

  Map<String, dynamic> dadosProduto = {
    "qtd": qt,
  };

  bd = await _recuperarBancoDados();
  int retorno = await bd.update("estoque", dadosProduto, where: "id = ?", whereArgs: [
    id
  ]);
  print("itens atualizados: " + retorno.toString());
  _listarEstoque();

}
_adicionarProduto(int id, int qtd) async {
  Database bd = await _recuperarBancoDados();
  List produtos = await bd.query("estoque",
      columns: [
        "id",
        "nome",
        "qtd"
      ],
      where: "id = ?",
      whereArgs: [
        id
      ]);
      var usu;
  for (usu in produtos) {
    
  }
  int qt = int.parse(usu['qtd'].toString());
  print(qt);
  qt = qt + qtd;
  Map<String, dynamic> dadosProduto = {
    "qtd": qt,
  };
  bd = await _recuperarBancoDados();
  int retorno = await bd.update("estoque", dadosProduto, where: "id = ?", whereArgs: [
    id
  ]);
  print("itens atualizados: " + retorno.toString());
  _listarEstoque();
}


_listarEstoque()async{
Database bd = await _recuperarBancoDados();
String sql = "SELECT * FROM estoque";
List produtos = await bd.rawQuery(sql);
// ignore: deprecated_member_use
List? listaTemporaria=<Estoque>[];
listaEstoque = null;
for(var usu in produtos){
  Estoque c = Estoque.deMapParaModel(usu); 
  listaTemporaria.add(c);
  print("id: "+usu['id'].toString()+
  "Produto: "+usu['nome'].toString()+
  "quantidade: "+usu['qtd'].toString());
}
  listaEstoque=listaTemporaria;
  listaTemporaria = null;
}
class Estoque{
  String id='';
  String nome='';
  String qtd='';

  Estoque(this.id, this.nome, this.qtd);

  Estoque.deMapParaModel(Map<String, dynamic>dados){
    this.id = dados['id'].toString();
    this.nome = dados['nome'].toString();
    this.qtd = dados['qtd'].toString();
  }
}
 scanQrCode()async{
  
   String code = await FlutterBarcodeScanner.scanBarcode("#B3E5FC", "Cancelar",true, ScanMode.QR);
   return code;

 }