class DisposableObject {
  String? _data;
  bool    _isDisposed = false;
  int     _counter = 0;

  DisposableObject(this._data) {
    print('Object created with data: $_data');
  }

  // Check delete condition
  void checkAndDisposeIfNeeded(bool shouldDispose) {
    if (shouldDispose) {
      print('Need to delete. Call dispose()...');
      dispose();
    } else {
      print('Continue work.');
    }
  }

  // Method dispose for "destroying" object
  void dispose() {
    if (_isDisposed) {
      print('Object already destroyed.');
      return;
    }

    // Free resources
    _data = null;
    _isDisposed = true;

    // Add destroying logic: free resources, close files & etc.
    print('Object has been destroyed');
  }

  // Sample of method checks need to destroy object or no
  void doSomething() {
    if (_isDisposed) {
      throw Exception("Object has been destroyed and can't be used");
    }
    print('do with data: $_data');
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
    print(e); // Object already deleted
    obj = null;
    print("is null");
  }
}
