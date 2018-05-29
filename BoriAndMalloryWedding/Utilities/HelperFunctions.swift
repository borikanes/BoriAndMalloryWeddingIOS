//
//  HelperFunctions.swift
//  BoriAndMalloryWedding
//
//  Created by Bori Oludemi on 5/25/18.
//  Copyright © 2018 borikanes. All rights reserved.
//

import UIKit

func isIphone5AndBelow() -> Bool {
    if let currentModelSimulator = ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] {
        return (currentModelSimulator.range(of: "iPhone5") != nil ||
            currentModelSimulator.range(of: "iPhone3") != nil ||
            currentModelSimulator.range(of: "iPhone4") != nil ||
            currentModelSimulator.range(of: "iPhone6") != nil ||
            currentModelSimulator.range(of: "iPhone8,4") != nil)
    }
    let currentModel = UIDevice.current.modelName

    return (currentModel.range(of: "iPhone5") != nil ||
       currentModel.range(of: "iPhone3") != nil ||
       currentModel.range(of: "iPhone4") != nil ||
       currentModel.range(of: "iPhone6") != nil ||
       currentModel.range(of: "iPhone8,4") != nil)
}

func isIphone10() -> Bool {
    if let currentModelSimulator = ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] {
        return (currentModelSimulator.range(of: "iPhone10,3") != nil ||
            currentModelSimulator.range(of: "iPhone10,6") != nil)
    }
    
    let currentModel = UIDevice.current.modelName
    
    return (currentModel.range(of: "iPhone10,3") != nil ||
        currentModel.range(of: "iPhone10,6") != nil)
}

func isIpadPro129() -> Bool {
    if let currentModelSimulator = ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] {
        return (currentModelSimulator.range(of: "iPad6,7") != nil ||
            currentModelSimulator.range(of: "iPad6,8") != nil ||
            currentModelSimulator.range(of: "iPad7,1") != nil ||
            currentModelSimulator.range(of: "iPad7,2") != nil )
    }
    
    let currentModel = UIDevice.current.modelName

    return (currentModel.range(of: "iPad6,7") != nil ||
            currentModel.range(of: "iPad6,8") != nil ||
            currentModel.range(of: "iPad7,1") != nil ||
            currentModel.range(of: "iPad7,2") != nil )
}

func isPlusPhone() -> Bool {
    if let currentModelSimulator = ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] {
        return (currentModelSimulator.range(of: "iPhone7,1") != nil ||
            currentModelSimulator.range(of: "iPhone8,2") != nil ||
            currentModelSimulator.range(of: "iPhone9,2") != nil ||
            currentModelSimulator.range(of: "iPhone9,4") != nil ||
            currentModelSimulator.range(of: "iPhone10,2") != nil ||
            currentModelSimulator.range(of: "iPhone10,5") != nil)
    }
    
    let currentModel = UIDevice.current.modelName
    
    return (currentModel.range(of: "iPhone7,1") != nil ||
        currentModel.range(of: "iPhone8,2") != nil ||
        currentModel.range(of: "iPhone9,2") != nil ||
        currentModel.range(of: "iPhone9,4") != nil ||
        currentModel.range(of: "iPhone10,2") != nil ||
        currentModel.range(of: "iPhone10,5") != nil)
}

func isIpad105() -> Bool {
    if let currentModelSimulator = ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] {
        return (currentModelSimulator.range(of: "iPad7,4") != nil ||
            currentModelSimulator.range(of: "iPad7,3") != nil )
    }
    
    let currentModel = UIDevice.current.modelName
    
    return (currentModel.range(of: "iPad7,4") != nil ||
        currentModel.range(of: "iPad7,3") != nil )
}
