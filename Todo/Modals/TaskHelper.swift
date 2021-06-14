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
        let context = Core.container.viewContext
        context.remove(completedTask)
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
