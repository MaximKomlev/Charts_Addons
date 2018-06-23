//
//  RUITableViewCell.swift
//  Charts_Addons_Demo
//
//  Created by Maxim Komlev on 6/2/18.
//  Copyright © 2018 Maxim Komlev. All rights reserved.
//

import UIKit
import Foundation

class RUITableViewCell: RUIPlainTableViewCell {
    
    // MARK: Fields
    
    let _borderWidth: CGFloat = 1.0
    
    let _shapeLayer = CAShapeLayer()
    let _borderLayer = CAShapeLayer()
    
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
        
        var bounds = CGRect(x: 0, y: 0, width: self.frame.size.width, height: height())
        var bezierPath: UIBezierPath!
        if (roundingCorners == .allCorners) {
            bezierPath = UIBezierPath(roundedRect: bounds.insetBy(dx: 0.0, dy: 2 * _borderWidth), cornerRadius: cellCornerRadius)
        } else if (roundingCorners.contains([.bottomLeft, .bottomRight])) {
            bounds.size.height -= _borderWidth
            bezierPath = UIBezierPath(roundedRect: bounds, byRoundingCorners: [.bottomLeft, .bottomRight], cornerRadii: CGSize(width: cellCornerRadius,height: cellCornerRadius))
        } else if (roundingCorners.contains([.topLeft, .topRight])) {
            bounds.origin.y += _borderWidth
            bezierPath = UIBezierPath(roundedRect: bounds, byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize(width: cellCornerRadius, height: cellCornerRadius))
        } else {
            bezierPath = UIBezierPath(rect: bounds)
        }
        
        _shapeLayer.path = bezierPath.cgPath
        self.layer.mask = _shapeLayer
        
        _borderLayer.path = bezierPath.cgPath
        _borderLayer.frame = bounds
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.separatorInset = UIEdgeInsets.zero
        self.accessoryView = nil
        _accessory.isHidden = true
        _accessory.backgroundColor = self.backgroundColor
        roundingCorners = .allCorners
        isDisabled = false
        borderColor = cellBorderColor
    }
    
    // MARK: Properties
    
    var borderColor: UIColor {
        get {
            if (_borderLayer.strokeColor != nil) {
                return UIColor(cgColor: _borderLayer.strokeColor!)
            }
            return UIColor.clear
        } set (v) {
            _borderLayer.strokeColor = v.cgColor
        }
    }
    
    override var backgroundColor: UIColor? {
        didSet {
            _accessory.backgroundColor = backgroundColor
        }
    }
    
    var roundingCorners: UIRectCorner = .allCorners
    
    // MARK: Helpers
    
    override func initializeUI() {
        super.initializeUI()
        self.separatorInset = UIEdgeInsets.zero
        
        // Add border
        _borderLayer.fillColor = UIColor.clear.cgColor
        _borderLayer.lineWidth = 1
        borderColor = cellBorderColor
        self.layer.addSublayer(_borderLayer)
        
        _accessory.isHidden = true
        _accessory.backgroundColor = self.backgroundColor
        self.contentView.addSubview(_accessory)
    }
    
    override func height() -> CGFloat {
        return default_cell_height
    }
    
}

class RUIDetailedTableViewCell: RUITableViewCell {
    
    // MARK: Initializer/Deinitializer
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .value1, reuseIdentifier: reuseIdentifier)
        
        initializeUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

