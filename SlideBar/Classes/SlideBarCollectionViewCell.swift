//
//  SlideBarCollectionViewCell.swift
//  SlideBar
//


import UIKit

class SlideBarCollectionViewCell: UICollectionViewCell {
    
    
//    MARK: - Variables
    
    var itemTitle: String = "" {
        didSet {
            titleLabel.text = itemTitle
        }
    }
        
    var titleLabel = UILabel()
    var styleConfig: SlideBarStyleProtocol!

    
//    MARK: - Instance initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

//    MARK: - Private methods
    
    private func setup() {
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        backgroundView = nil
        
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(titleLabel)
        
        _ = ConstraintRoutines.constraintFor(titleLabel, attribute: .top, toView: contentView)
        _ = ConstraintRoutines.constraintFor(titleLabel, attribute: .leading, toView: contentView)
        _ = ConstraintRoutines.constraintFor(titleLabel, attribute: .trailing, toView: contentView)
        _ = ConstraintRoutines.constraintFor(titleLabel, attribute: .bottom, toView: contentView)
    }
    
    
//    MARK: - Interface methods
    
    func setup(forSelectedState state: Bool) {
        titleLabel.font = state ? styleConfig.activeFont : styleConfig.font;
        titleLabel.textColor  = state ? styleConfig.activeFontColor : styleConfig.fontColor;
    }
    
}
