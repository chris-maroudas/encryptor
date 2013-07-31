class Encryptor

  attr_reader :rotation

  def initialize(rotation)
    @rotation = rotation
  end

  def cipher
    characters = (' '..'z').to_a
    rotated_characters = characters.rotate(rotation)
    pairs = characters.zip(rotated_characters)
    Hash[pairs]
  end

  def opposite_cipher

    hash = {}

    cipher.collect do |key, value|
      hash[value] = key
    end

    hash
  end

  def encrypt_letter(letter)
    cipher[letter]
  end

  def decrypt_letter(letter)
    opposite_cipher[letter]
  end

  def encrypt(string)

    phrase = string.split('').collect do |letter|
      encrypt_letter(letter)
    end

    phrase.join
  end


  def decrypt(string)

    phrase = string.split('').collect do |letter|
      decrypt_letter(letter)
    end

    phrase.join
  end


  def encrypt_file(filename)
    input = File.open(filename, "r")
    message = input.read
    input.close

    output = File.open(filename + '.encrypted', "w")
    output.write(encrypt(message))
    output.close
  end

  def decrypt_file(filename)
    input = File.open(filename, "r")
    message = input.read
    input.close

    output = File.open(filename + '.decrypted', "w")
    output.write(decrypt(message))
    output.close
  end

end