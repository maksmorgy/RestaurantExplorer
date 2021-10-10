//
//  StaticTableViewCell.swift
//  Restaurants Explorer
//
//  Created by Максим Моргун on 06.10.2021.
//

import UIKit

class StaticTableViewCell: UITableViewCell {

    @IBOutlet var cityTextField: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
