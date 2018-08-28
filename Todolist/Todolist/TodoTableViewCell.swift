//
//  TodoTableViewCell.swift
//  Todolist
//
//  Created by Frank on 2018/8/28.
//  Copyright © 2018 Frank. All rights reserved.
//

import UIKit

class TodoTableViewCell: UITableViewCell {

    //@IBOutlet weak var textLabel: UILabel!
    
    @IBOutlet weak var todoLabel: UILabel!
    @IBOutlet weak var editButton: UIButton!
    
    @IBAction func editButtonClick(_ sender: UIButton) {
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
