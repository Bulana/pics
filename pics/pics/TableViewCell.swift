//
//  TableViewCell.swift
//  pics
//
//  Created by Bulana on 2019/04/22.
//  Copyright © 2019 Bulana. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    
    @IBOutlet var unsplashImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
