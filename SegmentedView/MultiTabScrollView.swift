//
//  MultiTabScrollView.swift
//  WanTongTian
//
//  Created by sjty on 2020/8/3.
//  Copyright © 2020 liujing. All rights reserved.
//

import UIKit
import Foundation

class MultiTabTableView: UITableView, UIGestureRecognizerDelegate {

    public var scrollViewWhites: Set<UIScrollView>?
    
    override func touchesShouldCancel(in view: UIView) -> Bool {
        return true
    }

    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        guard let scrollViewWhites = scrollViewWhites else { return true }
        for item in scrollViewWhites {
            if let view = otherGestureRecognizer.view, view == item {
                return true
            }
        }
        return true
    }
}
