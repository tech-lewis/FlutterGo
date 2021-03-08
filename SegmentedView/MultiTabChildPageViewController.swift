//
//  MultiTabChildPageViewController.swift
//  WanTongTian
//
//  Created by sjty on 2020/8/3.
//  Copyright © 2020 liujing. All rights reserved.
//

import UIKit
import Foundation

protocol MultiTabChildPageDelegate: NSObjectProtocol {
    func commonTabChildViewController(_ viewController: MultiTabChildPageViewController, scrollViewDidScroll scrollView: UIScrollView)
}

class MultiTabChildPageViewController: UIViewController {

    // 主要用来控制mainScrollView在上下滑动的时候在没到阈值的时候让child view相对静止
    public var offsetY: CGFloat = 0.0
    public var isCanScroll: Bool = false
    public weak var scrollDelegate: MultiTabChildPageDelegate?
    public func getScrollView () -> UIScrollView? {
        return nil
    }
}
