americano = require 'americano'

allByBalanceId = (doc) -> emit doc.balanceId, doc



module.exports =
    group:
        all: americano.defaultRequests.all
    balance:
        all: americano.defaultRequests.all
    expense:
        allByBalanceID: allByBalanceId


