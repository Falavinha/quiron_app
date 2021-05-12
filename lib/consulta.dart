import 'package:flutter/material.dart';
import 'rounded_input_field.dart';
import 'rounded_button.dart';
import 'text_field_container.dart';
import 'constants.dart';
import 'package:flutter/services.dart';
import 'perfil_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'perfil_screen.dart';
import 'tela_login.dart';

class _FormPageState extends State<Form> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            TextFormField(
              validator: (value) {
                if (value.isEmpty) return "O campo é obrigatório.";
                return null;
              },
            ),
            SizedBox(height: 30),
            RaisedButton(
              child: Text("Enviar Dados"),
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  Scaffold.of(context).showSnackBar(SnackBar(
                    content: Text("Enviando dados para o servidor..."),
                    duration: Duration(seconds: 3),
                  ));
                }
              },
            )
          ],
        ),
      ),
    );
  }
}

class Consulta extends StatelessWidget {
  final Widget child;
  Consulta({Key key, this.child, this.rgPerfil}) : super(key: key);
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  String emailUser;
  String email;
  String rgPerfil;


  void getCurrentUserEmail() async {
    User emailUser = _auth.currentUser;
    email = emailUser.email;
    print("$email");
  }

  String name_prof,
      fam_name_prof,
      birth_prof,
      rg_prof,
      mom_name_prof,
      prox_prof,
      dise_prof,
      medicine_prof,
      allergy_prof,
      d_allergy_prof,
      blood_prof,
      health_prof,
      n_health_prof,
      id_user,
      height_prof,
      qtdPerfis,
      idDoc,
      weight_prof;

  Future<String> documentId() async {
    getCurrentUserEmail();
    QuerySnapshot resultado = await _firestore
        .collection("usuarios")
        .where("emailUser", isEqualTo: "$email")
        .get();
    resultado.docs.forEach((d) {
      qtdPerfis = d.get('qtd_perfil');
      print("Print da função $qtdPerfis & $idDoc");
    });

    return qtdPerfis;
  }

  getDocId() async {
    getCurrentUserEmail();
    QuerySnapshot resultado = await _firestore
        .collection("usuarios")
        .where("emailUser", isEqualTo: "$email")
        .get();
    resultado.docs.forEach((d) {
      idDoc = d.id;
      print(d.id);
    });
    return idDoc;
  }

  void addPerfil() {
    _firestore.collection('perfil').add(
      {
        'name_prof': name_prof,
        'fam_name_prof': fam_name_prof,
        'birth_prof': birth_prof,
        'rg_prof': rg_prof,
        'mom_name_prof': mom_name_prof,
        'prox_prof': prox_prof,
        'dise_prof': dise_prof,
        'medicine_prof': medicine_prof,
        'd_allergy_prof': d_allergy_prof,
        'allergy_prof': allergy_prof,
        'blood_prof': blood_prof,
        'health_prof': health_prof,
        'n_health_prof': n_health_prof,
        'height_prof': height_prof,
        'weight_prof': weight_prof,
        'id_user': email,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0),
        child: AppBar(
          centerTitle: true,
          title: Text(
            'Consulta',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 36,
                shadows: [
                  Shadow(
                    blurRadius: 10.0,
                    color: Color(0xFF0FA086),
                    offset: Offset(5.0, 5.0),
                  ),
                ],
                fontFamily: 'Monda'),
          ),
          elevation: 5,
          flexibleSpace: Image(
            image: AssetImage('images/appbar.png'),
            fit: BoxFit.cover,
          ),
          backgroundColor: Colors.transparent,
        ),
      ),

      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(10),
              children: <Widget>[
                Column(
                  children: [
                    Container(
                      child: ReusableCard(
                        cor: Color(0xff15EBC4),
                      ),
                      // ),
                      margin: EdgeInsets.all(30.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey[300],
                              spreadRadius: 4,
                              blurRadius: 10,
                              offset: Offset(0, 3),
                            )
                          ],
                          color: Color(0xFF15EBC4)),
                      width: 80.0,
                      height: 80.0,
                    ),
                    StreamBuilder<QuerySnapshot>(
                      stream: _firestore
                          .collection('perfil')
                          .where("rg_prof", isEqualTo: '$rgPerfil')
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return Center(
                            child: CircularProgressIndicator(
                              backgroundColor: Color(0xff15EBC4),
                            ),
                          );
                        }

                        final dados = snapshot.data.docs;
                        List<ConsultaField> dadosWidgets = [];
                        for (var dado in dados) {
                          final dadoName = dado.get('name_prof');
                          final dadoFamName = dado.get('fam_name_prof');
                          final dadoAllergy = dado.get('allergy_prof');
                          final dadoBirth = dado.get('birth_prof');
                          final dadoDise = dado.get('dise_prof');
                          final dadoHealth = dado.get('health_prof');
                          final dadoHeight = dado.get('height_prof');
                          final dadoDAlergy = dado.get('d_allergy_prof');
                          final dadoMedici = dado.get('medicine_prof');
                          final dadoMom = dado.get('mom_name_prof');
                          final dadoNHealth = dado.get('n_health_prof');
                          final dadoProx = dado.get('prox_prof');
                          final dadoRG = dado.get('rg_prof');
                          final dadoSex = dado.get('sex_prof');
                          final dadoWeight = dado.get('weight_prof');
                          final dadoBlood = dado.get('blood_prof');

                          final dadosWidget = ConsultaField(
                            textName: dadoName,
                            textFamName: dadoFamName,
                            textAllergy: dadoAllergy,
                            textBirth: dadoBirth,
                            textDise: dadoDise,
                            textHealth: dadoHealth,
                            textHeight: dadoHeight,
                            textDAlergy: dadoDAlergy,
                            textMedici: dadoMedici,
                            textMom: dadoMom,
                            textNHealth: dadoNHealth,
                            textProx: dadoProx,
                            textRG: dadoRG,
                            textSex: dadoSex,
                            textWeight: dadoWeight,
                            textBlood: dadoBlood,
                          );

                          dadosWidgets.add(dadosWidget);
                        }
                        return Column(
                          children: dadosWidgets,
                        );
                      },
                    ),
                  ],
                ),
                RoundedButton(
                  text: "Criar",
                  press: () async {},
                ),
              ],
            ),
          ),
        ],
      ),

      // Column(
      //   children: [
      //     Container(
      //       width: double.infinity,
      //       // Here i can use size.width but use double.infinity because both work as a same
      //       child: Stack(
      //         alignment: Alignment.center,
      //         children: <Widget>[
      //           child,
      //         ],
      //       ),
      //     ),
      //   ],
      // ),
    );
  }
}

