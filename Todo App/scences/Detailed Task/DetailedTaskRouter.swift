//
//  DetailedTaskRouter.swift
//  Todo App
//
//  Created by A on 7/1/20.
//  Copyright © 2020 Taha. All rights reserved.
//

import UIKit

protocol  DetailedTaskRouting {
 
    func popView() -> Void
}

class DetailedTaskRouter{
    
     var view : UIViewController?
    init(view:UIViewController) {
        self.view = view
    }
}
extension DetailedTaskRouter:DetailedTaskRouting{
    func popView( ) {
        view?.navigationController?.popViewController(animated: true)
    }
    
    
}
