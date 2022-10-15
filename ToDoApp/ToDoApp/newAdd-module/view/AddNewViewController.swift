//
//  AddNewViewController.swift
//  ToDoApp
//
//  Created by Sedat Samet Oypan on 14.10.2022.
//

import UIKit

class AddNewViewController: UIViewController {

    @IBOutlet weak var todoTextField: UITextField!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var buttonAddNew: UIButton!
    @IBOutlet weak var titleTextLabel: UILabel!
    
    
    var datePicker:UIDatePicker?
    
    var todoEklePresenterNesnesi:ViewToPresenterAddNewProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewDesignSetup()
        AddNewRouter.createModule(ref: self)
    }
    
    @IBAction func buttonAddNew(_ sender: Any) {
        if let todoTF = todoTextField.text, let dateTF = dateTextField.text {
            todoEklePresenterNesnesi?.ekle(todo_text: todoTF, todo_tarih: dateTF)
            let alert = UIAlertController(title: "Ekleme Başarılı", message: "\(todoTF) başarılı bir şekilde eklendi", preferredStyle: .alert)
            let tamamAction = UIAlertAction(title: "Tamam", style: .default) { action in
                self.navigationController?.popToRootViewController(animated: true)
            }
            alert.addAction(tamamAction)
            self.present(alert, animated: true)
        }
    }
}

extension AddNewViewController {
    
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
        
        buttonAddNew.layer.cornerRadius = 15
        buttonAddNew.clipsToBounds = true
        buttonAddNew.tintColor = UIColor.black
        
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
