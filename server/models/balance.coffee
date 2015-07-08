americano = require 'americano'

module.exports = Balance = americano.getModel 'Balance',
    name: String
    groupID: String
    dateStart: Date
    dateEnd: Date
