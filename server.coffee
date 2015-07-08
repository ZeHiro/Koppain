americano = require 'americano'
params = 
    name: 'koppain'
    port: process.env.PORT || 9250
    host: process.env.HOST or '127.0.0.1'
    root: __dirname
americano.start params
