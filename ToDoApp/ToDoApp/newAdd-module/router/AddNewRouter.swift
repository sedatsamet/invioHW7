//
//  AddNewRouter.swift
//  ToDoApp
//
//  Created by Sedat Samet Oypan on 14.10.2022.
//

import Foundation

class AddNewRouter : PresenterToRouterAddNewProtocol {
    static func createModule(ref: AddNewViewController) {
        ref.todoEklePresenterNesnesi = AddNewPresenter()
        ref.todoEklePresenterNesnesi?.addNewInteractor = AddNewInteractor()
    }
}
