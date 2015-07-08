americano = require 'americano'

module.exports = Group = americano.getModel 'Group',
    name: String
    people: [String]

