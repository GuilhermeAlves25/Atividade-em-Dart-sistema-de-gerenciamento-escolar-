import 'aluno.dart';
import 'disciplina.dart';

class Nota {
  Aluno aluno;
  Disciplina disciplina;
  double valor;

  Nota(this.aluno, this.disciplina, this.valor);

  void exibir() {
    print("Nota de ${aluno.nome} em ${disciplina.nome}: $valor");
  }
}