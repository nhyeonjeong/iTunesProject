//
//  UIView+Extension.swift
//  iTunes
//
//  Created by 남현정 on 2024/04/06.
//

import UIKit

extension UIView {
    static var identifier: String {
        String(describing: self)
    }
    
    func addviews(_ views: [UIView]) {
        for view in views {
            addSubview(view)
        }
    }
}
