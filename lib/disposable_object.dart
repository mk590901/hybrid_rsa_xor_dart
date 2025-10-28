class DisposableObject {
  // Пример полей: какие-то ресурсы
  String? _data;
  bool    _isDisposed = false;
  int     _counter = 0;

  DisposableObject(this._data) {
    print('Объект создан с данными: $_data');
  }

  // Метод, который проверяет условие и решает, нужно ли уничтожить объект
  void checkAndDisposeIfNeeded(bool shouldDispose) {
    if (shouldDispose) {
      print('Обнаружена необходимость удаления. Вызываем dispose()...');
      dispose();
    } else {
      print('Условие не выполнено. Объект продолжает работать.');
    }
  }

  // Метод dispose для "уничтожения" объекта
  void dispose() {
    if (_isDisposed) {
      print('Объект уже уничтожен.');
      return;
    }

    // Освобождаем ресурсы
    _data = null;
    _isDisposed = true;

    // Здесь можно добавить логику очистки: закрыть файлы, отменить таймеры и т.д.
    print('Объект уничтожен: ресурсы освобождены.');
  }

  // Пример другого метода, который проверяет, уничтожен ли объект
  void doSomething() {
    if (_isDisposed) {
      throw Exception('Объект уже уничтожен и не может быть использован.');
    }
    print('Работаю с данными: $_data');
  }

  void inc() {
    if (_isDisposed) {
      throw Exception('destroyed');
    }
    _counter++;
    print ("$_counter");
    if (_counter == 3) {
      _isDisposed = true;
    }
  }

  void dec() {
    if (_isDisposed) {
      throw Exception('destroyed');
    }
    _counter = 0;
  }

}

void testDisposableObject() {
  DisposableObject? obj = DisposableObject('Важные данные');

  try {
    obj.inc();
    obj.inc();
    obj.dec();
    obj.inc();
    obj.inc();
    obj.inc();
    obj.dec();
    obj.inc();
  } catch (e) {
    print(e); // Объект уже уничтожен
    obj = null;
    print ("is null");
  }


  // obj.doSomething(); // Работает нормально
  // obj.checkAndDisposeIfNeeded(false); // Условие не выполнено
  // obj.checkAndDisposeIfNeeded(true); // Условие выполнено, вызываем dispose
  //
  // // Теперь попробуем использовать объект
  // try {
  //   obj.doSomething(); // Выбросит исключение
  // } catch (e) {
  //   print(e); // Объект уже уничтожен
  //   obj = null;
  // }

  // Чтобы GC мог собрать объект, удаляем ссылку
  //obj = null;
  // Теперь объект может быть собран GC в любой момент
}