class ReusableCard extends StatelessWidget {
  ReusableCard({@required this.cor, this.cardChild});

  final Color cor;
  final Widget cardChild;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Icon(Icons.add_a_photo, color: Color(0xffC7F0E9), size: 44.0),
      // margin: EdgeInsets.all(15.0),
      // decoration: BoxDecoration(
      //   borderRadius: BorderRadius.circular(5.0),
      //   color: cor,
      // ),
    );
  }
}

class ConsultaField extends StatelessWidget {
  ConsultaField({
    this.textName,
    this.textFamName,
    this.textAllergy,
    this.textBirth,
    this.textDise,
    this.textHealth,
    this.textHeight,
    this.textDAlergy,
    this.textMedici,
    this.textMom,
    this.textNHealth,
    this.textProx,
    this.textRG,
    this.textSex,
    this.textWeight,
    this.textBlood,
    this.textFever,
    this.textFeverC,
    this.textSymp,
    this.textRespon,
  });

  final String textName;
  final String textFamName;
  final String textAllergy;
  final String textBirth;
  final String textDise;
  final String textHealth;
  final String textHeight;
  final String textDAlergy;
  final String textMedici;
  final String textMom;
  final String textNHealth;
  final String textProx;
  final String textRG;
  final String textSex;
  final String textWeight;
  final String textBlood;
  final String textFever;
  final String textFeverC;
  final String textSymp;
  final String textRespon;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: <Widget>[
        RoundedInputField(
          hintText: '$textName $textFamName',
          onChanged: (value) {},
        ),
        RoundedInputField(
          hintText: textBirth,
          onChanged: (value) {},
        ),
        RoundedInputField(
          hintText: textRG,
          onChanged: (value) {},
        ),
        RoundedInputField(
          hintText: textMom,
          onChanged: (value) {},
        ),
        RoundedInputField(
          hintText: textProx,
          onChanged: (value) {},
        ),
        RoundedInputField(
          hintText: textSex,
          onChanged: (value) {},
        ),
        RoundedInputField(
          hintText: '$textHeight cm',
          onChanged: (value) {},
        ),
        RoundedInputField(
          hintText: '$textWeight Kg',
          onChanged: (value) {},
        ),
        RoundedInputField(
          hintText: textDise,
          onChanged: (value) {},
        ),
        RoundedInputField(
          hintText: textMedici,
          onChanged: (value) {},
        ),
        RoundedInputField(
          hintText: textAllergy,
          onChanged: (value) {},
        ),
        RoundedInputField(
          hintText: textDAlergy,
          onChanged: (value) {},
        ),
        RoundedInputField(
          hintText: textBlood,
          onChanged: (value) {},
        ),
        RoundedInputField(
          hintText: textHealth,
          onChanged: (value) {},
        ),
        RoundedInputField(
          hintText: textNHealth,
          onChanged: (value) {},
        ),
      ],
    );
  }



}
