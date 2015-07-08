americano = require 'americano'
cozydb = require 'cozydb'

class DataPoint extends cozydb.Model
    @schema:
        name: String
        value: String
        type: String

module.exports = Contact = americano.getModel 'Contact',
    fn            : String
    n             : String
    datapoints    : [DataPoint]

    
