//
//  CHPagedScrollView.swift
//  CHPagedScrollView
//
//  Created by Christos Hadjikyriacos on 19/10/16.
//  Copyright © 2016 Christos Hadjikyriacos. All rights reserved.
//



import UIKit



@objc protocol CHPagedScrollViewDelegate:class {
    @objc optional func pountoScrollView(_ pountoScrollView:CHPagedScrollView, didScrollToIndex index:Int, currentView:UIView)
    @objc optional func pountoScrollView(_ pountoScrollView:CHPagedScrollView, didSelectView view:UIView, atIndex index:Int)
}


class CHPagedScrollViewTapGesture:UITapGestureRecognizer {
    var index:Int?
    
}

class CHPagedScrollView: UIScrollView,UIScrollViewDelegate {
    
    
    fileprivate func frameForIndex(_ index:Int) -> CGRect {
        let x = bounds.width * CGFloat(index)
        return CGRect(origin: CGPoint(x:x,y:0), size: bounds.size)
    }
    
    
    weak var chPagedScrollViewDelegate:CHPagedScrollViewDelegate?
    
    fileprivate func setup() {
        canCancelContentTouches = false
        alwaysBounceVertical = false
        isPagingEnabled = true
        delegate = self
        clipsToBounds = true
        indicatorStyle = UIScrollViewIndicatorStyle.white
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func scrollAtIndex(_ index:Int) {
        guard index >= 0 && index < pageViews.count else{return}
        let frame = pageViews[index].frame
        scrollRectToVisible(frame, animated: true)
    
    }
    
    internal func didTouchView(_ gesture:CHPagedScrollViewTapGesture) {
        guard let view = gesture.view , let index = gesture.index else {return}
        chPagedScrollViewDelegate?.pountoScrollView?(self, didSelectView: view, atIndex: index)
    }
    
    
    fileprivate func gestureForIndex(_ index:Int) -> CHPagedScrollViewTapGesture {
        let selector = #selector(didTouchView(_:))
        let gesture = CHPagedScrollViewTapGesture(target: self, action: selector)
        gesture.index = index
        return gesture
        
    }
    
    var pageViews = [UIView]() {
        didSet {
            _ = oldValue.map({$0.removeFromSuperview()})
            _ = pageViews.enumerated().map { (index,view) -> Void in
                view.frame = frameForIndex(index)
                view.addGestureRecognizer(gestureForIndex(index))
                addSubview(view)
            }
            let newWidth = CGFloat(pageViews.count) * bounds.width
            contentSize = CGSize(width:newWidth,height: bounds.height)
        }
    }
    
    
    var currentPage:(offset:Int,element:UIView)? {
        didSet {
            
            guard let currentPage = currentPage , oldValue == nil || currentPage.element != oldValue!.element  else {return}
            
            chPagedScrollViewDelegate?.pountoScrollView?(self, didScrollToIndex: currentPage.offset, currentView: currentPage.element)
            
            
            
            
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if let object = pageViews
            .enumerated()
            .filter({scrollView.bounds.intersects($0.element.frame)})
            .first {
            currentPage = object
        }
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        _ = pageViews.enumerated().map({$0.element.frame = self.frameForIndex($0.offset)})
        let newWidth = CGFloat(pageViews.count) * bounds.width
        contentSize = CGSize(width:newWidth,height: bounds.height)
    }
}

