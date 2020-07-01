//
//  TaskListRouter.swift
//  Todo App
//
//  Created by A on 6/30/20.
//  Copyright © 2020 Taha. All rights reserved.
//


import UIKit


protocol TaskListRouting {
    
    func getTaskFromSelectedRow(controller:UIViewController,Task:taskModel) -> Void
}

class TaskListRouter{
    
    
    var view : UIViewController
    init(view: UIViewController) {
        self.view = view
    }
    
}

extension TaskListRouter:TaskListRouting{
    func getTaskFromSelectedRow(controller:UIViewController,Task: taskModel) {
//        print("controller",Task.cnotext)
        
        let DetailedViewController = DetailedTaskBuilder()
       let Result =  DetailedViewController.Build(Model: Task)
        controller.navigationController?.pushViewController(Result, animated: true)
    }
    
    
}
