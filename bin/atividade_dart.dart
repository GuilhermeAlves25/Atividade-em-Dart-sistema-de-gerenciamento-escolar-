import 'dart:io';
import 'package:atividade_dart/atividade_dart.dart';


final List<Aluno> alunos = [];
final List<Professor> professores = [];
final List<Disciplina> disciplinas = [];
final List<Turma> turmas = [];
final List<Nota> notas = [];


void popularDadosIniciais() {
  var profCarlos = Professor("prof-carlos", "Carlos Pereira", 45, "Desenvolvimento de Sistemas");
  var profBeatriz = Professor("prof-beatriz", "Beatriz Farias", 38, "Banco de Dados");
  professores.addAll([profCarlos, profBeatriz]);


  var d_poo = Disciplina("Programação Orientada a Objetos", 80);
  var d_bd = Disciplina("Banco de Dados I", 60);
  disciplinas.addAll([d_poo, d_bd]);


  var alunoJoao = Aluno("João Silva", 20, "2025001");
  var alunoMaria = Aluno("Maria Souza", 22, "2025002");
  var alunoPedro = Aluno("Pedro Alves", 19, "2025003");
  alunos.addAll([alunoJoao, alunoMaria, alunoPedro]);


  var turmaPOO = Turma("T01-POO", d_poo, profCarlos);
  turmaPOO.adicionarAluno(alunoJoao);
  turmaPOO.adicionarAluno(alunoMaria);

  var turmaBD = Turma("T02-BD", d_bd, profBeatriz);
  turmaBD.adicionarAluno(alunoMaria);
  turmaBD.adicionarAluno(alunoPedro);
  turmas.addAll([turmaPOO, turmaBD]);


  notas.add(Nota(alunoJoao, d_poo, 8.5));
  notas.add(Nota(alunoMaria, d_poo, 9.0));
  notas.add(Nota(alunoMaria, d_bd, 7.5));
  notas.add(Nota(alunoPedro, d_bd, 8.0));

  print("-> Dados iniciais carregados para teste.\n");
}



void main() {
  popularDadosIniciais();

  while (true) {
    print('\n===== BEM-VINDO AO SISTEMA ESCOLAR =====');
    print('Selecione seu perfil de acesso:');
    print('1. Sistema Aluno');
    print('2. Sistema Professor');
    print('3. Sistema Administrativo');
    print('0. Sair do Sistema');

    stdout.write('Escolha uma opção: ');
    final opcao = stdin.readLineSync();

    switch (opcao) {
      case '1':
        menuAluno();
        break;
      case '2':
        menuProfessor();
        break;
      case '3':
        menuAdministrativo();
        break;
      case '0':
        print('Encerrando o sistema. Até logo!');
        return;
      default:
        print('Opção inválida! Tente novamente.');
    }
  }
}


void menuAluno() {
  stdout.write('\nDigite sua matrícula para entrar: ');
  final matricula = stdin.readLineSync();

  try {
    final alunoLogado = alunos.firstWhere((a) => a.matricula == matricula);
    print('\nBem-vindo(a), ${alunoLogado.nome}!');

    while (true) {
      print('\n-- Menu do Aluno --');
      print('1. Ver minhas notas');
      print('0. Sair (Logout)');
      stdout.write('Escolha uma opção: ');
      final opcao = stdin.readLineSync();

      if (opcao == '1') {
        verMinhasNotas(alunoLogado);
      } else if (opcao == '0') {
        print('Saindo do perfil de aluno...');
        break;
      } else {
        print('Opção inválida.');
      }
    }
  } catch (e) {
    print('Matrícula não encontrada. Tente novamente.');
  }
}

void verMinhasNotas(Aluno alunoLogado) {
  print('\n--- Suas Notas ---');
  final notasDoAluno = notas.where((n) => n.aluno.matricula == alunoLogado.matricula);

  if (notasDoAluno.isEmpty) {
    print('Você ainda não tem notas lançadas.');
  } else {
    for (var nota in notasDoAluno) {
      print('Disciplina: ${nota.disciplina.nome} - Nota: ${nota.valor}');
    }
  }
}


