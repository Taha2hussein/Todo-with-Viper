//
//  TaskListInteractor.swift
//  Todo App
//
//  Created by A on 6/30/20.
//  Copyright © 2020 Taha. All rights reserved.
//

import UIKit
import SQLite

protocol TaskListUseCases {
    func saveContextToRealm(connection:Connection,Model :taskModel) -> Void
    func getModelFromDataBase(database:Connection) -> ()
    func detletTask(database:Connection,TaskModel : taskModel) -> Void
}

class TaskListInteractor{
    weak var presenter : TaskListPresentation?
  
}

extension TaskListInteractor:TaskListUseCases{
    func detletTask( database: Connection, TaskModel: taskModel) {
        let deteletTask = SqliteClass()
        deteletTask.DetleteTask(database: database, taskModel: TaskModel)
    }
    
    func getModelFromDataBase(database:Connection) {
     let taskFromDB = SqliteClass()
        taskFromDB.ListTasksFroDB(database: database) {[weak self] (taskFromDB) in
            self?.presenter?.getTasksSuccesfullyFromDB(Tasks: taskFromDB)
//            print(taskFromDB.count)
        }
    }
    
    func saveContextToRealm(connection:Connection,Model: taskModel) {
     let sqlite = SqliteClass()
        sqlite.saveContext(database: connection, Model: Model)
    }
    
    
    
}
