//
//  AddNewProtocols.swift
//  ToDoApp
//
//  Created by Sedat Samet Oypan on 14.10.2022.
//

import Foundation

protocol ViewToPresenterAddNewProtocol {
    var addNewInteractor: PresenterToInteractorAddNewProtocol? {get set}
    func ekle(todo_text:String, todo_tarih:String)
}

protocol PresenterToInteractorAddNewProtocol {
    func toDoEkle(todo_text:String, todo_tarih:String)
}

protocol PresenterToRouterAddNewProtocol {
    static func createModule(ref:AddNewViewController)
}
