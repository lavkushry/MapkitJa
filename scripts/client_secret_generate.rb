require 'jwt'
require 'openssl'

team_id = '744228JDT4'
key_file = 'AuthKey_P35NWTG52J.p8'
client_id = 'maps.example.fluttermap'
key_id = 'P35NWTG52J'

ec_key = OpenSSL::PKey::EC.new File.read key_file
headers = {
  'kid' => key_id
}

claims = {
  'iss' => team_id,
  'iat' => Time.now.to_i,
  'exp' => Time.now.to_i + 1200, # Adjust expiration time as needed
  'aud' => 'https://appleid.apple.com',
  'sub' => client_id,
}

token = JWT.encode claims, ec_key, 'ES256', headers

puts token