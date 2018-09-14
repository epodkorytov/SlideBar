//
//  SlideBarStyle.swift
//  SlideBar
//

import UIKit

// MARK: - Protocols

public protocol CommonSlideBarStyleProtocol {
    var baseStyle: SlideBarStyleProtocol { set get }
    var customStyle: SlideBarStyleProtocol? { set get }
}

public protocol SlideBarStyleProtocol {
    // FONTS
    var font:       UIFont { set get }
    var activeFont: UIFont { set get }
    
    // COLOR PALETTE
    var backgroundColor: UIColor { set get }
    var fontColor:       UIColor { set get }
    var activeFontColor: UIColor { set get }
    var indicatorColor:  UIColor { set get }
    var bgColor:         UIColor { set get }
    
    // FRAME VALUE ATTRIBUTES
    var interItemSpacing: CGFloat { set get }
    var arrangeByWidth: Bool { set get }
}


// MARK: - Structs
struct SlideBarStyleDefault: SlideBarStyleProtocol {
    // FONTS
    public var font: UIFont       = .systemFont(ofSize: 14.0)
    public var activeFont: UIFont = .boldSystemFont(ofSize: 14.0)
    
    // COLOR PALETTE
    public var backgroundColor: UIColor = .clear
    public var fontColor: UIColor       = .white
    public var activeFontColor: UIColor = .white
    public var indicatorColor: UIColor  = .white
    public var bgColor: UIColor         = .clear
    
    // FRAME VALUE ATTRIBUTES
    public var interItemSpacing: CGFloat = 0.0
    
    public var arrangeByWidth: Bool = true
    
    public init() {}
}

public struct CommonSlideBarStyle: CommonSlideBarStyleProtocol {
    public var baseStyle:   SlideBarStyleProtocol = SlideBarStyleDefault()
    public var customStyle: SlideBarStyleProtocol?
    
    public init() {}
}