void menuProfessor() {
  stdout.write('\nDigite seu ID de professor para entrar: ');
  final id = stdin.readLineSync();

  try {
    final profLogado = professores.firstWhere((p) => p.id == id);
    print('\nBem-vindo(a), Professor(a) ${profLogado.nome}!');

    while (true) {
      print('\n-- Menu do Professor --');
      print('1. Ver minhas turmas');
      print('2. Lançar nota para um aluno');
      print('0. Sair (Logout)');
      stdout.write('Escolha uma opção: ');
      final opcao = stdin.readLineSync();

      switch (opcao) {
        case '1':
          verMinhasTurmas(profLogado);
          break;
        case '2':
          lancarNotaProfessor(profLogado);
          break;
        case '0':
          print('Saindo do perfil de professor...');
          return;
        default:
          print('Opção inválida.');
      }
    }
  } catch (e) {
    print('ID de professor não encontrado. Tente novamente.');
  }
}

List<Turma> verMinhasTurmas(Professor profLogado) {
  print('\n--- Suas Turmas ---');
  final turmasDoProfessor = turmas.where((t) => t.professor.id == profLogado.id).toList();

  if (turmasDoProfessor.isEmpty) {
    print('Você não está alocado em nenhuma turma.');
  } else {
    for (int i = 0; i < turmasDoProfessor.length; i++) {
      final turma = turmasDoProfessor[i];
      print('${i + 1}. Turma ${turma.codigo} - Disciplina: ${turma.disciplina.nome}');
      print('   Alunos: ${turma.alunos.map((a) => a.nome).join(', ')}');
    }
  }
  return turmasDoProfessor;
}

void lancarNotaProfessor(Professor profLogado) {
  final minhasTurmas = verMinhasTurmas(profLogado);
  if (minhasTurmas.isEmpty) return;


  final indexTurma = lerInteiro('\nEscolha o número da turma para lançar a nota: ', max: minhasTurmas.length) - 1;
  final turmaSelecionada = minhasTurmas[indexTurma];


  if (turmaSelecionada.alunos.isEmpty) {
    print('Esta turma não possui alunos.');
    return;
  }
  print('\nSelecione o Aluno:');
  for (int i = 0; i < turmaSelecionada.alunos.length; i++) {
    print('${i + 1}. ${turmaSelecionada.alunos[i].nome}');
  }
  final indexAluno = lerInteiro('Número do aluno: ', max: turmaSelecionada.alunos.length) - 1;
  final alunoSelecionado = turmaSelecionada.alunos[indexAluno];


  final valorNota = lerDouble('\nDigite a nota para ${alunoSelecionado.nome}: ');


  final novaNota = Nota(alunoSelecionado, turmaSelecionada.disciplina, valorNota);
  notas.add(novaNota);
  print('Nota ${novaNota.valor} lançada com sucesso!');
}



void menuAdministrativo() {
  while (true) {
    print('\n--- MENU ADMINISTRATIVO ---');
    print('1. Cadastrar Aluno');
    print('2. Cadastrar Professor');
    print('3. Cadastrar Disciplina');
    print('4. Criar Turma');
    print('5. Listar Alunos');
    print('6. Listar Professores');
    print('7. Listar Disciplinas');
    print('8. Listar Turmas');
    print('9. Listar Notas');
    print('0. Voltar ao menu principal');

    stdout.write('Escolha uma opção: ');
    final opcao = stdin.readLineSync();

    switch(opcao) {
      case '1': cadastrarAluno(); break;
      case '2': cadastrarProfessor(); break;
      case '3': cadastrarDisciplina(); break;
      case '4': criarTurmaAdmin(); break;
      case '5': listarAlunos(); break;
      case '6': listarProfessores(); break;
      case '7': listarDisciplinas(); break;
      case '8': listarTurmas(); break;
      case '9': listarNotas(); break;
      case '0': return;
      default: print('Opção inválida.');
    }
  }
}


String lerTexto(String mensagem) {
  String? texto;
  do {
    stdout.write(mensagem);
    texto = stdin.readLineSync();
    if (texto == null || texto.isEmpty) print('Entrada inválida.');
  } while (texto == null || texto.isEmpty);
  return texto;
}

int lerInteiro(String mensagem, {int? max}) {
  int? numero;
  do {
    stdout.write(mensagem);
    final input = stdin.readLineSync();
    if (input != null) numero = int.tryParse(input);
    if (numero == null) {
      print('Entrada inválida. Digite apenas números.');
    } else if (max != null && (numero <= 0 || numero > max)) {
      print('Número fora do intervalo válido (de 1 a $max).');
      numero = null;
    }
  } while (numero == null);
  return numero;
}

double lerDouble(String mensagem) {
  double? numero;
  do {
    stdout.write(mensagem);
    final input = stdin.readLineSync();
    if (input != null) numero = double.tryParse(input.replaceAll(',', '.'));
    if (numero == null || numero < 0 || numero > 10) {
      print('Nota inválida. Digite um valor entre 0 e 10.');
      numero = null;
    }
  } while (numero == null);
  return numero;
}

