//
//  AnasayfaProtocols.swift
//  ToDoApp
//
//  Created by Sedat Samet Oypan on 14.10.2022.
//

import Foundation

protocol ViewToPresenterAnasayfaProtocol {
    var anasayfaInteractor:PresenterToInteractorAnasayfaProtocol? {get set}
    var anasayfaView: PresenterToViewAnasayfaProtocol? {get set}
    
    func yapilacaklarYukle()
    func ara(aramaKelimesi:String)
    func sil(todo_id:Int)
    func guncelle(todo_id:Int, todo_done:String)
}
protocol PresenterToInteractorAnasayfaProtocol {
    var anasayfaPresenter: InteractorToPresenterAnasayfaProtocol? {get set}
    
    func tumYapilacaklarAl()
    func yapilacakAra(aramaKelimesi:String)
    func yapilacakSil(todo_id:Int)
    func yapilacakGuncelle(todo_id:Int, todo_done:String)
}

protocol InteractorToPresenterAnasayfaProtocol {
    func presenteraVeriGonder(yapilacakListesi:[Yapilacaklar])
}

protocol PresenterToViewAnasayfaProtocol {
    func vieweVeriGonder(yapilacakListesi:[Yapilacaklar])
}

protocol PresenterToRouterAnasayfaProtocol {
    static func createModule(ref:ViewController)
}
