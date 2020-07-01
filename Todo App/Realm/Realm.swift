//
//  Realm.swift
//  Todo App
//
//  Created by A on 6/30/20.
//  Copyright © 2020 Taha. All rights reserved.
//

import UIKit
import SQLite

class SqliteClass:NSObject{
    
static let shared = SqliteClass()
     override init() { }
    
    
    var interactor : TaskListUseCases!
    let usersTable = Table("Tasks")
    
    let title = Expression<String>("title")
    let context = Expression<String>("context")
    
    private var tasksFromDB = [taskModel]()
    
       
    
    func saveContext(database:Connection,Model:taskModel){
        guard let title = Model.title , !title.isEmpty else{return}
        guard let context = Model.cnotext , !context.isEmpty else{return}
        let insertUser = self.usersTable.insert(self.title <- title, self.context <- context)
        
        do {
            try database.run(insertUser)
            print("INSERTED USER")
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func ListTasksFroDB(database:Connection,completion:@escaping([taskModel]) -> ()){
        
        do {
            let tasks = try database.prepare(self.usersTable)
            
            for TaksDB in tasks {
                
                let Task = taskModel(title: TaksDB[self.title], context: TaksDB[self.context])
                print("Task",Task.title , "  ",Task.cnotext)
                tasksFromDB.append(Task)
                
            }
        } catch {
            print(error)
        }
        //        print(tasksFromDB.count)
        completion(tasksFromDB)
    }
    
    func DetleteTask(database:Connection,taskModel : taskModel){
        guard let title = taskModel.title , !title.isEmpty else {
            return
        }
        guard let context = taskModel.cnotext , !context.isEmpty else {
            return
        }
        let user = self.usersTable.filter(self.title == title && self.context == context)
        let deleteUser = user.delete()
        do {
            print("sucess to remove this object")
            try database.run(deleteUser)
        } catch {
            print("failed to remove this object")
            print(error)
        }
    }
    
    func editTask(database:Connection,taskModel : taskModel){
        
        guard let title = taskModel.title else {
            return
        }
        
        guard let context = taskModel.cnotext else {
            return
        }
        print("title",title  ,  "    " , context)
        
        let task = self.usersTable.filter(self.title == title || self.context == context)
        
        let updateUser = task.update(self.title <- title , self.context <- context)
                  do {
                      try database.run(updateUser)
                    print("suces to update")
                  } catch {
                      print(error)
                    print("failed to update")
        }
    }
}

