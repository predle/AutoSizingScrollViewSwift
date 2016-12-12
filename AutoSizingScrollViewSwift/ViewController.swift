//
//  ViewController.swift
//  AutoSizingScrollViewSwift Using VFL(Visual Format Language)
//
//  Created by Beomseok Seo on 12/12/16.
//  Copyright © 2016 Beomseok Seo. All rights reserved.
//

import UIKit

//  구조
//  ScrollView
//      - ContentView
//          - SubView
//          - SubView
//          - SubView
//

class ViewController: UIViewController {
    
    weak var scrollView: UIScrollView?
    weak var contentView: UIView?
    
    var subViews: [UIView] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        addScrollViewTo(view: self.view)
        
        
        let insertViewButton = UIButton()
        insertViewButton.backgroundColor = UIColor.red
        insertViewButton.setTitle("Insert View", for: .normal)
        insertViewButton.translatesAutoresizingMaskIntoConstraints = false
        insertViewButton.addTarget(self, action: #selector(insertViewButtonPressed(_:)), for: .touchUpInside)
        self.view.addSubview(insertViewButton)
        
        let centerBtnXConstraint = NSLayoutConstraint(
            item: insertViewButton,
            attribute: .centerX,
            relatedBy: .equal,
            toItem: self.view,
            attribute: .centerX,
            multiplier: 1.0,
            constant: 0.0)
        
        self.view.addConstraint(centerBtnXConstraint)
        
        let views: [String:AnyObject] = ["updateButton":insertViewButton]
        
        let horizontalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:[updateButton(100)]",options: [], metrics: nil, views: views)
        insertViewButton.addConstraints(horizontalConstraints)
        
        let verticalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "V:[updateButton(50)]-8-|", options: [], metrics: nil, views: views)
        self.view.addConstraints(verticalConstraints)
        
    }
    
    func addScrollViewTo(view: UIView) {
        
        let scrollView: UIScrollView = UIScrollView()
        scrollView.backgroundColor = UIColor.red
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        self.scrollView = scrollView
        
        var views: [String : AnyObject] = ["scrollView":scrollView]
        var leftAndRightConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[scrollView]-0-|", options: [], metrics: nil, views: views)
        var topAndBottomConstraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[scrollView]-0-|", options: [], metrics: nil, views: views)
        
        view.addConstraints(leftAndRightConstraints)
        view.addConstraints(topAndBottomConstraints)
        
        let contentView: UIView = UIView()
        contentView.backgroundColor = UIColor.blue
        contentView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentView)
        self.contentView = contentView
        
        views = ["contentView": contentView, "scrollView": scrollView, "containerView": self.view]
        leftAndRightConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[contentView(==scrollView)]-0-|", options: [], metrics: nil, views: views)
        topAndBottomConstraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[contentView(>=0)]-0-|", options: [], metrics: nil, views: views)
        view.addConstraints(leftAndRightConstraints)
        view.addConstraints(topAndBottomConstraints)
        
    }
    
    func insertViewButtonPressed(_ sender: AnyObject) {
        
        let metrics = ["subViewHeight": NSNumber(value: 100), "verticalSpacing": NSNumber(value: 8)]
        let subView: UIView = UIView()
        subView.backgroundColor = UIColor.yellow
        subView.translatesAutoresizingMaskIntoConstraints = false
        
        // if already exist subView
        if let _lastSubView: UIView = self.subViews.last {
            
            // SubView 가 늘어남에 따라 ContentView 가 늘어나야함으로
            // 이미 추가한 Bottom Constraint 를 비활성화 시킨다.
            let constraint = self.contentView?.constraints.last
            constraint?.isActive = false
            
            self.contentView?.addSubview(subView)
            self.subViews.append(subView)
            
            let views: [String : AnyObject] = ["subView": subView, "lastSubView": _lastSubView]
            let leftAndRightConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[subView]-0-|", options: [], metrics: nil, views: views)
            let topAndBottomConstraints = NSLayoutConstraint.constraints(withVisualFormat: "V:[lastSubView]-verticalSpacing-[subView(subViewHeight)]|", options: [], metrics: metrics, views: views)
            self.contentView?.addConstraints(leftAndRightConstraints)
            self.contentView?.addConstraints(topAndBottomConstraints)
            
            return
        }
        
        // or not
        self.contentView?.addSubview(subView)
        self.subViews.append(subView)
        
        let views: [String : AnyObject] = ["subView":subView]
        let leftAndRightConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[subView]-0-|", options: [], metrics: nil, views: views)
        let topAndBottomConstraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[subView(subViewHeight)]|", options: [], metrics: metrics, views: views)
        self.contentView?.addConstraints(leftAndRightConstraints)
        self.contentView?.addConstraints(topAndBottomConstraints)
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

