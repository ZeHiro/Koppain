groups = require './groups'
contacts = require './contacts'
balances = require './balances'
expenses = require './expenses'

module.exports =
    #Groups
    'groups':
        get: groups.all
        post: groups.create
        
    'groups/:groupID':
        put: groups.update
        delete: groups.delete

#    'groups/:groupID/members':
#        post: groups.addmember
    
#    'groups/: groupID/members/:memberID':
#        delete: groups.deletemember
        
        
    #Contacts
    'contacts':
        get: contacts.all
    
    #balance management
    'balances':
        get: balances.all   #OK
        post: balances.create  #OK
        
    'balances/:balanceID':
        get: balances.show #OK
        delete: balances.delete #OK
        put: balances.update #Incomplete : update only non expenses.
        
    'balances/:balanceID/expenses':
        get: expenses.getAllbyBalanceID #OK
        post: [expenses.addexpense] #OK
    
    'balances/:balanceID/expenses/:expenseID':
        put: expenses.updateexpense  #OK
        delete: expenses.deleteexpense #OK
    
    #Public access
#    'public/:balanceID/'
#        get: public.getbalance
#
#    'public/:balaceID/addexpense'
#        put: [public.addexpense]
        
        
        
        

