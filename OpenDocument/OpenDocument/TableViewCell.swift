//
//  TableViewCell.swift
//  OpenDocument
//
//  Created by Jérémie Beaudoin on 5/28/19.
//  Copyright © 2019 Jérémie Beaudoin. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
