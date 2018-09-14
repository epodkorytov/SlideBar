//
//  ViewController.swift
//  Example
//
//  Created by Nik Voloshyn on 22.09.17.
//  Copyright © 2017 Nick Voloshyn. All rights reserved.
//

import UIKit
import SlideBar

class ViewController: UIViewController, SlideBarDelegate {

//    MARK: - Constants
    
    private let SLIDE_BAR_HEIGHT: CGFloat = 44.0
    
    
//    MARK: - Overriden methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let style = CommonSlideBarStyle()
        let slideMenu = SlideBar(style: style)
            slideMenu.itemsTitle = ["All", "Active", "History"]
            slideMenu.output = self
        
        view.backgroundColor = .orange

        view.addSubview(slideMenu)
        slideMenu.translatesAutoresizingMaskIntoConstraints = false
        _ = ConstraintRoutines.constraintFor(slideMenu, attribute: .top, value: 20.0, toView: view)
        _ = ConstraintRoutines.constraintFor(slideMenu, attribute: .leading, toView: view)
        _ = ConstraintRoutines.constraintFor(slideMenu, attribute: .trailing, toView: view)
        _ = ConstraintRoutines.constraintFor(slideMenu, attribute: .height, value: SLIDE_BAR_HEIGHT)
    }
    
    
//    MARK : - Delegated methods

//    MARK: SlideMenuOutput
    
    func slideBar(_ sender: SlideBar, didSelecteItemAtIndex index: Int, didExecuteTransition flag: Bool) {
        print("did select index \(index)")
    }

}

