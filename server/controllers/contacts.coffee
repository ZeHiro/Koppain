Contact = require '../models/contact'

module.exports.all = (req,res) ->
    Contact.all (err, contacts) ->
        if err?
            res.status(500).send(error: 'server_error_retrieve_data')
        else
            res.status(200).send(contacts)
