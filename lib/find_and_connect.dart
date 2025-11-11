// Assuming the Device class and the functions find_device and connect_device are defined elsewhere.
// For demonstration, I'll include stubs, but in real code, remove the stubs and use the actual implementations.

class Device {
  // Placeholder class for Device
}

Device find_device() {
  // Stub: Simulates throwing an exception. Replace with actual implementation.
  //@throw Exception("No device found");
  return Device();
}

void connect_device(Device device) {
  // Stub: Simulates throwing an exception. Replace with actual implementation.
  //throw Exception("Failed to connect");
  print ("Connecting...");
}

// The main function implementing the retry logic
void findAndConnect() {
  Device? device;
  int findAttempts = 0;
  const int maxFindAttempts = 3;

  // Retry find_device up to 3 times
  while (device == null && findAttempts < maxFindAttempts) {
    findAttempts++;
    try {
      device = find_device();
    } catch (e) {
      if (e is Exception && e.toString() == 'Exception: No device found') {
        if (findAttempts == maxFindAttempts) {
          throw Exception("No device found after $maxFindAttempts attempts");
          //rethrow; // Or throw a custom exception like Exception("No device found after $maxFindAttempts attempts")
        }
      } else {
        throw Exception("No device found -- unexpected");
        //rethrow; // Rethrow unexpected exceptions
      }
    }
  }

  if (device == null) {
    throw Exception("@No device found after $maxFindAttempts attempts");
  }

  bool connected = false;
  int connectAttempts = 0;
  const int maxConnectAttempts = 5;

  // Retry connect_device up to 5 times
  while (!connected && connectAttempts < maxConnectAttempts) {
    connectAttempts++;
    try {
      connect_device(device);
      connected = true;
    } catch (e) {
      if (e is Exception && e.toString() == 'Exception: Failed to connect') {
        if (connectAttempts == maxConnectAttempts) {
          throw Exception("Failed to connect after $maxConnectAttempts attempts");
          //rethrow; // Or throw a custom exception like Exception("Failed to connect after $maxConnectAttempts attempts")
        }
      } else {
        throw Exception("Failed to connect -- unexpected");
        //rethrow; // Rethrow unexpected exceptions
      }
    }
  }

  if (!connected) {
    throw Exception("@Failed to connect after $maxConnectAttempts attempts");
  }
}

// Example usage:
void testFindAndConnect() {
  try {
    findAndConnect();
    print("Successfully found and connected to device.");
  } catch (e) {
    print("Error: $e");
  }
}
