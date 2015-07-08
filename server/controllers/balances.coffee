Balance = require '../models/balance'
Expense = require '../models/expense'

module.exports.all = (req,res) ->
    Balance.all (err, balances) ->
        if err?
            res.status(500).send(error: 'server_error_retrieve_data')
        else
            res.status(200).send balances


module.exports.create = (req, res) ->
    balance = req.body
    if not balance.name?
        res.status(400).send(error:'missing_parameter: name')
        return
    if not balance.groupID?
        res.status(400).send(error:'missing_parameter: groupID')
        return
    Balance.create balance, (err,balance) ->
        if err?
            res.status(500).send(error:'server_error_create_balance')
            return
        else
            res.status(201).send balance

module.exports.update = (req,res) ->
    balance = req.body
    Balance.exists req.params.balanceID, (err, IsExist) ->
        if err?
            res.status(500).send(error: "server_error: #{err}")
            return
        else if not IsExist
            res.status(404).send(error: "balance_not_found")
            return
        else
            Balance.updateAttributes req.params.balanceID, balance, (err, updatedBalance) ->
                if err?
                    res.status(500).send(error: "server_error: #{err}")
                    return
                res.sendStatus 200
                
module.exports.show = (req,res) ->
    Balance.exists req.params.balanceID, (err,IsExist) ->
        if err?
            res.status(500).send(error: "server_error: #{err}")
            return
        else if not IsExist
            res.status(404).send(error: "balance_not_found")
            return
        else
            Balance.find req.params.balanceID, (err, balance) ->
                if err?
                    res.status(500).send(error: "server_error: #{err}")
                    return
                res.send(200).send balance

module.exports.delete = (req, res) ->
    Balance.exists req.params.balanceID, (err, IsExist) ->
        if err?
            res.status(500).send(error: "server_error: #{err}")
            return
        else if not IsExist
            res.status(404).send(error: "balance_not_found")
            return
        else
            Expense.destroyByBalanceID req.params.balanceID, (err) ->
                if err?
                    res.status(500).send(error: "server_error: #{err}")
                    return
                    
                Balance.destroy req.param.balanceID , (err) ->
                    if err?
                        res.status(500).send(error: "server_error: #{err}")
                        return
                    else
                        res.send(204)

