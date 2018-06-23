//
//  ContentIndexer.swift
//  Charts_Addons_Demo
//
//  Created by Maxim Komlev on 6/1/18.
//  Copyright © 2018 Maxim Komlev. All rights reserved.
//

import UIKit
import Foundation

@objc protocol RContentIndexerDelegate: NSObjectProtocol {
    @objc optional func sectionAdded(source: RContentIndexer, sectionIndex: Int)
    @objc optional func sectionRemoved(source: RContentIndexer, sectionIndex: Int)
    @objc optional func sectionUpdated(source: RContentIndexer, sectionIndex: Int)
    @objc optional func sectionsCleared(source: RContentIndexer, sectionIndex: [Int])
    @objc optional func itemAdded(source: RContentIndexer, sectionIndex: Int, itemIndex: Int)
    @objc optional func itemsAdded(source: RContentIndexer, sectionIndex: Int, itemsIndex: [Int])
    @objc optional func itemRemoved(source: RContentIndexer, sectionIndex: Int, itemIndex: Int)
    @objc optional func itemsRemoved(source: RContentIndexer, sectionIndex: Int, itemsIndex: [Int])
    @objc optional func itemUpdated(source: RContentIndexer, sectionIndex: Int, itemIndex: Int)
    @objc optional func itemsUpdated(source: RContentIndexer, sectionIndex: Int, itemsIndex: [Int])
    @objc optional func itemsCleared(source: RContentIndexer, sectionIndex: Int, itemsIndex: [Int])
}

class ItemIndex: NSObject {
    
    fileprivate var _id: String = ""
    
    override init() {
        super.init()
    }
    
    init(id: String) {
        super.init()
        
        _id = id
    }
    
    var id: String {
        get {
            return _id
        }
        set(v) {
            _id = v
        }
    }
}

class SectionIndex: ItemIndex {
    
    fileprivate var _items: Array<ItemIndex> = Array()
    
    var itemsCount: Int {
        get {
            return _items.count
        }
    }
    
    func addItem(item: ItemIndex) {
        _items.append(item)
    }
    
    func addItems(items: [ItemIndex]) {
        _items.append(contentsOf: items)
    }
    
    func insertItemAt(itemIndex: Int, item: ItemIndex) {
        _items.insert(item, at: itemIndex)
    }
    
    func removeItemAt(index: Int) {
        if (index < _items.count && index > -1) {
            _items.remove(at: index)
        }
    }
    
    func itemAt(index: Int) -> ItemIndex? {
        if (index < _items.count && index > -1) {
            return _items[index]
        }
        return nil
    }
    
    func findItemIndexBy(id: String) -> Int {
        for i in 0..<_items.count {
            if (_items[i].id == id) {
                return i
            }
        }
        return -1
    }
    
    func clear() {
        _items.removeAll()
    }
}

class RContentIndexer: NSObject {
    weak var delegate: RContentIndexerDelegate? = nil
    
    private var _sections: Array<SectionIndex> = Array()
    
    override init() {
        super.init()
    }
    
    public convenience init(delegate: RContentIndexerDelegate) {
        self.init()
        
        self.delegate = delegate
    }
    
    deinit {
        self.delegate = nil
    }
    
    func updateSectionAt(_ sectionIndex: Int) {
        
        if (delegate != nil && ((delegate?.sectionUpdated) != nil)) {
            delegate?.sectionUpdated!(source: self, sectionIndex: sectionIndex)
        }
    }
    
    func addSection(_ section: SectionIndex) {
        
        _sections.append(section)
        
        if (delegate != nil && ((delegate?.sectionAdded) != nil)) {
            delegate?.sectionAdded!(source: self, sectionIndex: _sections.index(of: section)!)
        }
    }
    
    func insertSectionAt(_ sectionIndex: Int, _ section: SectionIndex) {
        
        var sIdx: Int = sectionIndex
        if (_sections.count <= sectionIndex || sectionIndex < 0) {
            sIdx = _sections.count
        }
        
        _sections.insert(section, at: sIdx)
        
        if (delegate != nil && ((delegate?.sectionAdded) != nil)) {
            delegate?.sectionAdded!(source: self, sectionIndex: _sections.index(of: section)!)
        }
    }
    
