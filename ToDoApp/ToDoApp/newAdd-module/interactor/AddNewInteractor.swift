//
//  AddNewInteractor.swift
//  ToDoApp
//
//  Created by Sedat Samet Oypan on 14.10.2022.
//

import Foundation

class AddNewInteractor : PresenterToInteractorAddNewProtocol{
    
    let db:FMDatabase?
    
    init(){
        let hedefYol = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let kopyalanacakYer = URL(fileURLWithPath: hedefYol).appendingPathComponent("toDo.sqlite")
        db = FMDatabase(path: kopyalanacakYer.path)
    }
    
    func toDoEkle(todo_text: String, todo_tarih: String) {
        db?.open()
        do{
            try db!.executeUpdate("INSERT INTO yapilacaklar (todo_text,todo_tarih,todo_done) VALUES (?,?,?)", values: [todo_text,todo_tarih,"0"])
        }catch{
            print(error.localizedDescription)
        }
        db?.close()
    }
    
    
}
