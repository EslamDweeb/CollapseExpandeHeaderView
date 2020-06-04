//
//  TableViewCell.swift
//  CollapseExpandHeaderView_ED
//
//  Created by eslam dweeb on 6/4/20.
//  Copyright © 2020 eslam dweeb. All rights reserved.
//

import UIKit

class TableViewCell:UICollectionViewCell{
    static let reuseId = "cell"
    lazy var tableView:UITableView = {
       let table = UITableView()
        table.tableFooterView = UIView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: TableViewCell.reuseId)
        return table
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    fileprivate func setupView(){
        addSubViews()
        addConstraints()
    }
    fileprivate func addSubViews(){
        addSubview(tableView)
    }
    fileprivate func addConstraints(){
        tableView.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor,padding: .init(top: 8, left: 8, bottom: 8, right: 8))
    }
}
