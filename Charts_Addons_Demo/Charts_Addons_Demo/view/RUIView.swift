//
//  RUIView.swift
//  Charts_Addons_Demo
//
//  Created by Maxim Komlev on 6/2/18.
//  Copyright © 2018 Maxim Komlev. All rights reserved.
//

import UIKit
import Foundation

var RUIStatusBarView: UIView? {
    return UIApplication.shared.value(forKey: "statusBar") as? UIView
}

class RUIView: UIView {
    
    public func contentSize() -> CGSize {
        fatalError("sizeForContent has not been implemented")
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
}

class RUICollectionReusableView: UICollectionReusableView {
    
    public func contentSize() -> CGSize {
        fatalError("sizeForContent has not been implemented")
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
}

class RUICollectionView: UICollectionView {
    
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
    
}
