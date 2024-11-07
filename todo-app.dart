import 'dart:io';

class Todo {
  String title;
  String category;
  bool isCompleted;

  Todo(this.title, this.category, {this.isCompleted = false});
}

class TodoApp {
  List<Todo> todos = [];
  int selectedIndex = 0;

  void run() {
    while (true) {
      clearConsole();
      displayTodos();
      displayMenu();

      String? choice = stdin.readLineSync();
      switch (choice) {
        case '1':
          addTodo();
          break;
        case '2':
          toggleTodo();
          break;
        case '3':
          moveCursor(true);
          break;
        case '4':
          moveCursor(false);
          break;
        case '5':
          deleteTodo();
          break;
        case '6':
          return;
        default:
          print('Ungültige Eingabe. Bitte versuchen Sie es erneut.');
          sleep(Duration(seconds: 1));
      }
    }
  }

  void clearConsole() {
    if (Platform.isWindows) {
      print(Process.runSync('cls', [], runInShell: true).stdout);
    } else {
      print(Process.runSync('clear', [], runInShell: true).stdout);
    }
  }

  void displayTodos() {
    print('Todo-Liste:');
    for (int i = 0; i < todos.length; i++) {
      String cursor = i == selectedIndex ? '>' : ' ';
      String status = todos[i].isCompleted ? '[x]' : '[ ]';
      String title =
          todos[i].isCompleted ? '~${todos[i].title}~' : todos[i].title;
      print('$cursor $status $title (${todos[i].category})');
    }
    print('');
  }

  void displayMenu() {
    print('Menü:');
    print('1. Todo hinzufügen');
    print('2. Todo umschalten (erledigt/nicht erledigt)');
    print('3. Cursor nach oben bewegen');
    print('4. Cursor nach unten bewegen');
    print('5. Ausgewähltes Todo löschen');
    print('6. Beenden');
    print('Wählen Sie eine Option:');
  }

  void addTodo() {
    print('Geben Sie den Titel des neuen Todos ein:');
    String? title = stdin.readLineSync();
    print('Geben Sie die Kategorie des neuen Todos ein:');
    String? category = stdin.readLineSync();

    if (title != null &&
        category != null &&
        title.isNotEmpty &&
        category.isNotEmpty) {
      todos.add(Todo(title, category));
      print('Todo hinzugefügt!');
    } else {
      print('Ungültige Eingabe. Todo wurde nicht hinzugefügt.');
    }
    sleep(Duration(seconds: 1));
  }

  void toggleTodo() {
    if (todos.isNotEmpty) {
      todos[selectedIndex].isCompleted = !todos[selectedIndex].isCompleted;
    }
  }

  void moveCursor(bool up) {
    if (todos.isNotEmpty) {
      if (up && selectedIndex > 0) {
        selectedIndex--;
      } else if (!up && selectedIndex < todos.length - 1) {
        selectedIndex++;
      }
    }
  }

  void deleteTodo() {
    if (todos.isNotEmpty) {
      todos.removeAt(selectedIndex);
      if (selectedIndex >= todos.length) {
        selectedIndex = todos.length - 1;
      }
      if (selectedIndex < 0) {
        selectedIndex = 0;
      }
    }
  }
}

void main() {
  TodoApp app = TodoApp();
  app.run();
}
