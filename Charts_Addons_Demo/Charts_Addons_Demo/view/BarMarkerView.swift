//
//  BarMarkerView.swift
//  Charts_Addons_Demo
//
//  Created by Maxim Komlev on 6/22/18.
//  Copyright © 2018 Maxim Komlev. All rights reserved.
//

import UIKit
import Charts
import Foundation

open class BarMarkerView: MarkerView {
    
    var highlightedColor = UIColor.clear
    
    override open func draw(context: CGContext, point: CGPoint) {
        super.draw(context: context, point: point)
        
        let x = point.x
        
        context.saveGState()
        
        context.setAlpha(1.0)
        
        context.beginPath()
        context.setShadow(offset: CGSize(width: 0, height: 1), blur: 4, color: sysGrey.cgColor)
        context.setFillColor(UIColor.white.cgColor)
        context.fillEllipse(in: CGRect(x: x, y: point.y - 7.5, width: 15, height: 15))
        context.setShadow(offset: CGSize.zero, blur: 2, color: nil)
        context.setFillColor(highlightedColor.cgColor)
        context.fillEllipse(in: CGRect(x: x + 3.5, y: point.y - 4, width: 8, height: 8))
        context.strokePath()
        
        context.restoreGState()
    }
    
    open override func refreshContent(entry: ChartDataEntry, highlight: Highlight) {
        layoutIfNeeded()
    }
    
}
