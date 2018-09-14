//
//  SlideBarIO.swift
//  SlideBar
//


public protocol SlideBarDelegate {
    
    func slideBar(_ sender: SlideBar, didSelecteItemAtIndex index: Int, didExecuteTransition flag: Bool) 
    
}
