//
//  BorderButton.swift
//  pics
//
//  Created by Nkosikhona Bulana on 2019/04/29.
//  Copyright © 2019 Bulana. All rights reserved.
//

import UIKit

class BorderButton: UIButton {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.borderWidth = 3.0
        layer.borderColor = UIColor.white.cgColor
    }
    
}
