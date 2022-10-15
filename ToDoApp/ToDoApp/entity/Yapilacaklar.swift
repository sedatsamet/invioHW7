//
//  Yapilacaklar.swift
//  ToDoApp
//
//  Created by Sedat Samet Oypan on 14.10.2022.
//

import Foundation

class Yapilacaklar {
    var todo_id:Int?
    var todo_text:String?
    var todo_tarih:String?
    var todo_done:String = "0"
    
    init(todo_id: Int, todo_text: String, todo_tarih: String, todo_done: String) {
        self.todo_id = todo_id
        self.todo_text = todo_text
        self.todo_tarih = todo_tarih
        self.todo_done = todo_done
    }
}
