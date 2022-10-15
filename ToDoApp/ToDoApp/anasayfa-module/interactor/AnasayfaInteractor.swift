//
//  AnasayfaInteractor.swift
//  ToDoApp
//
//  Created by Sedat Samet Oypan on 14.10.2022.
//

import Foundation

class AnasayfaInteractor : PresenterToInteractorAnasayfaProtocol{
    var anasayfaPresenter: InteractorToPresenterAnasayfaProtocol?
    
    let db:FMDatabase?
    
    init(){
        let hedefYol = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let kopyalanacakYer = URL(fileURLWithPath: hedefYol).appendingPathComponent("toDo.sqlite")
        db = FMDatabase(path: kopyalanacakYer.path)
    }
    
    func tumYapilacaklarAl() {
        var liste = [Yapilacaklar]()
        
        db?.open()
        do{
            let r = try db!.executeQuery("SELECT * FROM yapilacaklar", values: nil)
            
            while r.next() {
                let yapilacak = Yapilacaklar(todo_id: Int(r.string(forColumn: "todo_id"))!, todo_text: r.string(forColumn: "todo_text"), todo_tarih: r.string(forColumn: "todo_tarih") , todo_done: r.string(forColumn: "todo_done"))
                liste.append(yapilacak)
            }
            anasayfaPresenter?.presenteraVeriGonder(yapilacakListesi: liste)
        }catch{
            print(error.localizedDescription)
        }
        db?.close()
    }
    
    func yapilacakAra(aramaKelimesi: String) {
        var liste = [Yapilacaklar]()
        
        db?.open()
        do{
            let r = try db!.executeQuery("SELECT * FROM yapilacaklar WHERE todo_text like '%\(aramaKelimesi)%'", values: nil)
            
            while r.next() {
                let yapilacak = Yapilacaklar(todo_id: Int(r.string(forColumn: "todo_id"))!, todo_text: r.string(forColumn: "todo_text"), todo_tarih: r.string(forColumn: "todo_tarih") , todo_done: r.string(forColumn: "todo_done"))
                liste.append(yapilacak)
            }
            anasayfaPresenter?.presenteraVeriGonder(yapilacakListesi: liste)
        }catch{
            print(error.localizedDescription)
        }
        db?.close()
    }
    
    func yapilacakSil(todo_id: Int) {
        db?.open()
        do{
            try db!.executeUpdate("DELETE FROM yapilacaklar WHERE todo_id = ?", values: [todo_id])
            tumYapilacaklarAl()
        }catch{
            print(error.localizedDescription)
        }
        db?.close()
    }
    
    func yapilacakGuncelle(todo_id: Int, todo_done: String) {
        var newStatus = todo_done
        if newStatus == "0" {
            newStatus = "1"
        }else{
            newStatus = "0"
        }
        db?.open()
        do{
            try db!.executeUpdate("UPDATE yapilacaklar SET todo_done = ? WHERE todo_id = ?", values: [newStatus,todo_id])
            tumYapilacaklarAl()
        }catch{
            print(error.localizedDescription)
        }
        db?.close()
    }
    
    
}
