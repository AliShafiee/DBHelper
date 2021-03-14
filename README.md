# DBHelper
A swift wrapper for work with core data

## How to use

### Create:
            let user = User(context: DBHelper.shared.context)
            user.name = "Ali"
            DBHelper.shared.write()

### Retrieve:
            let users = DBHelper.shared.retrieveAll(User.self)

### Update:
            let user = users[0]
            user.name = "Hasan"
            DBHelper.shared.write()
            
### Delete:
            let userForDelete = users[0]
            DBHelper.shared.deleteObject(userForDelete)
            
