//
//  DetailedTaskBuilder.swift
//  Todo App
//
//  Created by A on 7/1/20.
//  Copyright © 2020 Taha. All rights reserved.
//

import UIKit
class DetailedTaskBuilder{
    
    func Build(Model : taskModel)-> UIViewController{
        
        let storyBaord = UIStoryboard.init(name: "Main", bundle: nil)
        let view = storyBaord.instantiateViewController(identifier: "DetailedTaskViewController")as! DetailedTaskViewController
        
        let interactor = DetailedTaskInteractor()
        let router = DetailedTaskRouter(view: view)
        let prestnenter = DetailedTaskPrester(view: view, interactor: interactor, router: router)
        interactor.detailedTaskPrestner = prestnenter
        view.presenter = prestnenter
        view.getDetailedTask(Model: Model)
        return view
    }
}
