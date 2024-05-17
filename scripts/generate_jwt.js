const fs = require('fs');
const jwt = require('jsonwebtoken');

// Replace these values with your own
const privateKey = fs.readFileSync('/Users/lavkushkumar/Desktop/Tes/my_map_app/scripts/AuthKey_P35NWTG52J.p8');
const keyId = 'P35NWTG52J';
const teamId = '744228JDT4';
const now = Math.floor(Date.now() / 1000);
const expirationTime = now + (60 * 60 * 24); // Token valid for 24 hours

const payload = {
  iss: teamId,
  iat: now,
  exp: expirationTime
};

const token = jwt.sign(payload, privateKey, {
  algorithm: 'ES256',
  header: {
    alg: 'ES256',
    kid: keyId
  }
});

console.log(token);
