//
//  RUITableFooterView.swift
//  BLERadariOS
//
//  Created by Maxim Komlev on 5/26/17.
//  Copyright © 2017 Maxim Komlev. All rights reserved.
//

import UIKit
import Foundation

class RUITableFooterView: RUITableHeaderView {
    
    // MARK: Initializer/Deinitializer
    
    deinit {
    }
        
    override func initializeUI() {
        super.initializeUI()
        self._label.font = UIFont.systemFont(ofSize: font_size_label14)
        self._label.textColor = sysLabelColor
    }
    
}
