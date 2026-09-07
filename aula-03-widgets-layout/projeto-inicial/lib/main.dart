// Caderno de Campo do Vale — PROJETO INICIAL
// Programação para Dispositivos Móveis · IF Goiano — Campus Ceres
//
// Este é o ponto de partida da aula de widgets de layout. O app já roda,
// mas a tela está praticamente vazia de propósito: você vai construí-la
// ao longo dos quatro ciclos, com o hot reload mostrando cada mudança.
//
// COMO RODAR (uma vez, no terminal, dentro desta pasta):
//   flutter create .        # gera as pastas nativas (android/, ios/...)
//   flutter pub get         # baixa as dependências
//   flutter run             # roda no dispositivo/emulador selecionado
//
// Depois, deixe o app rodando: salvar o arquivo aplica o hot reload.

import 'package:flutter/material.dart';

void main() => runApp(const CadernoApp());

class CadernoApp extends StatelessWidget {
  const CadernoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Caderno de Campo do Vale',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF1E5631)),
        useMaterial3: true,
      ),
      home: const TelaResumo(),
    );
  }
}

class Talhao {
  final String nome;
  final double areaHa;
  final String cultura;
  const Talhao({
    required this.nome,
    required this.areaHa,
    required this.cultura,
  });
}

const List<Talhao> talhoes = [
  Talhao(nome: 'Talhão 1', areaHa: 38.0, cultura: 'soja'),
  Talhao(nome: 'Talhão 2', areaHa: 24.5, cultura: 'milho'),
  Talhao(nome: 'Talhão 3', areaHa: 42.0, cultura: 'milho'),
  Talhao(nome: 'Talhão 4', areaHa: 31.2, cultura: 'soja'),
  Talhao(nome: 'Talhão 5', areaHa: 12.8, cultura: 'sorgo'),
  Talhao(nome: 'Talhão 6', areaHa: 19.4, cultura: 'milho'),
  // TAREFA 1 do Ciclo 3 — Acrescente dois talhões
  Talhao(nome: 'Talhão 7', areaHa: 15.0, cultura: 'trigo'),
  Talhao(nome: 'Talhão 8', areaHa: 28.3, cultura: 'soja'),
];

class TelaResumo extends StatelessWidget {
  const TelaResumo({super.key});

  // Função para escolher o ícone conforme a cultura (Ciclo 3 - TAREFA 3)
  IconData _iconePorCultura(String cultura) {
    switch (cultura) {
      case 'milho':
        return Icons.grass; // espiga
      case 'soja':
        return Icons.eco; // folha
      default:
        return Icons.agriculture; // genérico
    }
  }

  @override
  Widget build(BuildContext context) {
    // Área total calculada a partir da lista
    final areaTotal = talhoes.fold<double>(0, (soma, t) => soma + t.areaHa);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Caderno de Campo do Vale'),
        backgroundColor: const Color(0xFF1E5631),
        foregroundColor: Colors.white,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ---- CABEÇALHO (Ciclo 1) ----
          // TAREFA 1 — Troque o nome da fazenda e a cidade
          // TAREFA 3 — Container com padding e cor de fundo
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            color: const Color(0xFFD5F5E3),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Fazenda Primavera do Vale',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(
                  'Rio Verde — GO · ${areaTotal.toStringAsFixed(1)} ha no total',
                ),
                // TAREFA 2 do Ciclo 1 — Acrescentar responsável
                const SizedBox(height: 4),
                const Text(
                  'Responsável: João Silva',
                  style: TextStyle(fontSize: 16, color: Colors.black54),
                ),
              ],
            ),
          ),

          // ---- TRÊS NÚMEROS (Ciclo 2) ----
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                // TAREFA 1 do Ciclo 4 — Expanded em cada card
                Expanded(
                  child: _CardNumero(
                    titulo: 'Talhões',
                    valor: '${talhoes.length}',
                    corDestaque: Colors.green[700],
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _CardNumero(
                    titulo: 'Atividades',
                    valor: '14',
                    corDestaque: Colors.orange[700],
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _CardNumero(
                    titulo: 'Último',
                    valor: 'há 3d',
                    corDestaque: Colors.red[700],
                  ),
                ),
              ],
            ),
          ),

          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Talhões da propriedade',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 8),

          // ---- LISTA (Ciclo 3) ----
          // TAREFA 2 do Ciclo 4 — Expanded no ListView.builder
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              itemCount: talhoes.length,
              itemBuilder: (context, indice) {
                final talhao = talhoes[indice];
                // TAREFA 4 do Ciclo 3 — Envolver em Card
                return Card(
                  margin: const EdgeInsets.symmetric(
                    vertical: 4,
                    horizontal: 8,
                  ),
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: ListTile(
                    // TAREFA 3 do Ciclo 3 — Ícone conforme cultura
                    leading: Icon(
                      _iconePorCultura(talhao.cultura),
                      color: const Color(0xFF1E5631),
                    ),
                    title: Text(
                      talhao.nome,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    // TAREFA 2 do Ciclo 3 — Formatação com vírgula
                    subtitle: Text(
                      '${talhao.areaHa.toStringAsFixed(1).replaceAll('.', ',')} ha — ${talhao.cultura}',
                    ),
                    trailing: const Icon(
                      Icons.chevron_right,
                      color: Color(0xFF1E5631),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      // Botão flutuante — DESAFIO: AlertDialog com culturas distintas
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF1E5631),
        onPressed: () {
          // DESAFIO — Listar culturas distintas
          final culturasDistintas = talhoes
              .map((t) => t.cultura)
              .toSet()
              .toList()
              .join(', ');

          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Culturas da Propriedade'),
              content: Text(
                culturasDistintas.isEmpty
                    ? 'Nenhuma cultura cadastrada'
                    : culturasDistintas,
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Fechar'),
                ),
              ],
            ),
          );
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}

// Card com número em destaque (TAREFA 3 do Ciclo 4)
class _CardNumero extends StatelessWidget {
  final String titulo;
  final String valor;
  final Color? corDestaque;

  const _CardNumero({
    required this.titulo,
    required this.valor,
    this.corDestaque,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFEFF7F1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: corDestaque ?? const Color(0xFF1E8449),
          width: 2,
        ),
      ),
      child: Column(
        children: [
          // Número com cor de destaque e tamanho grande (alvo de toque generoso)
          Text(
            valor,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: corDestaque ?? const Color(0xFF1E5631),
            ),
          ),
          const SizedBox(height: 2),
          Text(
            titulo,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
