//
//  RUIAccessoryView.swift
//  Charts_Addons_Demo
//
//  Created by Maxim Komlev on 6/2/18.
//  Copyright © 2018 Maxim Komlev. All rights reserved.
//

import UIKit
import Foundation

class RUIAccessoryView: RUIView {
    
    // MARK: Fields
    
    let _image = UIImageView()
    var _color = sysLabelColor
    
    // MARK: Initializer/Deinitializer
    
    public convenience init() {
        self.init(frame: CGRect(x: 0, y: 0, width: 24, height: 24))
    }
    
    public convenience init(color: UIColor) {
        self.init()
        
        _color = color
        _image.tintColor = color
    }
    
    public convenience init(color: UIColor, direction: Direction = .none) {
        self.init(color: color)
        
        self.direction = direction
    }
    
    public convenience init(frame: CGRect, color: UIColor, direction: Direction = .none) {
        self.init(frame: frame)
        
        _color = color
        _image.tintColor = color
        self.direction = direction
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.clipsToBounds = true
        self.backgroundColor = UIColor.clear
        isUserInteractionEnabled = false
        
        _image.image = UIImage(named: "icon_arrow_right")?.withRenderingMode(.alwaysTemplate)
        addSubview(_image)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
    }
    
    // MARK: View life cycle
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        _image.frame = bounds
        rotate()
    }
    
    // MARK: Helpers
    
    func rotate() {
        if (direction != .none) {
            _image.transform = CGAffineTransform(rotationAngle: directionToRadians(direction))
        }
    }
    
    // MARK: Properties
    
    var color: UIColor = sysLabelColor
    var disableColor: UIColor  = sysDisabledColor
    
    var isDisabled: Bool = false {
        didSet {
            if (isDisabled) {
                _color = disableColor
            } else {
                _color = color
            }
        }
    }
    
    var direction : Direction = .none {
        didSet {
            rotate()
            setNeedsDisplay()
        }
    }
    
}
