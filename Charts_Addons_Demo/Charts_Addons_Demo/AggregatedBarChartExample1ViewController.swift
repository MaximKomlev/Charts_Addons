//
//  AggregatedBarChartExample1ViewController.swift
//  Charts_Addons_Demo
//
//  Created by Maxim Komlev on 6/14/18.
//  Copyright © 2018 Maxim Komlev. All rights reserved.
//

import UIKit
import Charts
import Foundation
import Charts_Addons

class AggregatedBarChartExample1ViewController: UIViewController, ChartViewDelegate, AggregatedBarChartViewMarkerPositionDelegate {
    
    // MARK: Fields

    let _drawer = CAShapeLayer()

    let _contentView = UIView()
    let _chartView = AggregatedBarChartView()
    let _selectedValueLabel = UILabel()
    
    let _normalColor = sysGreen
    let _abnormalColor = sysOrange
    let _veryAbnormalColor = sysRed
    
    var _transition: SwipeInteractiveTransition!
    
    var _chartData: Array<Dictionary<String, Double>>!
    
    let _normalLabel = "Normal"
    let _abnormalLabel = "Hot"
    let _veryAbnormalLabel = "Very hot"

    let _abnormalValue = Double(65)
    let _veryAbnormalValue = Double(90)

    // MARK: Initializer/Deinitializer
    
    convenience init() {
        self.init(style: .grouped)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        _transition = SwipeInteractiveTransition(viewController: self, swipeEdge: .left)
    }
    
    convenience init(style: UITableViewStyle) {
        self.init(nibName: nil, bundle: nil)
        
        title = "Temperature"
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        self.init()
    }
    
    deinit {
    }
    
    // MARK: Controller life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initializeUI()
        loadChartData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        initializeChartLimitLines()
        initializeChartData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        let safeInsets = view.safeAreaInsets

        let drawerHeight: CGFloat = 100
        let layerRect = CGRect(x: 2 + safeInsets.left, y: (view.frame.height - drawerHeight) / 2, width: 4, height: drawerHeight)
        let bezierPath = UIBezierPath(roundedRect: layerRect, cornerRadius: 4)
        _drawer.path = bezierPath.cgPath
        
        let screenRatio = min(UIScreen.main.bounds.height, UIScreen.main.bounds.width) / max(UIScreen.main.bounds.height, UIScreen.main.bounds.width)
        
        let width = view.frame.width - 30 - (safeInsets.left + safeInsets.right)
        let height = width * screenRatio
        
        let x = (view.frame.width - width) / 2
        let y = (view.frame.height - height) / 2
        
        _contentView.frame = CGRect(x: x, y: y, width: width, height: height)
        _chartView.frame = _contentView.bounds
        
        if (_selectedValueLabel.attributedText != nil) {
            let descSize = sizeOfString(lable: _selectedValueLabel)
            _selectedValueLabel.frame = CGRect(x: width - min(descSize.width + 15, width - 15), y: CGFloat(5), width: min(descSize.width, width - 30), height: descSize.height)
        }
        
