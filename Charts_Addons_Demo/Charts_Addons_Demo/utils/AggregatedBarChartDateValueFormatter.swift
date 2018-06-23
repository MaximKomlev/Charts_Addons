//
//  AggregatedBarChartDateValueFormatter.swift
//  Charts_Addons_Demo
//
//  Created by Maxim Komlev on 6/21/18.
//  Copyright © 2018 Maxim Komlev. All rights reserved.
//

import UIKit
import Charts
import Foundation

class AggregatedBarChartDateValueFormatter: NSObject, IAxisValueFormatter {
    
    // MARK: Fields
    
    let _dateFormatter = DateFormatter()
    
    // MARK: Initializers/Deinitializer
    
    override init() {
        super.init()
        
        _dateFormatter.timeZone = TimeZone.current
    }
    
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        if let axis = axis, axis.entries.count > 0 {
            let entries = axis.entries
            let start = entries[0]
            let end = entries[entries.count - 1]
            let dif = end - start

            if (dif / (24 * 3600) >= Double(entries.count / 2)) {
                _dateFormatter.dateFormat = DateFormatter.dateFormat(fromTemplate: "EEE", options: 0, locale: Locale.current)
            } else {
                _dateFormatter.dateFormat = DateFormatter.dateFormat(fromTemplate: "ha", options: 0, locale: Locale.current)
            }
            return _dateFormatter.string(from: Date(timeIntervalSince1970: value))
        }
        return ""
    }

}
