//
//  DetayRouter.swift
//  ToDoApp
//
//  Created by Sedat Samet Oypan on 14.10.2022.
//

import Foundation

class DetayRouter : PresenterToRouterDetayProtocol {
    static func createModule(ref: DetayViewController) {
        ref.detayPresenterNesnesi = DetayPresenter()
        ref.detayPresenterNesnesi?.detayInteractor = DetayInteractor()
    }
}
