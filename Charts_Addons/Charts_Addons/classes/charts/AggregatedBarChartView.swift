//
//  AggregatedBarChartView.swift
//  Charts_Addons
//
//  Created by Maxim Komlev on 5/30/18.
//  Copyright © 2018 Maxim Komlev. All rights reserved.
//

import Charts
import Foundation
import CoreGraphics

#if !os(OSX)
    import UIKit
#endif

@objc public protocol AggregatedBarChartViewMarkerPositionDelegate: NSObjectProtocol {
    func getMarkerPosition(highlight: Highlight) -> CGPoint
}

// Chart that draws aggregate bars.
open class AggregatedBarChartView: BarChartView, AggregatedBarChartDataProvider {
    
    // MARK: Fields
    
    private let _groupMarginDef: CGFloat = 6
    private let _groupWidthDef: CGFloat = 10
    
    internal var _groupMargin: CGFloat = 0.0
    internal var _groupWidth: CGFloat = 0.0

    internal var _barBorderRoundedCorner: CGFloat = 0.0
    
    // MARK: Initializers/Deinitializer
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }

    
    internal func initialize() {
        
        _groupMargin = _groupMarginDef
        _groupWidth = _groupWidthDef
        
        renderer = AggregatedBarChartRenderer(dataProvider: self, animator: chartAnimator, viewPortHandler: viewPortHandler)
        highlighter = AggregatedBarHighlighter(chart: self)
    }
    
    @objc open weak var markerPositionDelegate: AggregatedBarChartViewMarkerPositionDelegate?
    
    public var groupMargin: CGFloat {
        get {
            return _groupMargin
        } set (v) {
            _groupMargin = v
        }
    }
    
    public var groupWidth: CGFloat {
        get {
            return _groupWidth
        } set (v) {
            _groupWidth = v
        }
    }
    
    public var barBorderRoundedCorner: CGFloat {
        get {
            return _barBorderRoundedCorner
        } set (v) {
            _barBorderRoundedCorner = v
        }
    }
    
    open override func getHighlightByTouchPoint(_ pt: CGPoint) -> Highlight? {
        if data === nil {
            print("Can't select by touch. No data set.")
            return nil
        }
        
        let val = (highlighter as! AggregatedBarHighlighter).getValsForTouch(x: pt.x, y: pt.y)
        guard let dsIndex = (self.renderer as! AggregatedBarChartRenderer).findDataEntryAt(x: pt.x, y: pt.y)
            else { return nil }
        
        // For isHighlightFullBarEnabled, remove stackIndex
        return Highlight(x: Double(val.x), y: Double(val.y), xPx: pt.x, yPx: pt.y,
                         dataIndex: dsIndex.dataEntryIndex, dataSetIndex: dsIndex.dataSetIndex, stackIndex: -1,
                         axis: YAxis.AxisDependency.left)
    }
    
    public func entryForHighlight(_ highlight: Highlight) -> ChartDataEntry? {
        let idx = (renderer as! AggregatedBarChartRenderer).findDataIndexFor(highlight: highlight)
        if let dataSet = barData?.getDataSetByIndex(highlight.dataSetIndex) {
            return dataSet.entryForIndex(idx)
        }
        return nil
    }
    
    public func pointForHighlight(_ highlight: Highlight) -> CGPoint {
        return (renderer as! AggregatedBarChartRenderer).barPointFor(highlight: highlight)
    }

    public func colorForHighlight(_ highlight: Highlight) -> UIColor {
        return (renderer as! AggregatedBarChartRenderer).barColorFor(highlight: highlight)
    }

    open override func getMarkerPosition(highlight: Highlight) -> CGPoint {
        if let markerPositionDelegate = self.markerPositionDelegate {
            return markerPositionDelegate.getMarkerPosition(highlight: highlight)
        }
        return super.getMarkerPosition(highlight: highlight)
    }

}