void cadastrarAluno() {
  final nome = lerTexto('Nome do aluno: ');
  final idade = lerInteiro('Idade do aluno: ');
  final matricula = lerTexto('Matrícula do aluno: ');
  alunos.add(Aluno(nome, idade, matricula));
  print('Aluno(a) $nome cadastrado com sucesso!');
}

void cadastrarProfessor() {
  final id = lerTexto('ID do professor (ex: prof-fulano): ');
  final nome = lerTexto('Nome do professor: ');
  final idade = lerInteiro('Idade do professor: ');
  final especialidade = lerTexto('Especialidade: ');
  professores.add(Professor(id, nome, idade, especialidade));
  print('Professor(a) $nome cadastrado com sucesso!');
}

void cadastrarDisciplina() {
  final nome = lerTexto('Nome da disciplina: ');
  final cargaHoraria = lerInteiro('Carga horária (em horas): ');
  disciplinas.add(Disciplina(nome, cargaHoraria));
  print('Disciplina "$nome" cadastrada com sucesso!');
}

void listarAlunos() {
  print('\n--- Alunos Cadastrados ---');
  if (alunos.isEmpty) print('Nenhum aluno cadastrado.');
  alunos.forEach((aluno) => aluno.mostrar());
}

void listarProfessores() {
  print('\n--- Professores Cadastrados ---');
  if (professores.isEmpty) print('Nenhum professor cadastrado.');
  professores.forEach((prof) => prof.mostrar());
}

void listarDisciplinas() {
  print('\n--- Disciplinas Cadastradas ---');
  if (disciplinas.isEmpty) print('Nenhuma disciplina cadastrada.');
  disciplinas.forEach((d) => d.exibir());
}

void listarTurmas() {
  print('\n--- Turmas Criadas ---');
  if (turmas.isEmpty) print('Nenhuma turma criada.');
  turmas.forEach((t) => t.exibirDetalhes());
}

void listarNotas() {
  print('\n--- Notas Lançadas ---');
  if (notas.isEmpty) print('Nenhuma nota lançada.');
  notas.forEach((n) => n.exibir());
}


void criarTurmaAdmin() {
  if (disciplinas.isEmpty || professores.isEmpty) {
    print('É preciso ter ao menos uma disciplina e um professor cadastrados.');
    return;
  }
  print('\n-- Criação de Nova Turma --');
  print('\nSelecione a Disciplina:');
  disciplinas.asMap().forEach((i, d) => print('${i + 1}. ${d.nome}'));
  final indexDisc = lerInteiro('Número da disciplina: ', max: disciplinas.length) - 1;
  final disciplinaSelecionada = disciplinas[indexDisc];

  print('\nSelecione o Professor:');
  professores.asMap().forEach((i, p) => print('${i + 1}. ${p.nome}'));
  final indexProf = lerInteiro('Número do professor: ', max: professores.length) - 1;
  final professorSelecionado = professores[indexProf];

  final codigo = lerTexto('Código da turma: ');
  final novaTurma = Turma(codigo, disciplinaSelecionada, professorSelecionado);

  
  if (alunos.isEmpty) {
    print('\nAviso: Nenhum aluno cadastrado no sistema. A turma será criada vazia.');
  } else {
    while (true) {
      print('\nAdicionar Alunos à Turma [${novaTurma.codigo}] (digite 0 para finalizar):');
      final alunosDisponiveis = alunos.where((aluno) => !novaTurma.alunos.contains(aluno)).toList();

      if (alunosDisponiveis.isEmpty) {
        print('Todos os alunos do sistema já foram adicionados a esta turma.');
        break;
      }

      alunosDisponiveis.asMap().forEach((i, a) => print('${i + 1}. ${a.nome}'));

      stdout.write('Número do aluno para adicionar: ');
      final input = stdin.readLineSync();

      if (input == '0') {
        break;
      }

      final indexAluno = int.tryParse(input ?? '');
      if (indexAluno == null || indexAluno <= 0 || indexAluno > alunosDisponiveis.length) {
        print('Seleção inválida. Tente novamente.');
        continue;
      }

      final alunoSelecionado = alunosDisponiveis[indexAluno - 1];
      novaTurma.adicionarAluno(alunoSelecionado);
    }
  }

  turmas.add(novaTurma);
  print('\nTurma ${novaTurma.codigo} criada com sucesso!');
  novaTurma.exibirDetalhes();
}