    func updatedItemAt(sectionIndex: Int, itemIndex: Int) {
        if (sectionIndex < _sections.count && sectionIndex >= 0) {
            
            if (delegate != nil && ((delegate?.itemUpdated) != nil)) {
                delegate?.itemUpdated!(source: self, sectionIndex: sectionIndex, itemIndex: itemIndex)
            }
        }
    }
    
    func addItem(sectionIndex: Int, item: ItemIndex) {
        if (sectionIndex < _sections.count && sectionIndex >= 0) {
            
            _sections[sectionIndex].addItem(item: item)
            
            if (delegate != nil && ((delegate?.itemAdded) != nil)) {
                delegate?.itemAdded!(source: self, sectionIndex: sectionIndex, itemIndex: _sections[sectionIndex]._items.index(of: item)!)
            }
        }
    }
    
    func addItems(sectionIndex: Int, items: [ItemIndex]) {
        if ((sectionIndex < _sections.count && sectionIndex >= 0) && items.count > 0) {
            
            _sections[sectionIndex].addItems(items: items)
            
            if (delegate != nil && delegate!.itemsAdded != nil) {
                var indexes: [Int] = []
                let startIdx = _sections[sectionIndex]._items.index(of: items[0])
                for i in startIdx!..<(startIdx! + items.count) {
                    indexes.append(i)
                }
                delegate!.itemsAdded!(source: self, sectionIndex: sectionIndex, itemsIndex: indexes)
            }
        }
    }
    
    func insertItemAt(sectionIndex: Int, itemIndex: Int, item: ItemIndex) {
        if (sectionIndex < _sections.count && sectionIndex >= 0) {
            
            var rIdx: Int = itemIndex
            if (_sections[sectionIndex].itemsCount <= itemIndex || itemIndex < 0) {
                rIdx = _sections[sectionIndex].itemsCount
            }
            
            _sections[sectionIndex].insertItemAt(itemIndex: rIdx, item: item)
            
            if (delegate != nil && ((delegate?.itemAdded) != nil)) {
                delegate?.itemAdded!(source: self, sectionIndex: sectionIndex, itemIndex: _sections[sectionIndex]._items.index(of: item)!)
            }
        }
    }
    
    // TODO: insertItems, removeItems, updatedItems
    
    func removeSectionAt(index: Int) {
        if (index > -1 && index < _sections.count) {
            _sections.remove(at: index)
            
            if (delegate != nil && ((delegate?.sectionRemoved) != nil)) {
                delegate?.sectionRemoved!(source: self, sectionIndex: index)
            }
        }
    }
    
    func removeItemAt(sectionIndex: Int, itemIndex: Int) {
        if (sectionIndex < _sections.count && sectionIndex > -1) {
            
            _sections[sectionIndex].removeItemAt(index: itemIndex)
            
            if (delegate != nil && ((delegate?.itemRemoved) != nil)) {
                delegate?.itemRemoved!(source: self, sectionIndex: sectionIndex, itemIndex: itemIndex)
            }
        }
    }
    
    func clearItemsAt(sectionIndex: Int) {
        if (sectionIndex < _sections.count && sectionIndex > -1) {
            
            var indexes: [Int] = []
            for i in 0..<_sections[sectionIndex].itemsCount {
                indexes.append(i)
            }
            
            _sections[sectionIndex].clear()
            
            if (delegate != nil && ((delegate?.itemsCleared) != nil)) {
                delegate?.itemsCleared!(source: self, sectionIndex: sectionIndex, itemsIndex: indexes)
            }
        }
    }
    
    func sectionAt(index: Int) -> SectionIndex? {
        if (index < _sections.count && index > -1) {
            return _sections[index]
        }
        return nil
    }
    
    func findSectionIndexBy(id: String) -> Int {
        var idx: Int = 0
        var sIndex = -1
        for sectionIndex in _sections {
            if (sectionIndex.id == id) {
                sIndex = idx
            }
            idx += 1
        }
        return sIndex
    }
    
    func clear() {
        
        var indexes: [Int] = []
        for i in 0..<_sections.count {
            indexes.append(i)
        }
        
        _sections.removeAll()
        
        if (delegate != nil && ((delegate?.sectionsCleared) != nil)) {
            delegate?.sectionsCleared!(source: self, sectionIndex: indexes)
        }
    }
    
    var sectionsCount: Int {
        get {
            return _sections.count
        }
    }
    
    var itemsInSections: Int {
        get {
            var items = 0
            for i in 0..<_sections.count {
                items += _sections[i].itemsCount
            }
            return items
        }
    }
}
