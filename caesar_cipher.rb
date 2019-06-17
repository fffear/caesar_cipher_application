require 'sinatra'
require 'sinatra/reloader' if development?

def caesar_cipher(string, shift_factor)
  caesar_cipher_string = ""
  key_codes = string.chars.map(&:ord)

  key_codes.each_with_index do |key_code, index|
    (key_code >= 65 && key_code <= 90) ? key_codes[index] = (key_code - 65 + shift_factor) % 26 + 65 : #Uppercase Letters
    (key_code >= 97 && key_code <= 122) ? key_codes[index] = (key_code - 97 + shift_factor) % 26 + 97 : nil #Lowercase Letters
  end

  key_codes.each_with_index { |key_code, index| key_codes[index] = key_code.chr }
  caesar_cipher_string = key_codes.join()
end

get '/' do
  erb :index
end

get '/ciphered_code_page' do
  unciphered_code = params['unciphered_code']
  shift_factor = params['shift_factor']
  ciphered_code = caesar_cipher(unciphered_code, shift_factor.to_i)
  erb :ciphered_code_page, :locals => {:unciphered_code => unciphered_code, :ciphered_code => ciphered_code}
end