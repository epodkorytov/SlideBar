//
//  ConstraintRoutines.swift
//  faceList
//


import UIKit

class ConstraintRoutines {
    
    class func constraintFor(_ subview: UIView,
                             attribute: NSLayoutConstraint.Attribute,
                             value: CGFloat = 0.0,
                             toView: Any? = nil,
                             attribute2: NSLayoutConstraint.Attribute = .notAnAttribute,
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
