//
//  ViewController.swift
//  CollapseExpandHeaderView
//
//  Created by eslam dweeb on 6/4/20.
//  Copyright © 2020 eslam dweeb. All rights reserved.
//

import UIKit
import SwiftUI

class CollapseExpandHeaderVC: UIViewController {
    //MARK:- Variables and Constants
    let headerViewMaxHeight:CGFloat = 250
    let headerViewMinHeight:CGFloat = 50
    var headerConstraints:AnchoredConstraints?
    
    //MARK:- UIComponents
    
    lazy var headerView:UIView = {
        let v = UIView()
        v.backgroundColor = .systemBlue
        return v
    }()
    lazy var collectionView:UICollectionView = {
        let layout = ExpandableFlowLayout()
        layout.scrollDirection = .horizontal
        let coll = UICollectionView(frame: .zero, collectionViewLayout: layout)
        coll.backgroundColor = .white
        coll.delegate = self
        coll.dataSource = self
        coll.register(ScrollViewCell.self, forCellWithReuseIdentifier: ScrollViewCell.getIdentifier())
        coll.register(TableViewCell.self, forCellWithReuseIdentifier: TableViewCell.getIdentifier())
        return coll
    }()
    
    //MARK:- View LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    //MARK:- Helper Functions
    
    private func setupView(){
        addSubViews()
        addConstraints()
    }
    private func addSubViews(){
        view.addSubview(headerView)
        view.addSubview(collectionView)
    }
    private func addConstraints(){
        headerConstraints = headerView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor,size: .init(width: 0, height: headerViewMaxHeight))
        collectionView.anchor(top: headerView.bottomAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor)
    }
}


extension CollapseExpandHeaderVC:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.row {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ScrollViewCell.getIdentifier(), for: indexPath) as! ScrollViewCell
            cell.scrollView.delegate = self
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TableViewCell.getIdentifier(), for: indexPath) as! TableViewCell
            cell.tableView.delegate = self
            cell.tableView.dataSource = self
            return cell
        default:
            return UICollectionViewCell()
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.frame.size
    }
    
}
extension CollapseExpandHeaderVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.reuseId, for: indexPath)
        cell.textLabel?.text = "index: \(indexPath.row)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}
extension CollapseExpandHeaderVC : UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let y: CGFloat = scrollView.contentOffset.y
        guard let headerViewHeightConstraint = headerConstraints?.height else {return}
        let newHeaderViewHeight: CGFloat =
            headerViewHeightConstraint.constant - y
        if newHeaderViewHeight > headerViewMaxHeight {
            headerViewHeightConstraint.constant = headerViewMaxHeight
        } else if newHeaderViewHeight <= headerViewMinHeight {
            headerViewHeightConstraint.constant = headerViewMinHeight
        } else {
            headerViewHeightConstraint.constant = newHeaderViewHeight
            scrollView.contentOffset.y = 0 // block scroll view
        }
    }
}
struct CollapseExpandHeaderView: UIViewControllerRepresentable {
    func makeUIViewController(context: UIViewControllerRepresentableContext<CollapseExpandHeaderView>) -> UIViewController {
        let controller = CollapseExpandHeaderVC()
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: UIViewControllerRepresentableContext<CollapseExpandHeaderView>) {
        
    }
    
    typealias UIViewControllerType = UIViewController
}

struct CollapseExpandHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        CollapseExpandHeaderView()
            .edgesIgnoringSafeArea(.all)
    }
}
