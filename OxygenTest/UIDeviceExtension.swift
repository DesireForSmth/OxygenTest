//
//  UIDeviceExtension.swift
//  OxygenTest
//
//  Created by Александр Сетров on 05.04.2021.
//

import Foundation
import UIKit

extension UIDevice {

    private struct Constants {
        static let devices: [String: String] = ["iPad2,1": "iPad 2",
                                                "iPad2,2": "iPad 2",
                                                "iPad2,3": "iPad 2",
                                                "iPad2,4": "iPad 2",
                                                "iPad3,1": "iPad (3rd generation)",
                                                "iPad3,2": "iPad (3rd generation)",
                                                "iPad3,3": "iPad (3rd generation)",
                                                "iPad3,4": "iPad (4th generation)",
                                                "iPad3,5": "iPad (4th generation)",
                                                "iPad3,6": "iPad (4th generation)",
                                                "iPad6,11": "iPad (5th generation)",
                                                "iPad6,12": "iPad (5th generation)",
                                                "iPad7,5": "iPad (6th generation)",
                                                "iPad7,6": "iPad (6th generation)",
                                                "iPad7,11": "iPad (7th generation)",
                                                "iPad7,12": "iPad (7th generation)",
                                                "iPad11,6": "iPad (8th generation)",
                                                "iPad11,7": "iPad (8th generation)",
                                                "iPad4,1": " iPad Air",
                                                "iPad4,2": "iPad Air",
                                                "iPad4,3": "iPad Air",
                                                "iPad5,3": "iPad Air 2",
                                                "iPad5,4": "iPad Air 2",
                                                "iPad11,3": "iPad Air (3rd generation)",
                                                "iPad11,4": "iPad Air (3rd generation)",
                                                "iPad13,1": "iPad Air (4th generation)",
                                                "iPad13,2": "iPad Air (4th generation)",
                                                "iPad2,5": "iPad mini",
                                                "iPad2,6": "iPad mini",
                                                "iPad2,7": "iPad mini",
                                                "iPad4,4": "iPad mini 2",
                                                "iPad4,5": "iPad mini 2",
                                                "iPad4,6": "iPad mini 2",
                                                "iPad4,7": "iPad mini 3",
                                                "iPad4,8": "iPad mini 3",
                                                "iPad4,9": "iPad mini 3",
                                                "iPad5,1": "iPad mini 4",
                                                "iPad5,2": "iPad mini 4",
                                                "iPad11,1": "iPad mini (5th generation)",
                                                "iPad11,2": "iPad mini (5th generation)",
                                                "iPad6,3": "iPad Pro (9.7-inch)",
                                                "iPad6,4": "iPad Pro (9.7-inch)",
                                                "iPad7,3": "iPad Pro (10.5-inch)",
                                                "iPad7,4": "iPad Pro (10.5-inch)",
                                                "iPad6,7": "iPad Pro (12.9-inch) (1st generation)",
                                                "iPad6,8": "iPad Pro (12.9-inch) (1st generation)",
                                                "iPad7,1": "iPad Pro (12.9-inch) (2nd generation)",
                                                "iPad7,2": "iPad Pro (12.9-inch) (2nd generation)",
                                                "iPad8,5": "iPad Pro (12.9-inch) (3rd generation)",
                                                "iPad8,6": "iPad Pro (12.9-inch) (3rd generation)",
                                                "iPad8,7": "iPad Pro (12.9-inch) (3rd generation)",
                                                "iPad8,8": "iPad Pro (12.9-inch) (3rd generation)",
                                                "iPad8,11": "iPad Pro (12.9-inch) (4th generation)",
                                                "iPad8,12": "iPad Pro (12.9-inch) (4th generation)",
                                                "iPod5,1": "iPod touch (5th generation)",
                                                "iPod7,1": "iPod touch (6th generation)",
                                                "iPod9,1": "iPod touch (7th generation)",
                                                "iPhone3,1": "iPhone 4",
                                                "iPhone3,2": "iPhone 4",
                                                "iPhone3,3": "iPhone 4",
                                                "iPhone4,1": "iPhone 4s",
                                                "iPhone5,1": "iPhone 5",
                                                "iPhone5,2": "iPhone 5",
                                                "iPhone5,3": "iPhone 5c",
                                                "iPhone5,4": "iPhone 5c",
                                                "iPhone6,1": "iPhone 5s",
                                                "iPhone6,2": "iPhone 5s",
                                                "iPhone7,2": "iPhone 6",
                                                "iPhone7,1": "iPhone 6 Plus",
                                                "iPhone8,1": "iPhone 6s",
                                                "iPhone8,2": "iPhone 6s Plus",
                                                "iPhone8,4": "iPhone SE",
                                                "iPhone9,1": "iPhone 7",
                                                "iPhone9,3": "iPhone 7",
                                                "iPhone9,2": "iPhone 7 Plus",
                                                "iPhone9,4": "iPhone 7 Plus",
                                                "iPhone10,1": "iPhone 8",
                                                "iPhone10,4": "iPhone 8",
                                                "iPhone10,2": "iPhone 8 Plus",
                                                "iPhone10,5": "iPhone 8 Plus",
                                                "iPhone10,3": "iPhone X",
                                                "iPhone10,6": "iPhone X",
                                                "iPhone11,2": "iPhone XS",
                                                "iPhone11,4": "iPhone XS Max",
                                                "iPhone11,6": "iPhone XS Max",
                                                "iPhone11,8": "iPhone XR",
                                                "iPhone12,1": "iPhone 11",
                                                "iPhone12,3": "iPhone 11 Pro",
                                                "iPhone12,5": "iPhone 11 Pro Max",
                                                "iPhone12,8": "iPhone SE (2nd generation)",
                                                "iPhone13,1": "iPhone 12 mini",
                                                "iPhone13,2": "iPhone 12",
                                                "iPhone13,3": "iPhone 12 Pro",
                                                "iPhone13,4": "iPhone 12 Pro Max",
                                                "i386": "Simulator",
                                                "x86_64": "Simulator"]
    }

    var modelName: String {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        func mapDevice(identifier: String) -> String {
            #if os(iOS)
            guard let device = Constants.devices[identifier] else {
                return identifier + " is not available now"
            }
            if device == "Simulator" {
                guard let result = Constants.devices[ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"]
                                                        ?? "iOS"] else { return device }
                return device + " " + result
            }
            return device
            #endif
        }
        return mapDevice(identifier: identifier)
    }

}
