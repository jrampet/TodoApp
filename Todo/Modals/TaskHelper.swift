//
//  TaskHelper.swift
//  Todo
//
//  Created by Jeyaram on 10/06/21.
//

import UIKit
import CoreData
class TaskHelper{
    static func delete(completedTask:NSManagedObject){
        print("Deleting")
        let context = Core.viewcontext
        context.remove(completedTask)
    }
    
    static func fetchData<T:NSManagedObject>(entity:T.Type,namePredicate:NSPredicate?=nil,completion:([T]?)->()){
        do{
            let request = T.fetchRequest()
            request.predicate = namePredicate
            let task = try Core.viewcontext.fetch(request) as? [T]
            
            completion(task)
        }catch{
            print("Errors")
        }
    }
    
    
}

extension NSManagedObjectContext{
    func saveContext(){
        do{
            try self.save()
        }catch{
            print("Error in saving")
        }
    }
    
    func remove(_ element:NSManagedObject){
        self.delete(element)
        saveContext()
    }
    

}
/*extension NSManagedObject{
    func fetchAll(){
        let container = TaskHelper.container
        let context = container.viewContext
        do{
            let task = try context.fetch(.fetchRequest())
            completion(task)
        }catch{
            print("Error in Fetch")
        }
    }
}*/
