//
//  HelperTableView.swift
//  CollapseExpandHeaderView_ED
//
//  Created by eslam dweeb on 6/5/20.
//  Copyright © 2020 eslam dweeb. All rights reserved.
//

import UIKit
class HelperTableView : UITableView {
    override var adjustedContentInset: UIEdgeInsets {
         if self.frame.height > contentSize.height  {
              let heightBottom =
                  ( self.frame.height - contentSize.height ) + 0.5
            return UIEdgeInsets(
                   top: self.contentInset.top + 0.5 ,
                   left: self.contentInset.left ,
                   bottom: heightBottom ,
                  right: self.contentInset.right )
         }
      return UIEdgeInsets(
             top: self.contentInset.top + 0.5 ,
             left: self.contentInset.left ,
             bottom: self.contentInset.right ,
            right: self.contentInset.right )
    }
}
