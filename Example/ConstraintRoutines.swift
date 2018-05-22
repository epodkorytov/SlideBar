//
//  ConstraintRoutines.swift
//  faceList
//
//  Created by Nik Voloshyn on 18.09.17.
//  Copyright © 2017 Nick Voloshyn. All rights reserved.
//

import UIKit

class ConstraintRoutines {
    
    class func constraintFor(_ subview: UIView,
                             attribute: NSLayoutAttribute,
                             value: CGFloat = 0.0,
                             toView: Any? = nil,
                             attribute2: NSLayoutAttribute = .notAnAttribute,
                             active: Bool = true) -> NSLayoutConstraint
    {
        let result = NSLayoutConstraint(item: subview,
                                        attribute: attribute,
                                        relatedBy: .equal,
                                        toItem: toView,
                                        attribute: attribute2 == .notAnAttribute ? attribute : attribute2,
                                        multiplier: 1.0,
                                        constant: value)
        result.isActive = active
        return result
    }
    
}
