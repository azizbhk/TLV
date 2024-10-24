void main() {
  // Predefined test string (CIN example)
  final testString = "CN0812341234";

  // Get the first 2 characters (Tag)
  String name = testString.substring(0, 2);
  print("First 2 characters: $name");

  // Get the next 2 characters (Length)
  String length = testString.substring(2, 4);
  print("Second 2 characters: $length");

  // Get the remaining characters (8 characters total), and process them in chunks of 4
  String code = testString.substring(4);
  print("Processing remaining characters in chunks of 4:");
  
  for (int i = 0; i < code.length; i += 4) {
    // Get the chunk, ensuring we don't go out of bounds
    String chunk = code.length > i + 4 ? code.substring(i, i + 4) : code.substring(i);
    print("Chunk: $chunk");
  }

  // Example of National Identity Card (CIN)
  String cin = '14440050'; // Example CIN

  // Encode in TLV format
  String tlvEncoded = encodeTLV('CN', cin);
  print('TLV Encoded: $tlvEncoded');

  // Decode the TLV-encoded data
  decodeTLV(tlvEncoded);
}

// Function to encode in TLV format
String encodeTLV(String tag, String value) {
  int length = value.length; // Calculate the length of the value
  String lengthStr = length.toString().padLeft(2, '0'); // Format length as 2 characters
  return '$tag$lengthStr$value'; // Return the TLV string (Tag + Length + Value)
}

// Function to decode TLV-encoded data
void decodeTLV(String tlvData) {
  // Extract the Tag (first 3 characters represent the Tag)
  String tag = tlvData.substring(0, 2); // Example: "CN" (2 characters for the Tag)
  
  // Extract the length (next 2 characters)
  String length = tlvData.substring(2, 4); // Length formatted to 2 characters

  // Extract the value based on the length
  int valueLength = int.parse(length); // Convert length to an integer
  String value = tlvData.substring(4, 4 + valueLength); // Extract value based on the length

  // Display the results
  print('Tag: $tag');
  print('Length: $length');
  print('Value: $value');
}
