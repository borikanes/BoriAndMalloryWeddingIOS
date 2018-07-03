//
//  UtilityExtensions.swift
//  BoriAndMalloryWedding
//
//  Created by Bori Oludemi on 5/25/18.
//  Copyright © 2018 borikanes. All rights reserved.
//

import UIKit

// https://stackoverflow.com/questions/28499701/how-can-i-change-the-uisearchbar-search-text-color
extension UISearchBar {
    
    var textColor:UIColor? {
        get {
            if let textField = self.value(forKey: "searchField") as?
                UITextField  {
                return textField.textColor
            } else {
                return nil
            }
        }
        
        set (newValue) {
            if let textField = self.value(forKey: "searchField") as?
                UITextField  {
                textField.textColor = newValue
            }
        }
    }
}

extension NSLayoutConstraint {
    /**
     Change multiplier constraint
     
     - parameter multiplier: CGFloat
     - returns: NSLayoutConstraint
     */
    func setMultiplier(multiplier:CGFloat) -> NSLayoutConstraint {

        NSLayoutConstraint.deactivate([self])

        let newConstraint = NSLayoutConstraint(
            item: firstItem as Any,
            attribute: firstAttribute,
            relatedBy: relation,
            toItem: secondItem,
            attribute: secondAttribute,
            multiplier: multiplier,
            constant: constant)

        newConstraint.priority = priority
        newConstraint.shouldBeArchived = self.shouldBeArchived
        newConstraint.identifier = self.identifier

        NSLayoutConstraint.activate([newConstraint])
        return newConstraint
    }
}

// https://stackoverflow.com/questions/11197509/how-to-get-device-make-and-model-on-ios/11197770#11197770
extension UIDevice {
    var modelName: String {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else {
                return identifier
            }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        return identifier
    }
}

/**
 //iPhone
 @"iPhone1,1" on iPhone
 @"iPhone1,2" on iPhone 3G
 @"iPhone2,1" on iPhone 3GS
 @"iPhone3,1" on iPhone 4 (GSM)
 @"iPhone3,3" on iPhone 4 (CDMA/Verizon/Sprint)
 @"iPhone4,1" on iPhone 4S
 @"iPhone5,1" on iPhone 5 (model A1428, AT&T/Canada)
 @"iPhone5,2" on iPhone 5 (model A1429, everything else)
 @"iPhone5,3" on iPhone 5c (model A1456, A1532 | GSM)
 @"iPhone5,4" on iPhone 5c (model A1507, A1516, A1526 (China), A1529 | Global)
 @"iPhone6,1" on iPhone 5s (model A1433, A1533 | GSM)
 @"iPhone6,2" on iPhone 5s (model A1457, A1518, A1528 (China), A1530 | Global)
 @"iPhone7,1" on iPhone 6 Plus
 @"iPhone7,2" on iPhone 6
 @"iPhone8,1" on iPhone 6S
 @"iPhone8,2" on iPhone 6S Plus
 @"iPhone8,4" on iPhone SE
 @"iPhone9,1" on iPhone 7 (CDMA)
 @"iPhone9,3" on iPhone 7 (GSM)
 @"iPhone9,2" on iPhone 7 Plus (CDMA)
 @"iPhone9,4" on iPhone 7 Plus (GSM)
 @"iPhone10,1" on iPhone 8 (CDMA)
 @"iPhone10,4" on iPhone 8 (GSM)
 @"iPhone10,2" on iPhone 8 Plus (CDMA)
 @"iPhone10,5" on iPhone 8 Plus (GSM)
 @"iPhone10,3" on iPhone X (CDMA)
 @"iPhone10,6" on iPhone X (GSM)
 
 //iPad 1
 @"iPad1,1" on iPad - Wifi (model A1219)
 @"iPad1,1" on iPad - Wifi + Cellular (model A1337)
 
 //iPad 2
 @"iPad2,1" - Wifi (model A1395)
 @"iPad2,2" - GSM (model A1396)
 @"iPad2,3" - 3G (model A1397)
 @"iPad2,4" - Wifi (model A1395)
 
 // iPad Mini
 @"iPad2,5" - Wifi (model A1432)
 @"iPad2,6" - Wifi + Cellular (model  A1454)
 @"iPad2,7" - Wifi + Cellular (model  A1455)
 
 //iPad 3
 @"iPad3,1" - Wifi (model A1416)
 @"iPad3,2" - Wifi + Cellular (model  A1403)
 @"iPad3,3" - Wifi + Cellular (model  A1430)
 
 //iPad 4
 @"iPad3,4" - Wifi (model A1458)
 @"iPad3,5" - Wifi + Cellular (model  A1459)
 @"iPad3,6" - Wifi + Cellular (model  A1460)
 
 //iPad AIR
 @"iPad4,1" - Wifi (model A1474)
 @"iPad4,2" - Wifi + Cellular (model A1475)
 @"iPad4,3" - Wifi + Cellular (model A1476)
 
 // iPad Mini 2
 @"iPad4,4" - Wifi (model A1489)
 @"iPad4,5" - Wifi + Cellular (model A1490)
 @"iPad4,6" - Wifi + Cellular (model A1491)
 
 // iPad Mini 3
 @"iPad4,7" - Wifi (model A1599)
 @"iPad4,8" - Wifi + Cellular (model A1600)
 @"iPad4,9" - Wifi + Cellular (model A1601)
 
 // iPad Mini 4
 @"iPad5,1" - Wifi (model A1538)
 @"iPad5,2" - Wifi + Cellular (model A1550)
 
 //iPad AIR 2
 @"iPad5,3" - Wifi (model A1566)
 @"iPad5,4" - Wifi + Cellular (model A1567)
 
 // iPad PRO 9.7"
 @"iPad6,3" - Wifi (model A1673)
 @"iPad6,4" - Wifi + Cellular (model A1674)
 @"iPad6,4" - Wifi + Cellular (model A1675)
 
 //iPad PRO 12.9"
 @"iPad6,7" - Wifi (model A1584)
 @"iPad6,8" - Wifi + Cellular (model A1652)
 
 //iPad (5th generation)
 @"iPad6,11" - Wifi (model A1822)
 @"iPad6,12" - Wifi + Cellular (model A1823)
 
 //iPad PRO 12.9" (2nd Gen)
 @"iPad7,1" - Wifi (model A1670)
 @"iPad7,2" - Wifi + Cellular (model A1671)
 @"iPad7,2" - Wifi + Cellular (model A1821)
 
 //iPad PRO 10.5"
 @"iPad7,3" - Wifi (model A1701)
 @"iPad7,4" - Wifi + Cellular (model A1709)
 
 //iPod Touch
 @"iPod1,1"   on iPod Touch
 @"iPod2,1"   on iPod Touch Second Generation
 @"iPod3,1"   on iPod Touch Third Generation
 @"iPod4,1"   on iPod Touch Fourth Generation
 @"iPod7,1"   on iPod Touch 6th Generation
 */
