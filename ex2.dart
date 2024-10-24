void main() {
  // Example of a National Identity Card (CIN)
  String cin = '14440050'; // Example of CIN

  // Encoding in TLV format
  String tlvEncoded = encodeTLV('CIN', cin);
  print('TLV Encoded: $tlvEncoded');

  // Decoding the TLV
  decodeTLV(tlvEncoded);
}

// Function to encode TLV
String encodeTLV(String tag, String value) {
  int length = value.length; // Calculate the length of the value
  String lengthStr = length.toString().padLeft(2, '0'); // Format length to 2 characters
  return '$tag$lengthStr$value'; // Return the TLV string (Tag + Length + Value)
}

// Function to decode TLV
void decodeTLV(String tlvData) {
  // Extract the Tag (the first characters represent the Tag, depending on its length)
  String tag = tlvData.substring(0, 3); // Example: "CIN" (3 characters for the Tag)
  
  // Extract the length (the next 2 characters)
  String length = tlvData.substring(3, 5); // Length formatted as 2 characters

  // Extract the value based on the length
  int valueLength = int.parse(length); // Convert the length to an integer
  String value = tlvData.substring(5, 5 + valueLength); // Extract the value based on the length

  // Display the results
  print('Tag: $tag');
  print('Length: $length');
  print('Value: $value');
}
