Group = require '../models/group'

module.exports.all = (req, res) ->
    Group.all (err, groups) ->
        if err?
            res.status(500).send(error: 'server_error_retrieve_data')
        else
            res.status(200).send(groups)
             

#Create a new group
module.exports.create = (req, res) ->
    group = req.body
    console.log group
    if not group.people?
        res.status(400).send(error:'missing_parameter: people')
        return
    if not group.name?
        res.status(400).send(error:'missing_parameter: name')
        return
    Group.create group, (err,newGroup) ->          
        if err?
            res.status(500).send(error:'server_error_create_group')
            return
        else
            res.status(201).send newGroup
            
#Update the group data
module.exports.update = (req, res) ->
    group = req.body
    if not group.people? and  not group.name?
        res.status(400).send(error:'missing_parameter: people')
        return
    Group.exists req.params.groupID, (err, IsExist) ->
        if err?
            res.status(500).send(error: "server_error: #{err}")
            return
        else if not IsExist
            res.status(404).send(error: 'group_not_found')
            return
        else    
            Group.updateAttributes req.params.groupID, group, (err, updatedGroup) ->
                if err?
                    res.status(500).send(error: "could_not_update: #{err}")
                    return
                res.sendStatus 200
        
#Delete a group
module.exports.delete = (req, res) ->
    Group.exists req.params.groupID, (err, IsExist) ->
        if err?
            res.status(500).send(error: "could_not_find: #{err}")
            return
        else if not IsExist
            res.status(404).send(error: 'group_not_found')
            return
        else
            Group.destroy req.params.groupID, (err) ->
                if err?
                    res.status(500).send(error: "could_not_delete: #{err}")
                    return
                else
                    res.sendStatus 204

#Add a member to the group
module.exports.addmember = (req, res) ->
    Group.exists req.params.groupID, (err, IsExist) ->
        if err?
            res.status(500).send(error: "coudld_not_find: #{err}")
            return
        else if not IsExist
            res.send(404).send("group_not_found")
        else
            Group.find req.params.groupID, (err, found_group) ->
                if err?
                    req.status(500).send(error: "coudld_not_find: #{err}")
                    return
                else
                    found_group.people.push req.body
                    Group.updateAttributes req.params.groupID, found_group, (err, updated_group) ->
                        if err?
                            res.status(500).send(error: "could_no_update: #{err}")
                            return
                        else
                            res.sendStatus 200
                            
#DElete a member of the group
module.exports.deletemember = (req, res) ->
    Group.exists req.params.groupID, (err, IsExist) ->
        if err?
            res.status(500).send(error: "could_not_find: #{err}")
            return
        else if not IsExist
            res.status(404).send("group_not_found")
            return
        else
            Group.find req.params.groupID, (err, found_group) ->
                if err?
                    res.status(500).send(error: "could_not_find: #{err}")
                    return
                else
                    member_idx = found_group.indexOf req.params.memberID
                    if member_idx isnt -1
                        found_group.splice member_idx, 1
                        Goup.updateAttributes req.params.groupID, found_group, (err, updated_group) ->
                            if err?
                                res.status(500).send(error: "could_no_update: #{err}")
                                return
                            else
                                res.sendStatus 204
