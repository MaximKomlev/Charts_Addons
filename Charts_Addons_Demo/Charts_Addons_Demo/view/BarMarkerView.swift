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
        
        let rect = CGRect(x: point.x, y: point.y - 16 / 2, width: 16, height: 16)

        context.saveGState()
        context.beginPath()

        context.setShadow(offset: CGSize(width: 0, height: 1), blur: 3, color: sysGrey.cgColor)
        context.setFillColor(UIColor.white.cgColor)
        context.move(to: CGPoint(x: rect.origin.x + rect.width / 2, y: rect.origin.y))
        context.addLine(to: CGPoint(x: rect.origin.x, y: rect.origin.y + rect.height))
        context.addLine(to: CGPoint(x: rect.origin.x + rect.width, y: rect.origin.y + rect.height))
        context.closePath()
        context.fillPath()

        context.setShadow(offset: CGSize.zero, blur: 0, color: UIColor.clear.cgColor)
        context.setFillColor(highlightedColor.cgColor)
        context.move(to: CGPoint(x: rect.origin.x + rect.width / 2, y: rect.origin.y + rect.height * 3 / 8))
        context.addLine(to: CGPoint(x: rect.origin.x + 5, y: rect.origin.y + rect.height * 3 / 4))
        context.addLine(to: CGPoint(x: rect.origin.x + 11, y: rect.origin.y + rect.height * 3 / 4))
        context.closePath()
        context.fillPath()

        context.restoreGState()
    }
    
    open override func refreshContent(entry: ChartDataEntry, highlight: Highlight) {
        layoutIfNeeded()
    }
    
}
