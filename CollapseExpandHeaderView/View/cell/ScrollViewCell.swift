//
//  ScrollViewCell.swift
//  CollapseExpandHeaderView_ED
//
//  Created by eslam dweeb on 6/4/20.
//  Copyright © 2020 eslam dweeb. All rights reserved.
//

import UIKit

class ScrollViewCell:UICollectionViewCell {
    lazy var containerView = UIView()
    lazy var scrollView : UIScrollView = {
       let scrollView = UIScrollView()
        scrollView.addSubview(containerView)
        containerView.anchor(top: scrollView.topAnchor, leading: scrollView.leadingAnchor, bottom: scrollView.bottomAnchor, trailing: scrollView.trailingAnchor)
        containerView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        return scrollView
    }()
    lazy var firstView:UIView = {
       let v = UIView()
        v.backgroundColor = .systemPurple
        return v
    }()
    lazy var secondView:UIView = {
       let v = UIView()
        v.backgroundColor = .systemTeal
        return v
    }()
    lazy var thirdView:UIView = {
       let v = UIView()
        v.backgroundColor = .systemYellow
        return v
    }()
    lazy var fourthView:UIView = {
       let v = UIView()
        v.backgroundColor = .systemBlue
        return v
    }()
    lazy var stackView = VerticalStackView(arrangedSubviews: [firstView,secondView,thirdView,fourthView], spacing: 20)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    fileprivate func setupView(){
        stackView.distribution = .fillEqually
        addSubViews()
        addconstraints()
    }
    fileprivate func addSubViews(){
        addSubview(scrollView)
        containerView.addSubview(stackView)
    }
    fileprivate func addconstraints(){
        scrollView.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor)
        firstView.translatesAutoresizingMaskIntoConstraints = false
        firstView.heightAnchor.constraint(equalToConstant: 250).isActive = true
        stackView.anchor(top: containerView.topAnchor, leading: containerView.leadingAnchor, bottom: containerView.bottomAnchor, trailing: containerView.trailingAnchor,padding: .init(top: 8, left: 8, bottom: 8, right: 8))
    }
}
