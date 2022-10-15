//
//  DetayViewController.swift
//  ToDoApp
//
//  Created by Sedat Samet Oypan on 14.10.2022.
//

import UIKit

class DetayViewController: UIViewController {

    @IBOutlet weak var todoTextField: UITextField!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var buttonUpdate: UIButton!
    @IBOutlet weak var titleTextLabel: UILabel!
    
    var todo:Yapilacaklar?
    
    var datePicker:UIDatePicker?
    
    var detayPresenterNesnesi : ViewToPresenterDetayProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DetayRouter.createModule(ref: self)
        
        viewDesignSetup()
        
        if let t = todo {
            todoTextField.text = t.todo_text
            dateTextField.text = t.todo_tarih
        }
    }
    
    @IBAction func buttonUpdate(_ sender: Any) {
        if let todoText = todoTextField.text, let todoTarih = dateTextField.text, let t = todo {
            detayPresenterNesnesi?.guncelle(todo_id: t.todo_id!, todo_text: todoText, todo_tarih: todoTarih)
        }
    }
}

extension DetayViewController {
    func viewDesignSetup(){
        datePicker = UIDatePicker()
        datePicker?.datePickerMode = .date
        dateTextField.inputView = datePicker
        
        if #available(iOS 13.4, *) {
            datePicker?.preferredDatePickerStyle = .wheels
        }
        
        let dokunmaAlgilama = UITapGestureRecognizer(target: self, action: #selector(dokunmaAlgilamaMetod))
        view.addGestureRecognizer(dokunmaAlgilama)
        
        datePicker?.addTarget(self, action: #selector(tarihGoster(uiDatePicker:)), for: .valueChanged)
        
        buttonUpdate.layer.cornerRadius = 15
        buttonUpdate.clipsToBounds = true
        buttonUpdate.tintColor = UIColor.black
        
        titleTextLabel.font = UIFont(name: "Roboto-Italic", size: 40)
    }
    
    @objc func dokunmaAlgilamaMetod(){
        view.endEditing(true)
    }
    
    @objc func tarihGoster(uiDatePicker:UIDatePicker){
        let format = DateFormatter()
        format.dateFormat = "dd/MM/yyyy"
        let alinanTarih = format.string(from: uiDatePicker.date)
        dateTextField.text = alinanTarih
    }
}
