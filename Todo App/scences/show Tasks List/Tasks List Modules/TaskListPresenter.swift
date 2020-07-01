//
//  TaskListPresenter.swift
//  Todo App
//
//  Created by A on 6/30/20.
//  Copyright © 2020 Taha. All rights reserved.
//

import UIKit
import SQLite

protocol TaskListPresentation:class {
    func getNewTask(connection:Connection,title:String,context:String) -> Void
    func getNumberCell (section:Int) -> Int
    func configureCell(cell : taskListsCell , index : IndexPath)
    func getObjectsFromDataBase(database:Connection) -> Void
    func getTasksSuccesfullyFromDB(Tasks:[taskModel]) -> ()
    func deleteTask(index:IndexPath,database:Connection,TaskModel : taskModel) -> Void
    func getTaskForSpecificCell(index:IndexPath) -> taskModel
    func didSelectAtRow(controller:UIViewController,taskModel: taskModel) -> Void
//    func showw() -> Void
}

class TaskListPresenter : NSObject{
    var router : TaskListRouting
    var interactor : TaskListUseCases
    weak var view : taskListView?
    
    weak var delegate :TaskListPresentation?
    private var Tasks = [taskModel]()
  
    
    init(router : TaskListRouting, interactor : TaskListUseCases,view:taskListView) {
        self.interactor = interactor
        self.router = router
        self.view = view
    }
    
}

extension TaskListPresenter:TaskListPresentation{
    func didSelectAtRow(controller:UIViewController,taskModel: taskModel) {
        // send this Task to router and sent it to Detailed view controller
        router.getTaskFromSelectedRow(controller: controller, Task: taskModel)
    }
    
    func getTaskForSpecificCell(index: IndexPath) -> taskModel {
        return Tasks[index.row]
    }
    
    func deleteTask(index: IndexPath,database:Connection,TaskModel : taskModel) {
        self.Tasks.remove(at: index.row)
        interactor.detletTask(database: database, TaskModel: TaskModel)
        view?.reloadTaskTableView()
    }
    
   
    
    func getTasksSuccesfullyFromDB(Tasks: [taskModel]) {
        self.Tasks = Tasks
        view?.reloadTaskTableView()
//        print(Tasks[0].title)
    }
    
    func getObjectsFromDataBase(database: Connection) {
        interactor.getModelFromDataBase(database: database)
    }
    
    func configureCell(cell: taskListsCell, index : IndexPath) {
        cell.configureTaskCell(model: Tasks, index: index)
    }
    
    func getNumberCell(section: Int) -> Int {
        return Tasks.count
    }
    
    func getNewTask(connection:Connection,title:String,context:String){
        let taksInstance = taskModel(title: title, context: context)
        Tasks.append(taksInstance)
        view?.reloadTaskTableView()
        interactor.saveContextToRealm(connection: connection, Model: taksInstance)
    }
}
