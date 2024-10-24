void main() {
  final testString = "CN0812341234";

  // Get the first 2 characters
  String name = testString.substring(0, 2);
  print("First 2 characters: $name");

  // Get the next 2 characters
  String length = testString.substring(2, 4);
  print("Second 2 characters: $length");

  // Get the remaining characters (8 characters total), and process them 4 by 4
  String code = testString.substring(4);
  List<String> chunks = []; // List to store the chunks

  for (int i = 0; i < code.length; i += 4) {
    // Get the chunk while ensuring we don't go out of bounds
    String chunk = code.length > i + 4 ? code.substring(i, i + 4) : code.substring(i);
    chunks.add(chunk); // Add the chunk to the list
  }
  
  // Print all the chunks in one line
  print("Chunks: ${chunks.join('')}");
}
