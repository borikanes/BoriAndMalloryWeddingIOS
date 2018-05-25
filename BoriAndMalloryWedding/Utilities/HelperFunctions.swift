//
//  HelperFunctions.swift
//  BoriAndMalloryWedding
//
//  Created by Bori Oludemi on 5/25/18.
//  Copyright © 2018 borikanes. All rights reserved.
//

import UIKit

func isIphone5AndBelow() -> Bool {
    let currentModel = UIDevice.current.modelName

    return (currentModel.range(of: "iPhone5") != nil ||
       currentModel.range(of: "iPhone3") != nil ||
       currentModel.range(of: "iPhone4") != nil ||
       currentModel.range(of: "iPhone6") != nil ||
       currentModel.range(of: "iPhone8,4") != nil)
}

func isIphone10() -> Bool {
    let currentModel = UIDevice.current.modelName
    
    return (currentModel.range(of: "iPhone10,3") != nil ||
        currentModel.range(of: "iPhone10,6") != nil)
}
