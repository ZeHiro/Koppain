Expense = require '../models/expense'
Balance = require '../models/balance'


module.exports.addexpense = (req, res) ->
    expense = req.body
    Balance.exists req.params.balanceID, (err, IsExist) ->
        if err?
            res.status(500).send(error: "server_error: #{err}")
            return
        else if not IsExist
            res.status(404).send(error: "balance_not_found")
            return
        else
            expense.balanceId = req.params.balanceID
            Expense.create expense, (err,expense) ->
                if err?
                    res.status(500).send(error: "server_error: #{err}")
                    return
                else
                    res.sendStatus 201

module.exports.updateexpense = (req,res) ->
    expense=req.body
    Expense.exists req.params.expenseID, (err, IsExist) ->
        if err?
            res.status(500).send(error: "server_error: #{err}")
            return
        else  if not IsExist
            res.status(404).send(error: "expense_not_found")
            
            
                
module.exports.deleteexpense = (req,res) ->
    Expense.exists req.params.expenseID, (err, IsExist) ->
        if err?
            res.status(500).send(error: "server_error: #{err}")
            return
        else  if not IsExist
            res.status(404).send(error: "expense_not_found")
            return
        else
            Expense.destroy req.params.expenseID, (err) ->
                if err?
                    res.status(500).send(error: "server_error: #{err}")
                    return
                else
                    res.sendStatus 204
                        
module.exports.getAllbyBalanceID = (req,res) ->
    Balance.exists req.params.balanceID, (err, IsExist) ->
        if err?
            res.status(500).send(error: "server_error: #{err}")
            return
        else if not IsExist
            res.status(404).send(error: "balance_not_found")
            return
        else
            Expense.allByBalanceID req.params.balanceID, (err, expenses) -> 
                if err?
                    res.status(500).send(error: "server_error: #{err}")
                    return
                else
                    res.status(200).send expenses

