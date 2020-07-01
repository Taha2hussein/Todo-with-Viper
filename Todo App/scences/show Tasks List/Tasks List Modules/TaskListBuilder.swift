//
//  TaskListBuilder.swift
//  Todo App
//
//  Created by A on 6/30/20.
//  Copyright © 2020 Taha. All rights reserved.
//

import UIKit


class TaskListBuilder {
    static func Build() -> UIViewController
    {
        
        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
        
        let view = storyBoard.instantiateViewController(withIdentifier: "tasksViewController")as! tasksViewController
        
        let router = TaskListRouter(view: view)
        let interactor = TaskListInteractor()
        let presenter = TaskListPresenter(router: router, interactor: interactor, view: view)
        view.presenter = presenter
        interactor.presenter = presenter
        return view
    }
}
