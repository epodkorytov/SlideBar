//
//  SlideBarIO.swift
//  SlideBar
//


public protocol SlideBarOutput {
    
    func slideBarOutput(_ sender: SlideBar, didSelecteItemAtIndex index: Int, didExecuteTransition flag: Bool) 
    
}
