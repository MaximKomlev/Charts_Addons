//
//  RUITableHeaderView.swift
//  BLERadariOS
//
//  Created by Maxim Komlev on 5/26/17.
//  Copyright © 2017 Maxim Komlev. All rights reserved.
//

import UIKit
import Foundation

class RUITableHeaderView: UITableViewHeaderFooterView {
    
    // MARK: Fields
    
    let _imageSize: CGFloat = 64
    let _image = UIImageView()
    let _label = UILabel()
        
    // MARK: Initializer/Deinitializer
 
    public required override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)

        self.clipsToBounds = true
        self.autoresizingMask = [.flexibleWidth, .flexibleHeight]

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

        var xLabel = leftRightMargin
        var labelWidth = self.contentView.frame.width - 2 * leftRightMargin
        if (!_image.isHidden && _image.image != nil) {
            labelWidth -= (leftRightMargin / 2 + _imageSize)
            xLabel = 3 / 2 * leftRightMargin + _imageSize
        }
        var labelHeight: CGFloat = 0
        if (attributedText != nil) {
            let labelSize = sizeConstrained(toWidth: labelWidth, label: self._label)
            labelHeight = labelSize.height
        }
        
        var yLabel: CGFloat = topBottomMargin
        if (!_image.isHidden && _image.image != nil && labelHeight < _imageSize) {
            yLabel += (_imageSize - labelHeight) / 2
        }
        self._label.frame = CGRect(x: xLabel, y: yLabel, width: labelWidth, height: labelHeight)
        
        if (!_image.isHidden && _image.image != nil) {
            let xImage = leftRightMargin
            var yImage = topBottomMargin
            if (labelHeight > _imageSize) {
                yImage += (labelHeight - _imageSize) / 2
            }
            self._image.frame = CGRect(x: xImage, y: yImage, width: _imageSize, height: _imageSize)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self._label.frame = CGRect.zero
        self._label.text = nil
        self._label.attributedText = nil
        self._image.frame = CGRect.zero
    }
    
    // MARK: Public methods
    
    public func contentSize() -> CGSize {
        if (attributedText != nil) {
            var labelWidth = self.contentView.frame.width - 2 * leftRightMargin
            if (!_image.isHidden && _image.image != nil) {
                labelWidth -= (leftRightMargin / 2 + _imageSize)
            }
            var labelHeight: CGFloat = 0
            let labelSize = sizeConstrained(toWidth: labelWidth, label: self._label)
            labelHeight = labelSize.height

            let yLabel = topBottomMargin
            let xLabel = leftRightMargin
        
            self._label.frame = CGRect(x: xLabel, y: yLabel, width: labelWidth, height: labelHeight)
        
            var height: CGFloat = labelHeight + 2 * topBottomMargin
            if (!_image.isHidden && _image.image != nil) {
                height = max(labelHeight, _imageSize) + 2 * topBottomMargin
            }
            return CGSize(width: self.frame.width, height: height)
        }
        return CGSize(width: self.frame.width, height: 0)
    }
    
    public var frameOrigin: CGPoint {
        get {
            return self.frame.origin;
        } set (v) {
            self.frame = CGRect(x: v.x, y: v.y, width: self.frame.size.width, height: self.frame.size.height);
        }
    }
    
    public var frameSize: CGSize {
        get {
            return self.frame.size;
        } set (v) {
            self.frame = CGRect(x: self.frame.origin.x, y: self.frame.origin.y, width: v.width, height: v.height);
        }
    }
    
    public var frameX: CGFloat {
        get {
            return self.frame.origin.x;
        } set (v) {
            self.frame = CGRect(x: v, y: self.frame.origin.y, width: self.frame.size.width, height: self.frame.size.height);
        }
    }
    
    public var frameY: CGFloat {
        get {
            return self.frame.origin.y;
        } set (v) {
            self.frame = CGRect(x: self.frame.origin.x, y: v, width: self.frame.size.width, height: self.frame.size.height);
        }
    }
    
    public var frameRight: CGFloat {
        get {
            return self.frame.origin.x + self.frame.size.width;
        } set (v) {
            self.frame = CGRect(x: v - self.frame.size.width, y: self.frame.origin.y, width: self.frame.size.width, height: self.frame.size.height);
        }
    }
    
    public var frameBottom: CGFloat {
        get {
            return self.frame.origin.y + self.frame.size.height;
        } set (v) {
            self.frame = CGRect(x: self.frame.origin.x, y: v - self.frame.size.height, width: self.frame.size.width, height: self.frame.size.height);
        }
    }
    
    public var frameWidth: CGFloat {
        get {
            return self.frame.size.width;
        } set (v) {
            self.frame = CGRect(x: self.frame.origin.x, y: self.frame.origin.y, width: v, height: self.frame.size.height);
        }
    }
    
    public var frameHeight: CGFloat {
        get {
            return self.frame.size.height;
        } set (v) {
            self.frame = CGRect(x: self.frame.origin.x, y: self.frame.origin.y,
                                width: self.frame.size.width, height: v);
        }
    }

    // MARK: Properies
    
    var text: String? {
        get {
            return self._label.text
        }
        set (v) {
            if (self._label.text != v) {
                self._label.text = v
                self.setNeedsLayout()
            }
        }
    }
    
    var attributedText: NSAttributedString? {
        get {
            return self._label.attributedText
        }
        set (v) {
            self._label.attributedText = v
            self.setNeedsLayout()
        }
    }
    
    var isImageHidden: Bool {
        get {
            return _image.isHidden
        } set (v) {
            _image.isHidden = v
            self.setNeedsLayout()
        }
    }
    
    var image: UIImage? = nil {
        didSet {
            self._image.image = image
            self.setNeedsLayout()
        }
    }

    var imageTitnColor: UIColor = UIColor.black {
        didSet {
            self._image.tintColor = imageTitnColor
            self.setNeedsLayout()
        }
    }

    // MARK: Helpers
    
    func initializeUI() {
        _label.textColor = sysDarkBlue//sysLabelColor
        _label.font = UIFont.systemFont(ofSize: font_size_label16)
        _label.lineBreakMode = .byWordWrapping
        _label.numberOfLines = 0
        _label.textAlignment = .left
        self.contentView.addSubview(_label)

        _image.frame = CGRect.zero
        _image.contentMode = .scaleAspectFit
        _image.clipsToBounds = true
        self.contentView.addSubview(_image)
    }
}
