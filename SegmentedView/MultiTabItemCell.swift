//
//  MultiTabItemCell.swift
//  WanTongTian
//
//  Created by sjty on 2020/8/3.
//  Copyright © 2020 liujing. All rights reserved.
//

import UIKit
import Foundation

class MultiTabItemCell: UICollectionViewCell {
  
  func configView(view: UIView) {
    self.contentView.addSubview(view)
    view.layout.add { (make) in
      make.leading().top().trailing().bottom().equal(self.contentView)
    }
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    initViews()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    // cell在重用之前需要将原有的subview清掉，防止重复多次add
    for subView in self.contentView.subviews {
      subView.removeFromSuperview()
    }
  }
  
  private func initViews() {
    self.contentView.backgroundColor = .white
  }
}

