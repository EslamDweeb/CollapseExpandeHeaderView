//
//  UIStackView_Ext.swift
//  CollapseExpandHeaderView_ED
//
//  Created by eslam dweeb on 6/4/20.
//  Copyright © 2020 eslam dweeb. All rights reserved.
//

import UIKit

extension UIStackView {
    convenience init(arrangedSubviews: [UIView], customSpacing: CGFloat = 0) {
        self.init(arrangedSubviews: arrangedSubviews)
        self.spacing = customSpacing
    }
}
