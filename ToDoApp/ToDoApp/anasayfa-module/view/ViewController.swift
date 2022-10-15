//
//  ViewController.swift
//  ToDoApp
//
//  Created by Sedat Samet Oypan on 12.10.2022.
//

import UIKit

class ViewController: UIViewController{

    @IBOutlet weak var toDoListTitleLabel: UILabel!
    @IBOutlet weak var toDoListCollectionTitle: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var buttonNewAdd: UIButton!
    @IBOutlet weak var todoSearchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var yapilacakListesi = [Yapilacaklar]()
    
    var anasayfaPresenterNesnesi : ViewToPresenterAnasayfaProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        // MARK: - Calling design functions
        viewDesignSetup()
        
        veritabaniKopyala() // Veritabanı Kopyalama
        
        AnasayfaRouter.createModule(ref: self)
        
        let dokunmaAlgilama = UITapGestureRecognizer(target: self, action: #selector(dokunmaAlgilamaMetod))
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(dokunmaAlgilama)
        
    }
    @objc func dokunmaAlgilamaMetod(){
        view.endEditing(true)
    }
    override func viewWillAppear(_ animated: Bool) {
        anasayfaPresenterNesnesi?.yapilacaklarYukle()
    }
    @IBAction func buttonAddNewTodo(_ sender: Any) {
        performSegue(withIdentifier: "toDoAddNewVC", sender: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetayViewController" {
            if let todo = sender as? Yapilacaklar {
                let gidilecekVC = segue.destination as! DetayViewController
                gidilecekVC.todo = todo
            }
        }
    }
   
}
// MARK: Changing todo_done attribute of Todo Object with DoneButton (Protocol)
extension ViewController : TableViewCellProtocol {
    func buttonTiklandi(indexPath: IndexPath) {
        let todo = yapilacakListesi[indexPath.row]
        anasayfaPresenterNesnesi?.guncelle(todo_id: todo.todo_id!, todo_done: todo.todo_done)
    }
}
// MARK: Veri tabanı kopyalama
extension ViewController {
    func veritabaniKopyala(){
        let bundleYolu = Bundle.main.path(forResource: "toDo", ofType: ".sqlite")
        let hedefYol = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let kopyalanacakYer = URL(fileURLWithPath: hedefYol).appendingPathComponent("toDo.sqlite")
        let fileManager = FileManager.default
        
        if fileManager.fileExists(atPath: kopyalanacakYer.path) {
            print("Veritabanı daha önce kopyalanmış")
        }else{
            do{
                try fileManager.copyItem(atPath: bundleYolu!, toPath: kopyalanacakYer.path)
            }catch{
                print(error.localizedDescription)
            }
        }
    }
}

// MARK: Extensions
// MARK: Liste Reload
extension ViewController : PresenterToViewAnasayfaProtocol {
    func vieweVeriGonder(yapilacakListesi: [Yapilacaklar]) {
        self.yapilacakListesi = yapilacakListesi
        self.tableView.reloadData()
    }
}
// MARK: SearchBar
extension ViewController : UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        anasayfaPresenterNesnesi?.ara(aramaKelimesi: searchText)
    }
}
// MARK: - ViewController Views Design
extension ViewController {
    func viewDesignSetup(){
        imageView.layer.cornerRadius = 20
        
        buttonNewAdd.layer.cornerRadius = 0.5 * buttonNewAdd.bounds.size.width
        buttonNewAdd.clipsToBounds = true
        buttonNewAdd.tintColor = UIColor.orange
        
        toDoListTitleLabel.font = UIFont(name: "Roboto-Italic", size: 40)
        
        toDoListCollectionTitle.font = UIFont(name: "Roboto-Italic", size: 25)
        toDoListCollectionTitle.layer.cornerRadius = 10
        toDoListCollectionTitle.clipsToBounds = true
        
        tableView.backgroundColor = UIColor.systemYellow
    }
}
// MARK: - TableView Listing Items
extension ViewController : UITableViewDelegate, UITableViewDataSource {
    // Kaç adet row listeleneceğini belirleme
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return yapilacakListesi.count
    }
    // Hücre içeriğini belirleme
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let yapilacak = yapilacakListesi[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "yapilacakCell") as! TodoTableViewCell
        cell.dateLabel.text = yapilacak.todo_tarih
        cell.toDoTextLabel.text = yapilacak.todo_text
        
        // MARK: - TodoTableViewCell Design
        cell.toDoTextLabel.font = UIFont(name: "Roboto-Italic", size: 20)
        cell.dateLabel.font = UIFont(name: "Roboto-Italic", size: 20)
        cell.doneButton.layer.cornerRadius = 0.5 * cell.doneButton.bounds.size.width
        cell.doneButton.clipsToBounds = true
        if yapilacak.todo_done == "0" {
            cell.doneButton.tintColor = UIColor.systemRed
        }else{
            cell.doneButton.tintColor = UIColor.systemGreen
        }
        cell.indexPath = indexPath
        cell.tableViewCellProtocol = self
        
        cell.layer.cornerRadius = 20
        cell.layer.masksToBounds = true
        
        return cell
    }
    // Seçilen row ile segue gerçekleştirme
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let todo = yapilacakListesi[indexPath.row]
        performSegue(withIdentifier: "toDetayViewController", sender: todo)
        tableView.deselectRow(at: indexPath, animated: true)// Seçilen row'un background değiştirme
    }
    // Row silme işlemi
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let silAction = UIContextualAction(style: .destructive, title: "Sil"){ (contextualAction,view,bool) in
            let todo = self.yapilacakListesi[indexPath.row]
            
            let alert = UIAlertController(title: "Silme İşlemi", message: "\(todo.todo_text!) silinsin mi ?", preferredStyle: .alert)
            let iptalAction = UIAlertAction(title: "İptal", style: .cancel)
            alert.addAction(iptalAction)
            let evetAction = UIAlertAction(title: "Evet", style: .destructive) { action in
                self.anasayfaPresenterNesnesi?.sil(todo_id: todo.todo_id!)
            }
            alert.addAction(evetAction)
            self.present(alert, animated: true)
        }
        return UISwipeActionsConfiguration(actions: [silAction])
    }
}



