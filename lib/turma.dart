
import 'aluno.dart';
import 'professor.dart';
import 'disciplina.dart';

class Turma {
  String codigo;
  Disciplina disciplina;
  Professor professor;
  List<Aluno> alunos;

  Turma(this.codigo, this.disciplina, this.professor) : alunos = [];

  void adicionarAluno(Aluno aluno) {
    alunos.add(aluno);
    print("Aluno ${aluno.nome} adicionado à turma $codigo.");
  }

  void removerAluno(String matricula) {
    alunos.removeWhere((aluno) => aluno.matricula == matricula);
    print("Aluno com matrícula $matricula removido.");
  }

  void listarAlunos() {
    print("\n--- Alunos da Turma $codigo (${disciplina.nome}) ---");
    if (alunos.isEmpty) {
      print("Nenhum aluno matriculado nesta turma.");
    } else {
      for (var aluno in alunos) {
        print("- ${aluno.nome} (Matrícula: ${aluno.matricula})");
      }
    }
    print("----------------------------------------");
  }

  void exibirDetalhes() {
    print("\n======== Detalhes da Turma $codigo ========");
    disciplina.exibir();
    professor.mostrar();
    listarAlunos();
    print("======================================\n");
  }
}