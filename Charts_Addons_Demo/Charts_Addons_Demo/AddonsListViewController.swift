//
//  ViewController.swift
//  Charts_Addons_Demo
//
//  Created by Maxim Komlev on 6/1/18.
//  Copyright © 2018 Maxim Komlev. All rights reserved.
//

import UIKit

struct AddonsList {
    static let addonsDef: Dictionary<String, Dictionary<String, String>> = ["aggregatedbar":
                                                                                    ["title": "Aggregated Bar Chart",
                                                                                     "description": "The bar chart visually aggregates overlapped bars under single bar of extreme values (min/max or median) of them, e.g. for discrete data, like temperature, on timeline, it usefull to show the bars with constant size, and to aggregate them if they overlap each other."]]
}

class AddonsListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource,
                                RContentIndexerDelegate, UIViewControllerTransitioningDelegate {
    
    // MARK: Fields
    
    var _tableView: UITableView!
    let _tableIndexer = RContentIndexer()
    
    // MARK: Initializer/Deinitializer
    
    convenience init() {
        self.init(style: .grouped)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    convenience init(style: UITableViewStyle) {
        self.init(nibName: nil, bundle: nil)
        
        title = "Addons List"
        _tableView = UITableView(frame: CGRect.zero, style: style)
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
        updateIndex()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        _tableView.reloadData()
    }
        
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        _tableView.contentInset = UIEdgeInsets.zero
        _tableView.layoutMargins = UIEdgeInsets.zero
        
        _tableView.frame = CGRect(x: 15, y: 0, width: view.frame.width - 30, height: view.frame.height)
        
        _tableView.setNeedsLayout()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return _tableIndexer.sectionsCount
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionIndex: SectionIndex? = _tableIndexer.sectionAt(index: section)
        if (sectionIndex != nil) {
            return sectionIndex!.itemsCount
        }
        return 0
    }
    
    // MARK: Header
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return headerHeight(section: section)
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return headerHeight(section: section)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
    
    func headerText(section: Int) -> String? {
        return nil
    }
    
    func headerHeight(section: Int) -> CGFloat {
        return 0
    }
    
    // MARK: Footer
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return footerHeight(section: section)
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForFooterInSection section: Int) -> CGFloat {
        return footerHeight(section: section)
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if let title = footerText(section: section) {
            let view = _tableView.dequeueReusableHeaderFooterView(withIdentifier: RUITableFooterViewId) as! RUITableFooterView
            view.text = title
            view.frameWidth = _tableView.frame.width
            view.layoutSubviews()
            return view
        }
        return nil
    }
    
    func footerText(section: Int) -> String? {
        if let sectionIndex = _tableIndexer.sectionAt(index: section) {
            if let addonDef = AddonsList.addonsDef[sectionIndex.id] {
                return addonDef["description"]
            }
        }
        return nil
    }
    
    func footerHeight(section: Int) -> CGFloat {
        if let title = footerText(section: section) {
            let view = _tableView.dequeueReusableHeaderFooterView(withIdentifier: RUITableFooterViewId) as! RUITableFooterView
            view.text = title
            view.frameWidth = _tableView.frame.width
            return view.contentSize().height
        }
        return 0
    }
    
    // MARK: Cells
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let sectionIndex = _tableIndexer.sectionAt(index: indexPath.section) {
            if let addonDef = AddonsList.addonsDef[sectionIndex.id] {
                if sectionIndex.itemAt(index: indexPath.row) != nil {
                    let cell: RUITableViewCell = tableView.dequeueReusableCell(withIdentifier: UITableViewCellId)! as! RUITableViewCell
                    cell.textLabel?.text = addonDef["title"]
                    cell.textLabel?.font = UIFont.systemFont(ofSize: font_size_cell_label16)
                    cell.detailTextLabel?.text = ""
                    cell.detailTextLabel?.font = UIFont.systemFont(ofSize: font_size_cell_label16)
                    cell.accessoryType = .disclosureIndicator
                    cell.selectionStyle = .none
                    return cell
                }
            }
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: UITableViewEmptyCellId, for: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        let cell = self.tableView(tableView, cellForRowAt: indexPath) as! RUITableViewCell
        return cell.height()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let cell = self.tableView(tableView, cellForRowAt: indexPath) as! RUITableViewCell
        return cell.height()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let sectionIndex = _tableIndexer.sectionAt(index: indexPath.section) {
            if sectionIndex.id == "aggregatedbar" {
                DispatchQueue.main.async {
                    let vc = AggregatedBarChartExample1ViewController()
                    vc.view.backgroundColor = self.view.backgroundColor
                    vc.transitioningDelegate = self
                    self.present(vc, animated: true, completion: nil)
                }
            }
        }
    }
    
    // MARK: Helpers
    
    func updateIndex() {
        _tableIndexer.delegate = self
        _tableIndexer.clear()
        
        let agrBarSectionIndex = SectionIndex(id: "aggregatedbar")
        agrBarSectionIndex.addItem(item: ItemIndex(id: "aggregatedbar"))
        _tableIndexer.addSection(agrBarSectionIndex)
        
        _tableView.delegate = self
        _tableView.dataSource = self
        _tableView.reloadData()
    }
    
    func initializeUI() {
        _tableView.register(RUITableHeaderView.self, forHeaderFooterViewReuseIdentifier: RUITableHeaderViewId)
        _tableView.register(RUITableFooterView.self, forHeaderFooterViewReuseIdentifier: RUITableFooterViewId)
        _tableView.register(RUITableViewCell.self, forCellReuseIdentifier: UITableViewCellId)
        _tableView.register(UITableViewCell.self, forCellReuseIdentifier: UITableViewEmptyCellId)
        
        self.view.addSubview(_tableView)
        
        view.backgroundColor = _tableView.backgroundColor

        if #available(iOS 9, *) {
            _tableView.cellLayoutMarginsFollowReadableWidth = false
        }
    }
    
    // MARK: RContentIndexerDelegate
    
    func sectionAdded(source: RContentIndexer, sectionIndex: Int) {
    }
    
    func sectionRemoved(source: RContentIndexer, sectionIndex: Int) {
    }
    
    func itemAdded(source: RContentIndexer, sectionIndex: Int, itemIndex: Int) {
    }
    
    func itemRemoved(source: RContentIndexer, sectionIndex: Int, itemIndex: Int) {
    }

    // MARK: UIViewControllerTransitioningDelegate
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return AnimatedTransitioning(direction: .right)
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if let vc = dismissed as? AggregatedBarChartExample1ViewController {
            return AnimatedTransitioning(direction: .left, transition: vc.transitionController)
        }
        return AnimatedTransitioning(direction: .left)
    }
        
    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        guard let animator = animator as? AnimatedTransitioning,
            let transitionController = animator.transitionController,
            transitionController.interactionInProgress
            else {
                return nil
        }
        return transitionController
    }

}

