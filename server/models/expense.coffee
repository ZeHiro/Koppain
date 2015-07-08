americano = require 'americano'
async = require 'async'

module.exports = Expense = americano.getModel 'Expense',
    name: String
    value: Number
    balanceId: String
    payerId: String
    payees: [payeeId: String, percentage: Number]


Expense.allByBalanceID = (balanceId, callback) ->
    params = 
        key: balanceId
    Expense.request "allByBalanceID", params, callback
    

Expense.destroyByBalanceID = (balanceId, callback) ->
    Expense.allByBalanceID balanceId, (err, expenses) ->
        if err?
            callback err
            return
        else
            async.each expenses, Expense.delete, callback


Expense.delete = (expense, callback) ->
    Expense.destroy expense.id, callback
            
