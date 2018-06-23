//
//  Definitions.swift
//  Charts_Addons_Demo
//
//  Created by Maxim Komlev on 6/2/18.
//  Copyright © 2018 Maxim Komlev. All rights reserved.
//

import UIKit
import Foundation

public enum GoogleAuthStatus: Int {
    case loggedOut = 0
    case loggedIn = 1
    case error = 2
}

public enum TitledImageLabelLayout {
    case bottom
    case top
}

public enum Direction {
    case up, down, left, right, none
}

func degreesToRadians(_ degrees: CGFloat) -> CGFloat {
    return degrees  * CGFloat(Double.pi) / 180
}

func directionToRadians(_ direction: Direction) -> CGFloat {
    switch direction {
    case .up:
        return degreesToRadians(-90)
    case .down:
        return degreesToRadians(90)
    case .left:
        return degreesToRadians(180)
    case .right:
        return degreesToRadians(0)
    case .none:
        return 0
    }
}

enum GuardianType: Int {
    case sentry = 1
    case counter = 2
}

struct ProfileType {
    static var unknown: UInt8 = 0
    static var none: UInt8 = 1
    static var strict: UInt8 = 2
    static var forChild: UInt8 = ProfileType.strict | 4
}

struct ActionType {
    static var none: UInt8 = 0
    static var removeFavorite: UInt8 = 1
    static var addFavorite: UInt8 = 2
    static var shareVideo: UInt8 = 4
    static var copyLink: UInt8 = 8
    static var likeVideo: UInt8 = 16
    static var searchVideos: UInt8 = 32
    static var all: UInt8 = ActionType.removeFavorite |
        ActionType.addFavorite |
        ActionType.shareVideo |
        ActionType.copyLink |
        ActionType.likeVideo |
        ActionType.searchVideos
}

// MARK: Sys env.

struct ScreenSize {
    static let width         = UIScreen.main.bounds.size.width
    static let height        = UIScreen.main.bounds.size.height
    static let maxOfHeightWidth    = max(ScreenSize.width, ScreenSize.height)
    static let minOfHeightWidth    = min(ScreenSize.width, ScreenSize.height)
}

struct DeviceType {
    static let IS_IPHONE            = UIDevice.current.userInterfaceIdiom == .phone
    static let IS_IPHONE_4_OR_LESS  = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.maxOfHeightWidth < 568.0
    static let IS_IPHONE_5          = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.maxOfHeightWidth == 568.0
    static let IS_IPHONE_6          = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.maxOfHeightWidth == 667.0
    static let IS_IPHONE_6P         = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.maxOfHeightWidth == 736.0
    static let IS_IPHONE_7          = IS_IPHONE_6
    static let IS_IPHONE_7P         = IS_IPHONE_6P
    static let IS_IPHONE_X          = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.maxOfHeightWidth == 812.0
    static let IS_IPAD              = UIDevice.current.userInterfaceIdiom == .pad && ScreenSize.maxOfHeightWidth == 1024.0
    static let IS_IPAD_PRO_9_7      = IS_IPAD
    static let IS_IPAD_PRO_12_9     = UIDevice.current.userInterfaceIdiom == .pad && ScreenSize.maxOfHeightWidth == 1366.0
    static let IS_TV                = UIDevice.current.userInterfaceIdiom == .tv
    static let IS_CAR_PLAY          = UIDevice.current.userInterfaceIdiom == .carPlay
    
    static func isIPad() -> Bool {
        return DeviceType.IS_IPAD || DeviceType.IS_IPAD_PRO_12_9 || DeviceType.IS_IPAD_PRO_9_7
    }
    
    static func isIPhone() -> Bool {
        return !isTv() && !isIPad()
    }
    
    static func isTv() -> Bool {
        return DeviceType.IS_TV
    }
    
}

// MARK: App notification definitions

let GoogleAuthUINotificationId: String = "GoogleAuthUINotification"

// MARK: Prohibited regexp symbols definition

let prohibitedYoutubeRegex: String = "[!@#$%^&*()\\.\\:;,<>\\?\\[\\]\\{\\}]+"
let extraSpaceRegex: String = "[ ]{2,}"

// MARK: Reusable CollectionView identificators

let RUIVideosCollectionYouTubeSupplementaryViewId: String = "RUIVideosCollectionYouTubeSupplementaryViewId"
let RUIVideosCollectionCellId: String = "RUIVideosCollectionCellId"
let RUIVideosCollectionEmptyCellId: String = "RUIVideosCollectionEmptyCellId"
let RUIUndefinedCollectionCellId: String = "RUIUndefinedCollectionCellId"

let RUINodeViewId: String = "RUINodeViewId"
let RUINewNodeViewId: String = "RUINewNodeViewId"

// MARK: Reusable TableView identificators

let UITableViewCellId: String = "UITableViewCellId"
let UISwipedTableViewCellId: String = "UISwipedTableViewCellId"
let UITableViewEmptyCellId: String = "UITableViewEmptyCellId"
let UITableViewTextEditCellId: String = "UITableViewTextEditCellId"
let UITableViewPswdEditCellId: String = "UITableViewPswdEditCellId"
let UITableViewCheckMarkCellId: String = "UITableViewCheckMarkCellId"
let UITableViewSwitchCellId: String = "UITableViewSwitchCellId"
let UITableViewSliderCellId: String = "UITableViewSliderCellId"
let UIDetailedTableViewCellId: String = "UIDetailedTableViewCellId"

let RUITableFooterViewId: String = "RUITableFooterViewId"
let RUITableHeaderViewId: String = "RUITableHeaderViewId"
let RUITableHeaderButtonViewId: String = "RUITableHeaderButtonViewId"
let RUITableFooterButtonViewId: String = "RUITableFooterButtonViewId"

