//
//  DetailedTaskPrester.swift
//  Todo App
//
//  Created by A on 7/1/20.
//  Copyright © 2020 Taha. All rights reserved.
//

import UIKit
import SQLite
protocol  detailedTaskPresentation:class {
    func editTask(dataBase:Connection,Title:String,context:String) -> Void
    func deleteTask(connection:Connection,TaskModel : taskModel) -> Void
    
}

class DetailedTaskPrester{
    
    weak var view:getDetailedTask?
    var interactor : DetailedTaskUseCases
    var router : DetailedTaskRouting
    init(view: getDetailedTask , interactor:DetailedTaskUseCases,router:DetailedTaskRouting) {
        self.router = router
        self.interactor = interactor
        self.view = view
    }
}
extension DetailedTaskPrester:detailedTaskPresentation{
    func deleteTask(connection: Connection, TaskModel: taskModel) {
        interactor.deleteTask(model: TaskModel, connection: connection)
        router.popView()
    }
    
    func editTask(dataBase:Connection,Title: String, context: String) {
        interactor.EditTask(database: dataBase, Title: Title, context: context)
        let editedTask = taskModel(title: Title, context: context)
        view?.setNewEditedTask(model:editedTask)
//        router.popView()
    }
    
    
}
