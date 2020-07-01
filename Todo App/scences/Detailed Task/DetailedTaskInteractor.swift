//
//  DetailedTaskInteractor.swift
//  Todo App
//
//  Created by A on 7/1/20.
//  Copyright © 2020 Taha. All rights reserved.
//


import UIKit
import SQLite
protocol  DetailedTaskUseCases {
    func EditTask(database:Connection , Title:String,context:String)
    func deleteTask(model:taskModel,connection:Connection)
}

class DetailedTaskInteractor{
    weak var detailedTaskPrestner : detailedTaskPresentation?
}
extension DetailedTaskInteractor:DetailedTaskUseCases{
    func deleteTask(model: taskModel, connection: Connection) {
         let instanceSlqite = SqliteClass()
        instanceSlqite.DetleteTask(database: connection, taskModel: model)
    }
    
    func EditTask(database: Connection, Title: String, context: String) {
        let TaskModel = taskModel(title: Title, context: context)
        let instanceSlqite = SqliteClass()
        instanceSlqite.editTask(database: database, taskModel: TaskModel)
    }
    
    
}
