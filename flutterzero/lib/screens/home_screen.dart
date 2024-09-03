import 'package:flutter/material.dart';
import 'package:flutterzero/screens/design_screen.dart';

typedef Word = Map<String, String>;

class Dictionary {
  final Map<String, String> _words = {};

  void add(String term, String definition) {
    _words[term] = definition;
  }

  String? get(String term) {
    return _words[term];
  }

  void delete(String term) {
    _words.remove(term);
  }

  void update(String term, String definition) {
    if (_words.containsKey(term)) {
      _words[term] = definition;
    }
  }

  void upsert(String term, String definition) {
    _words[term] = definition;
  }

  List<String> showAll() {
    return _words.entries
        .map((entry) => '${entry.key}: ${entry.value}')
        .toList();
  }

  int count() {
    return _words.length;
  }

  bool exists(String term) {
    return _words.containsKey(term);
  }

  void bulkAdd(List<Word> words) {
    for (var word in words) {
      _words[word['term']!] = word['definition']!;
    }
  }

  void bulkDelete(List<String> terms) {
    for (var term in terms) {
      _words.remove(term);
    }
  }

  List<MapEntry<String, String>> getAllWords() {
    return _words.entries.toList();
  }
}

class DictionaryScreen extends StatefulWidget {
  const DictionaryScreen({super.key});

  @override
  DictionaryScreenState createState() => DictionaryScreenState();
}

class DictionaryScreenState extends State<DictionaryScreen> {
  final Dictionary dictionary = Dictionary();

  // Controllers for adding words
  final TextEditingController addTermController = TextEditingController();
  final TextEditingController addDefinitionController = TextEditingController();

  // Controller for searching words
  final TextEditingController searchTermController = TextEditingController();

  String? searchTerm;
  String? searchResult;
  bool isListVisible = false;
  String feedbackMessage = '';

  void _addWord() {
    final term = addTermController.text;
    final definition = addDefinitionController.text;
    if (term.isNotEmpty && definition.isNotEmpty) {
      setState(() {
        dictionary.add(term, definition);
        feedbackMessage = 'Word added successfully.';
      });
      addTermController.clear();
      addDefinitionController.clear();
    }
  }

  void _updateWord() {
    final term = addTermController.text;
    final definition = addDefinitionController.text;
    if (term.isNotEmpty && definition.isNotEmpty) {
      setState(() {
        if (dictionary.exists(term)) {
          dictionary.update(term, definition);
          feedbackMessage = 'Word updated successfully.';
        } else {
          feedbackMessage = 'Word not found.';
        }
      });
    }
  }

  void _upsertWord() {
    final term = addTermController.text;
    final definition = addDefinitionController.text;
    if (term.isNotEmpty && definition.isNotEmpty) {
      setState(() {
        if (dictionary.exists(term)) {
          feedbackMessage = 'Word updated successfully.';
        } else {
          feedbackMessage = 'Word added successfully.';
        }
        dictionary.upsert(term, definition);
      });
    }
  }

  void _searchWord() {
    final term = searchTermController.text;
    setState(() {
      searchTerm = term;
      searchResult = dictionary.get(term);
    });
  }

  void _toggleWordList() {
    setState(() {
      isListVisible = !isListVisible;
    });
  }

  void _routeDesign() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const DesignScreen(),
      ),
    );
  }

  void _deleteWord(String term) {
    setState(() {
      dictionary.delete(term);
      searchTerm = null;
      searchResult = null;
      feedbackMessage = 'Word "$term" deleted successfully.';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dictionary App'),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 단어 추가 및 업데이트 부분
                Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Add or Update a Word',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      TextField(
                        controller: addTermController,
                        decoration: const InputDecoration(labelText: 'Term'),
                      ),
                      TextField(
                        controller: addDefinitionController,
                        decoration:
                            const InputDecoration(labelText: 'Definition'),
                      ),
                      const SizedBox(height: 10),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal, // 좌우 스크롤 가능하도록 설정
                        child: Row(
                          children: [
                            ElevatedButton(
                              onPressed: _addWord,
                              child: const Text('Add Word'),
                            ),
                            const SizedBox(width: 10),
                            ElevatedButton(
                              onPressed: _updateWord,
                              child: const Text('Update Word'),
                            ),
                            const SizedBox(width: 10),
                            ElevatedButton(
                              onPressed: _upsertWord,
                              child: const Text('Upsert Word'),
                            ),
                          ],
                        ),
                      ),
                      if (feedbackMessage.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Text(
                            feedbackMessage,
                            style: const TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                    ],
                  ),
                ),
                const Divider(),
                // 단어 검색 부분
                Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Search a Word',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      TextField(
                        controller: searchTermController,
                        decoration:
                            const InputDecoration(labelText: 'Search Term'),
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: _searchWord,
                        child: const Text('Search Word'),
                      ),
                    ],
                  ),
                ),
                // 검색 결과 표시
                if (searchTerm != null)
                  searchResult != null
                      ? ListTile(
                          title: Text(
                            searchTerm!,
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            searchResult!,
                            style: const TextStyle(fontSize: 16),
                          ),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete),
                            color: Colors.red,
                            onPressed: () {
                              _deleteWord(searchTerm!);
                            },
                          ),
                        )
                      : Text(
                          'Word "$searchTerm" not found.',
                          style:
                              const TextStyle(fontSize: 18, color: Colors.red),
                        ),
              ],
            ),
          ),
          // 전체 단어 리스트 표시 (오버레이)
          if (isListVisible)
            Positioned.fill(
              child: Container(
                color: Colors.white.withOpacity(0.9),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'All Stored Words',
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Total: ${dictionary.count()}',
                            style: const TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: dictionary.count(),
                        itemBuilder: (context, index) {
                          final entry = dictionary.getAllWords()[index];
                          return ListTile(
                            title: Text(
                              entry.key,
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(
                              entry.value,
                              style: const TextStyle(fontSize: 16),
                            ),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete),
                              color: Colors.red,
                              onPressed: () {
                                _deleteWord(entry.key);
                              },
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          // 리스트 보기 버튼
          Positioned(
            right: 16,
            bottom: 16,
            child: Column(
              spacing: 10,
              children: [
                FloatingActionButton(
                  heroTag: 'toggleWordList',
                  onPressed: _toggleWordList,
                  child: Icon(isListVisible ? Icons.close : Icons.list),
                ),
                FloatingActionButton(
                  heroTag: 'routeDesign',
                  onPressed: _routeDesign,
                  child: const Icon(
                    Icons.picture_in_picture,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
