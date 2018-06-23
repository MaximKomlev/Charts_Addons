//
//  AggregatedBarChartDataProvider.swift
//  Charts_Addons
//
//  Created by Maxim Komlev on 6/1/18.
//  Copyright © 2018 Maxim Komlev. All rights reserved.
//

import Charts
import Foundation
import CoreGraphics

/// Specifies if the bars will be aggregated into one bar on scaling
/// use barWidth to specify limit of width for bar
@objc public protocol AggregatedBarChartDataProvider: BarChartDataProvider {
    
    // MARK: Properties
    
    var groupMargin: CGFloat { get }
    var groupWidth: CGFloat { get }
    
    var barBorderRoundedCorner: CGFloat { get }
}
