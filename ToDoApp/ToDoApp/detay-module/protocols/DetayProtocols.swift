//
//  DetayProtocols.swift
//  ToDoApp
//
//  Created by Sedat Samet Oypan on 14.10.2022.
//

import Foundation

protocol ViewToPresenterDetayProtocol {
    var detayInteractor:PresenterToInteractorDetayProtocol? {get set}
    func guncelle(todo_id:Int, todo_text:String,todo_tarih:String)
}

protocol PresenterToInteractorDetayProtocol {
    func toDoGuncelle(todo_id:Int, todo_text:String, todo_tarih:String)
}

protocol PresenterToRouterDetayProtocol {
    static func createModule(ref:DetayViewController)
}