        _contentView.setNeedsLayout()
    }
    
    // MARK: Properties
    
    var transitionController: SwipeInteractiveTransition {
        get {
            return _transition
        }
    }
    
    // MARK: Helpers
    
    func initializeUI() {
        _contentView.backgroundColor = UIColor.white
        _contentView.layer.masksToBounds = false
        _contentView.layer.shadowColor = UIColor.black.withAlphaComponent(0.8).cgColor
        _contentView.layer.shadowOpacity = 0.6
        _contentView.layer.shadowRadius = 1
        _contentView.layer.shadowOffset = CGSize(width: 2, height: 2)
        _contentView.layer.borderWidth = 1
        _contentView.layer.borderColor = UIColor(red: 224 / 255, green: 224 / 255, blue: 224 / 255, alpha: 1).cgColor
        _contentView.layer.cornerRadius = 2
        _contentView.layer.shadowRadius = 2
        view.addSubview(_contentView)
        
        _drawer.fillColor = sysBlue.cgColor
        _drawer.lineWidth = 1
        view.layer.addSublayer(_drawer)
        
        _chartView.delegate = self
        _chartView.chartDescription?.enabled = false
        _chartView.drawGridBackgroundEnabled = false
        _chartView.dragEnabled = true
        _chartView.setScaleEnabled(true)
        _chartView.scaleYEnabled = false
        _chartView.pinchZoomEnabled = true
        _chartView.rightAxis.enabled = false
        _chartView.drawBarShadowEnabled = false
        _chartView.drawValueAboveBarEnabled = true
        _chartView.groupMargin = 6
        _chartView.groupWidth = 14
        _chartView.barBorderRoundedCorner = 2
        _chartView.markerPositionDelegate = self
        _chartView.marker = BarMarkerView()

        let xAxis = _chartView.xAxis;
        xAxis.labelPosition = .bottom
        xAxis.labelPosition = .bottom
        xAxis.labelFont = UIFont.systemFont(ofSize: font_size_label12)
        xAxis.labelTextColor = sysLabelColor
        xAxis.drawGridLinesEnabled = false
        xAxis.drawAxisLineEnabled = true
        xAxis.centerAxisLabelsEnabled = false
        xAxis.drawLimitLinesBehindDataEnabled = true
        
        let leftAxis = _chartView.leftAxis
        leftAxis.labelFont = UIFont.systemFont(ofSize: font_size_label12)
        leftAxis.labelTextColor = sysLabelColor
        leftAxis.gridColor = sysLabelLightColor
        leftAxis.labelCount = 5
        leftAxis.labelPosition = .outsideChart
        leftAxis.drawLabelsEnabled = false
        leftAxis.drawAxisLineEnabled = false
        leftAxis.spaceTop = 0.15
        leftAxis.axisMinimum = 0.0
        leftAxis.axisMaximum = 100.0
        leftAxis.inverted = false
        
        let legend = _chartView.legend
        legend.font = UIFont.systemFont(ofSize: font_size_label12)
        legend.formSize = 12
        legend.form = .square
        legend.orientation = .horizontal
        legend.horizontalAlignment = .left
        legend.verticalAlignment = .bottom
        legend.textColor = sysLabelColor
        legend.xEntrySpace = 14
        legend.yEntrySpace = 5
        legend.setCustom(entries: [
            LegendEntry(label: _normalLabel, form: .square, formSize: 12, formLineWidth: 1, formLineDashPhase: 0, formLineDashLengths: nil, formColor: _normalColor),
            LegendEntry(label: _abnormalLabel, form: .square, formSize: 12, formLineWidth: 1, formLineDashPhase: 0, formLineDashLengths: nil, formColor: _abnormalColor),
            LegendEntry(label: _veryAbnormalLabel, form: .square, formSize: 12, formLineWidth: 1, formLineDashPhase: 0, formLineDashLengths: nil, formColor: _veryAbnormalColor)])

        _contentView.addSubview(_chartView)

        _selectedValueLabel.font = UIFont.systemFont(ofSize: font_size_label14)
        _selectedValueLabel.textColor = sysLabelColor
        _selectedValueLabel.textAlignment = .left
        _selectedValueLabel.numberOfLines = 1
        _selectedValueLabel.lineBreakMode = .byTruncatingTail
        _contentView.addSubview(_selectedValueLabel)
    }
    
    func initializeChartLimitLines() {
        let leftAxis = _chartView.leftAxis
        let llvh = ChartLimitLine(limit: _veryAbnormalValue, label: _veryAbnormalLabel)
        llvh.lineColor = _veryAbnormalColor
        llvh.drawLabelEnabled = false
        llvh.lineWidth = 0.5
        llvh.valueTextColor = sysLabelColor
        llvh.labelPosition = .leftTop
        llvh.lineDashLengths = [3, 1, 0]
        leftAxis.addLimitLine(llvh)
        
        let llh = ChartLimitLine(limit: _abnormalValue, label: _abnormalLabel)
        llh.lineColor = _abnormalColor
        llh.drawLabelEnabled = false;
        llh.lineWidth = 0.5;
        llh.valueTextColor = sysLabelColor
        llh.labelPosition = .leftTop
        llh.lineDashLengths = [3, 1, 0]
        leftAxis.addLimitLine(llh)
        
        let xAxis = _chartView.xAxis
        xAxis.valueFormatter = AggregatedBarChartDateValueFormatter()
    }

    func initializeChartData() {
        
        var colors = [UIColor]()
        var values = [BarChartDataEntry]()
        
        for value in _chartData {
            if let timestamp = value["timestamp"], let mean = value["mean"] {
                values.append(BarChartDataEntry(x: timestamp, y: mean + 30))
                if (mean + 30 >= _veryAbnormalValue) {
                    colors.append(_veryAbnormalColor)
                } else if (mean + 30 >= _abnormalValue) {
                    colors.append(_abnormalColor)
                } else {
                    colors.append(_normalColor)
                }
            }
        }

        var dataSet: BarChartDataSet? = nil
        if let data = _chartView.data, data.dataSetCount > 0 {
            dataSet = _chartView.data?.dataSets[0] as? BarChartDataSet
            dataSet?.barBorderColor = UIColor.clear
            dataSet?.values = values
            dataSet?.colors = colors
            dataSet?.highlightColor = UIColor.black.withAlphaComponent(0.5)
            data.notifyDataChanged()
            _chartView.notifyDataSetChanged()
        } else {
            dataSet = BarChartDataSet(values: values, label: nil)
            dataSet?.barBorderColor = UIColor.clear
            dataSet?.colors = colors
            dataSet?.highlightColor = UIColor.black.withAlphaComponent(0.5)
            var dataSets = [BarChartDataSet]()
            dataSets.append(dataSet!)
            let barData = BarChartData(dataSets: dataSets)
            barData.setDrawValues(false)
            _chartView.data = barData
        }
        _chartView.fitBars = true
    }

    func loadChartData() {
        _chartData = []
        if let path = Bundle.main.path(forResource: "data", ofType: nil),
            let data = NSData(contentsOfFile: path) as Data? {
            if let jsonObject = try? JSONSerialization.jsonObject(with: data, options: []) {
                if let dadaArray = jsonObject as? Array<Dictionary<String, Double>> {
                    _chartData = dadaArray
                }
            }
        }
    }
    
    // MARK: ChartViewDelegate
    
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        var topEntry = entry
        if let chartView = chartView as? AggregatedBarChartView {
            if let e = chartView.entryForHighlight(highlight) {
                topEntry = e
            }
        }

        let date = Date(timeIntervalSince1970: topEntry.x)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        _selectedValueLabel.text = "Highest temperature \(topEntry.y) at \(dateFormatter.string(from: date))"
        view.setNeedsLayout()
    }
    
    func chartValueNothingSelected(_ chartView: ChartViewBase) {
        _selectedValueLabel.text = ""
    }

    // MARK: AggregatedBarChartViewMarkerPositionDelegate
    
    func getMarkerPosition(highlight: Highlight) -> CGPoint {
        (_chartView.marker as! BarMarkerView).highlightedColor = _chartView.colorForHighlight(highlight)
        let point = _chartView.pointForHighlight(highlight)
        if point != CGPoint.zero {
            var x = (point.x + _chartView.groupWidth / 2) - 7.5
            let y = _chartView.viewPortHandler.contentRect.height + 7.5
            if ((_chartView.viewPortHandler.contentRect.origin.x - 7.5) > point.x - 7.5) {
                x = _chartView.viewPortHandler.contentRect.origin.x - 7.5
            }
            return CGPoint(x: x, y: y)
        }
        return CGPoint.zero
    }

}

