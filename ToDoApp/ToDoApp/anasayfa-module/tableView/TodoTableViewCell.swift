//
//  TodoTableViewCell.swift
//  ToDoApp
//
//  Created by Sedat Samet Oypan on 14.10.2022.
//

import UIKit

protocol TableViewCellProtocol {
    func buttonTiklandi(indexPath:IndexPath)
}

class TodoTableViewCell: UITableViewCell {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var toDoTextLabel: UILabel!
    @IBOutlet weak var doneButton: UIButton!
    
    var tableViewCellProtocol:TableViewCellProtocol?
    var indexPath:IndexPath?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func doneButton(_ sender: Any) {
        tableViewCellProtocol?.buttonTiklandi(indexPath: indexPath!)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    override var frame: CGRect {
        get {
            return super.frame
        }
        set (newFrame) {
            var frame =  newFrame
            frame.origin.y += 4
            frame.size.height -= 2 * 5
            super.frame = frame
        }
    }
    
}
