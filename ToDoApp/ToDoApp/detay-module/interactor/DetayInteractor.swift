//
//  DetayInteractor.swift
//  ToDoApp
//
//  Created by Sedat Samet Oypan on 14.10.2022.
//

import Foundation

class DetayInteractor : PresenterToInteractorDetayProtocol {
    let db:FMDatabase?
    
    init(){
        let hedefYol = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let kopyalanacakYer = URL(fileURLWithPath: hedefYol).appendingPathComponent("toDo.sqlite")
        db = FMDatabase(path: kopyalanacakYer.path)
    }
    func toDoGuncelle(todo_id: Int, todo_text: String,todo_tarih:String) {
        db?.open()
        do{
            try db!.executeUpdate("UPDATE yapilacaklar SET todo_text = ? , todo_tarih = ? WHERE todo_id = ?", values: [todo_text,todo_tarih,todo_id])
        }catch{
            print(error.localizedDescription)
        }
        db?.close()
    }
    
    
}
