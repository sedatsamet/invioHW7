//
//  AnasayfaPresenter.swift
//  ToDoApp
//
//  Created by Sedat Samet Oypan on 14.10.2022.
//

import Foundation

class AnasayfaPresenter : ViewToPresenterAnasayfaProtocol {

    var anasayfaInteractor: PresenterToInteractorAnasayfaProtocol?
    
    var anasayfaView: PresenterToViewAnasayfaProtocol?
    
    func yapilacaklarYukle() {
        anasayfaInteractor?.tumYapilacaklarAl()
    }
    
    func ara(aramaKelimesi: String) {
        anasayfaInteractor?.yapilacakAra(aramaKelimesi: aramaKelimesi)
    }
    
    func sil(todo_id: Int) {
        anasayfaInteractor?.yapilacakSil(todo_id: todo_id)
    }
    
    func guncelle(todo_id: Int, todo_done: String) {
        anasayfaInteractor?.yapilacakGuncelle(todo_id: todo_id, todo_done: todo_done)
    }
}

extension AnasayfaPresenter : InteractorToPresenterAnasayfaProtocol {
    func presenteraVeriGonder(yapilacakListesi: [Yapilacaklar]) {
        anasayfaView?.vieweVeriGonder(yapilacakListesi: yapilacakListesi)
    }
}
