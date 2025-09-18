
import 'pessoa.dart';

class Professor extends Pessoa {
  final String id;
  String especialidade;


  Professor(this.id, String nome, int idade, this.especialidade) : super(nome, idade);

  @override
  void mostrar() {
    print("\n--- Professor ---");
    print("ID: $id");
    super.mostrar();
    print("Especialidade: $especialidade");
  }
}