//
//  RUIPlainTableViewCell.swift
//  Charts_Addons_Demo
//
//  Created by Maxim Komlev on 6/2/18.
//  Copyright © 2018 Maxim Komlev. All rights reserved.
//

import UIKit
import Foundation

class RUIPlainTableViewCell: UITableViewCell {
    
    // MARK: Fields
    
    let _accessory = RUIAccessoryView(color: sysBlue, direction: .right)
    
    // MARK: Initializer/Deinitializer
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        initializeUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
    }
    
    // MARK: View life cycle
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.frame = CGRect(x: self.frame.origin.x, y: self.frame.origin.y, width: self.frame.width, height: height())
        
        _accessory.frame = CGRect(x: self.contentView.frame.size.width - _accessory.frame.width, y: (self.contentView.frame.size.height - _accessory.frame.height) / 2, width: _accessory.frame.width, height: _accessory.frame.height)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.separatorInset = UIEdgeInsets.zero
        self.accessoryView = nil
        _accessory.isHidden = true
        _accessory.backgroundColor = self.backgroundColor
        isDisabled = false
    }
    
    // MARK: Properties
    
    override var accessoryType: UITableViewCellAccessoryType {
        didSet {
            if (self.accessoryType == .disclosureIndicator) {
                super.accessoryType = .none
                _accessory.isHidden = false
            } else {
                super.accessoryType = accessoryType
                _accessory.isHidden = true
            }
        }
    }
    
    override var backgroundColor: UIColor? {
        didSet {
            _accessory.backgroundColor = backgroundColor
        }
    }
    
    var isDisabled: Bool = false {
        didSet {
            _accessory.isDisabled = isDisabled
            textLabel?.textColor = isDisabled ? sysDisabledColor : UIColor.darkText
            detailTextLabel?.textColor = isDisabled ? sysDisabledColor : UIColor.darkText
            tintColor = isDisabled ? sysDisabledColor : sysBlue
        }
    }
    
    // MARK: Helpers
    
    func initializeUI() {
        self.separatorInset = UIEdgeInsets.zero
        
        _accessory.isHidden = true
        _accessory.backgroundColor = self.backgroundColor
        self.contentView.addSubview(_accessory)
    }
    
    func height() -> CGFloat {
        if (textLabel != nil &&
            textLabel!.numberOfLines == 0) {
            let sz = sizeConstrained(toWidth: self.contentView.frame.width, label: textLabel!)
            return sz.height < default_cell_height ? default_cell_height : sz.height
        }
        return default_cell_height
    }
    
}
