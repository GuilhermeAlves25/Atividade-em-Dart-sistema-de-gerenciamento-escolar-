import 'pessoa.dart';

class Aluno extends Pessoa {
  String matricula;

  Aluno(String nome, int idade, this.matricula) : super(nome, idade);

  @override
  void mostrar() {
    print("--- Aluno ---");
    super.mostrar();
    print("Matrícula: $matricula");
  }
}