void main() {
  // Predefined test string (TLV example with nested TLVs for tag, length, and value)
  final testString = "CN02LN02VL08TL08VL12345678"; // Final value has length 8

  // Create a TLV object and decode the string
  TLV mainTLV = TLV.decode(testString);
  mainTLV.printTLV(); // Print the TLV information

  // Example of encoding TLVs for tag, length, and value
  String tagTLV = TLV('CN', '02').encode(); // Tag TLV
  String lengthTLV = TLV('LN', '02').encode(); // Length TLV
  String valueTLV = TLV('VL', '12345678').encode(); // Value TLV of length 8
  
  // Combine these TLVs into a new TLV and encode the final TLV string
  String fullTLV = TLV('TL', '$tagTLV$lengthTLV$valueTLV').encode();
  print('Encoded full TLV: $fullTLV');

  // Decode the combined TLV and print its details
  TLV decodedFullTLV = TLV.decode(fullTLV);
  decodedFullTLV.printTLV();
}

// Class to represent a TLV (Tag, Length, Value)
class TLV {
  String tag;
  int length;
  String value;
  List<TLV> nestedTLVs = []; // To store nested TLVs if they exist

  // Constructor
  TLV(this.tag, this.value) : length = value.length {
    // Check if the value contains nested TLVs
    if (value.startsWith(RegExp(r'[A-Z]{2}\d{2}'))) {
      decodeNestedTLVs(value);
    }
  }

  // Method to encode TLV into a string
  String encode() {
    String lengthStr = length.toString().padLeft(2, '0'); // Length formatted as 2 characters
    return '$tag$lengthStr$value'; // Return the TLV string (Tag + Length + Value)
  }

  // Method to decode a TLV string and return a TLV object
  static TLV decode(String tlvData) {
    // Extract the Tag (first 2 characters)
    String tag = tlvData.substring(0, 2);

    // Extract the Length (next 2 characters)
    String lengthStr = tlvData.substring(2, 4);
    int length = int.parse(lengthStr); // Convert length to an integer

    // Extract the Value based on the length
    String value = tlvData.substring(4, 4 + length);

    // If the value length must be 8, adjust accordingly
    if (length == 8 && value.length == 8) {
      return TLV(tag, value); // Create and return TLV with length 8
    }

    // Create and return the TLV object
    TLV decodedTLV = TLV(tag, value);

    // If the TLV has nested values, check if the final value has length 8
    if (decodedTLV.nestedTLVs.isNotEmpty) {
      for (TLV nested in decodedTLV.nestedTLVs) {
        if (nested.length == 8 && nested.value.length == 8) {
          print("Final value of length 8 found in nested TLV");
        }
      }
    }

    return decodedTLV;
  }

  // Method to decode nested TLVs within the value
  void decodeNestedTLVs(String tlvData) {
    int i = 0;
    while (i < tlvData.length) {
      // Extract the next TLV tag, length, and value
      String tag = tlvData.substring(i, i + 2); // Get tag
      String lengthStr = tlvData.substring(i + 2, i + 4); // Get length as string
      int length = int.parse(lengthStr); // Convert length to integer
      String value = tlvData.substring(i + 4, i + 4 + length); // Get value based on length

      // Create a new TLV object for the nested TLV and add it to the list
      TLV nestedTLV = TLV(tag, value);
      nestedTLVs.add(nestedTLV);

      // Move the index forward to the next TLV
      i += (4 + length);
    }
  }

  // Method to print TLV details, including nested TLVs
  void printTLV() {
    print('Tag: $tag');
    print('Length: $length');
    print('Value: $value');

    // If there are nested TLVs, print them recursively
    if (nestedTLVs.isNotEmpty) {
      print('Nested TLVs:');
      for (TLV nestedTLV in nestedTLVs) {
        nestedTLV.printTLV();
      }
    }
  }
}
