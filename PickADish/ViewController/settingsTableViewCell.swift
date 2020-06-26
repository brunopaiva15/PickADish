//
//  settingsTableViewCell.swift
//  PickADish
//
//  Created by Bruno Vergasta Paiva on 14.06.20.
//  Copyright © 2020 Bruno Paiva. All rights reserved.
//

import UIKit

class settingsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var settingsSwitch: UISwitch!
    
    struct MyData {
        var firstRowLabel:String
        var secondRowSwitch:UISwitch
    }
    
    var tableData: [MyData] = []

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }

}
