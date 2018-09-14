//
//  SlideBar.swift
//  SlideBar
//


import UIKit

public class SlideBar: UICollectionView, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    private var totalWidth: CGFloat = 0.0
    private var maxItemWidth: CGFloat = 0.0
    private var totalMaxWidth: CGFloat { return maxItemWidth * CGFloat(itemsTitle.count) }
    //MARK: - Variables
    
    public var output: SlideBarDelegate?
    
    public var itemsTitle: Array<String> = [] {
        didSet {
            calcArrangeConst()
            dataSource = self
            delegate   = self
            reloadData()
            selectItem(at: 0)
        }
    }
    private func calcArrangeConst(){
        if style.arrangeByWidth  == true {
            totalWidth = 0
            maxItemWidth = 0
            
            for item in itemsTitle {
                let width: CGFloat = getSize(forText: item, withFont: style.font).width + Constants.FrameValueAttributes.menuItemSpacing
                totalWidth += width
                maxItemWidth = max(maxItemWidth, width)
            }
        }
    }
    
    public var indicatorOffset: CGFloat = 0.0 {
        didSet {
            indicator.frame = CGRect(x: 7 + indicatorOffset,
                                     y: frame.height - 2.5,
                                     width: indicator.frame.width,
                                     height: 2.5)
        }
    }
    public var menuItemOffset: CGFloat = 0.0 {
        didSet {
            contentOffset = CGPoint(x: menuItemOffset, y: contentOffset.y)
        }
    }
    
    var style: SlideBarStyleProtocol = SlideBarStyleDefault() {
        didSet {
            setupStyle()
            reloadData()
        }
    }
    
    public var selectedIndex: Int = -1
    let indicator = CALayer()
    
    
//    MARK: - Instance initialization
    
    public override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        setup()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public convenience init(style: CommonSlideBarStyleProtocol) {
        let finalStyle = style.customStyle == nil ? style.baseStyle : style.customStyle!
        let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .horizontal
            layout.minimumInteritemSpacing = finalStyle.interItemSpacing
            layout.minimumLineSpacing = 0
            layout.sectionInset = UIEdgeInsets(top: 0.0, left: finalStyle.interItemSpacing, bottom: 0.0, right: finalStyle.interItemSpacing)
        
        self.init(frame: .zero, collectionViewLayout: layout)
        self.style = finalStyle
        setupStyle()
    }
    
    
//    MARK: - Interface methods
    
    public func selectItem(at index: Int) {
        if index != selectedIndex {
            selectedIndex = index
            
            let itemFrame = getItemFrame(at: IndexPath(item: selectedIndex, section: 0))
            let offset: CGFloat = contentOffset.x
            
            if abs(itemFrame.minX - offset) > itemFrame.width / 2.0 {
                if index == itemsTitle.count - 1 {
                    scrollToItem(at: IndexPath(item: selectedIndex, section: 0), at: .right, animated: true)
                } else {
                    scrollToItem(at: IndexPath(item: selectedIndex + 1, section: 0), at: .right, animated: true)
                }
            } else {
                if index == 0 {
                    scrollToItem(at: IndexPath(item: selectedIndex, section: 0), at: .left, animated: true)
                } else {
                    scrollToItem(at: IndexPath(item: selectedIndex - 1, section: 0), at: .left, animated: true)
                }
            }
            
            UIView.animate(withDuration: 0.25, animations: { [unowned self] in
                self.indicator.frame = CGRect(x: itemFrame.minX,
                                              y: self.frame.height - 2.5,
                                              width: itemFrame.width,
                                              height: 2.5)
                }, completion: { [unowned self] (finished) in
                    self.reloadData()
            })
            
        }
    }
    
    
//    MARK: - Private methods
    
    func setup() {
        indicator.frame = .zero
        layer.addSublayer(indicator)
        
        isUserInteractionEnabled = true
        delaysContentTouches = true
        contentInset = UIEdgeInsets.init(top: 0, left: 7, bottom: 0, right: 7)
        
        register(SlideBarCollectionViewCell.self, forCellWithReuseIdentifier: Constants.Identifiers.slideBarCell)
        showsHorizontalScrollIndicator = false
        isPagingEnabled = false
        delegate   = nil
        dataSource = nil
    }

    
    func setupStyle() {
        backgroundColor = style.backgroundColor
        indicator.backgroundColor = style.indicatorColor.cgColor
        calcArrangeConst()
    }
    
    
    func getSize(forText text: String, withFont font: UIFont) -> CGSize {
        let fontAttributes = [NSAttributedString.Key.font: font]
        return (text as NSString).size(withAttributes: fontAttributes)
    }
    
    
    func getItemFrame(at indexPath: IndexPath) -> CGRect {
        return cellForItem(at: indexPath)?.frame ?? .zero
    }
    
    
    func getItemSize(at indexPath: IndexPath) -> CGSize {
        var width: CGFloat = getSize(forText: itemsTitle[indexPath.item], withFont: style.font).width + Constants.FrameValueAttributes.menuItemSpacing
        //print("frame.width: \(self.frame.width), totalMaxWidth: \(totalMaxWidth), arrangeByWidth: \(style.arrangeByWidth)")
        if style.arrangeByWidth == true && (totalMaxWidth <= self.frame.width) {
            width = (self.frame.width - (contentInset.left + contentInset.right))/CGFloat(itemsTitle.count)
        }
        
        return CGSize(width: width, height: frame.height - 2.5)
    }
    
    
//    MARK: - Delegated methods
    
//    MARK: UICollectionViewDataSource
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemsTitle.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.Identifiers.slideBarCell,
                                                      for: indexPath) as! SlideBarCollectionViewCell
        cell.styleConfig = style
        cell.itemTitle = itemsTitle[indexPath.item]
        cell.isSelected = indexPath.item == selectedIndex
        cell.setup(forSelectedState: cell.isSelected)
        
        if (cell.isSelected && indicator.frame.isEmpty) {
            let cellFrame: CGRect = cell.frame;
            indicator.frame = CGRect.init(x: cellFrame.minX,
                                          y: frame.height - 2.5,
                                          width: cellFrame.width,
                                          height: 2.5)
        }
        
        return cell;
    }
    
    
//    MARK: UICollectionViewDelegate
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let oldIndex = selectedIndex
        selectItem(at: indexPath.item)

        output?.slideBar(self, didSelecteItemAtIndex: selectedIndex, didExecuteTransition: abs(selectedIndex - oldIndex) > 1)
    }
    
    
//    MARK: UICollectionViewDelegateFlowLayout
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        return getItemSize(at: indexPath)
    }
    
    
}
