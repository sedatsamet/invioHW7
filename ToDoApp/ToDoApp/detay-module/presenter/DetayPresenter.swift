//
//  DetayPresenter.swift
//  ToDoApp
//
//  Created by Sedat Samet Oypan on 14.10.2022.
//

import Foundation

class DetayPresenter : ViewToPresenterDetayProtocol{
    var detayInteractor: PresenterToInteractorDetayProtocol?
    
    func guncelle(todo_id: Int, todo_text: String, todo_tarih:String) {
        detayInteractor?.toDoGuncelle(todo_id: todo_id, todo_text: todo_text, todo_tarih: todo_tarih)
    }
}
