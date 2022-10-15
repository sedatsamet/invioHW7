//
//  AddNewPresenter.swift
//  ToDoApp
//
//  Created by Sedat Samet Oypan on 14.10.2022.
//

import Foundation

class AddNewPresenter : ViewToPresenterAddNewProtocol {
    var addNewInteractor: PresenterToInteractorAddNewProtocol?
    
    func ekle(todo_text: String, todo_tarih: String) {
        addNewInteractor?.toDoEkle(todo_text: todo_text, todo_tarih: todo_tarih)
    }
    
    
}
