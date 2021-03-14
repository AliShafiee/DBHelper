//
//  CoreDataHelper.swift
//  Ali Shafiee
//
//  Created by Ali Shafiee on 12/24/1399 AP.
//

import Foundation
import CoreData

class DBHelper {
   
    static var shared = DBHelper()

    var context: NSManagedObjectContext = {
        let container = NSPersistentContainer(name: "ParkingLottery")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container.viewContext
    }()
    
    func saveContext () {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    ///Create and Update an entity
    func write() {
        saveContext()
    }
    
    ///Get all values from an entity
    func retrieveAll<T: NSManagedObject>(_ entity: T.Type, predicate: NSPredicate? = nil, sortDescriptor: [NSSortDescriptor]? = nil) -> [T] {
        let request = NSFetchRequest<T>(entityName: String(describing: T.self))
        request.predicate = predicate
        request.sortDescriptors = sortDescriptor
        do {
            let values = try context.fetch(request)
            return values
        } catch {
            print(error.localizedDescription)
            return []
        }
    }
    
    ///Delete object from db
    func deleteObject<T: NSManagedObject>(_ object: T) {
        context.performAndWait {
            context.delete(object)
            saveContext()
        }
    }
    
    ///Purge Entity
    func purge<T: NSManagedObject>(entity: T.Type) {
        context.performAndWait {
            do {
                let request = T.fetchRequest() as! NSFetchRequest<T>
                let objects = try context.fetch(request)
                objects.forEach {
                    context.delete($0)
                }
                saveContext()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
