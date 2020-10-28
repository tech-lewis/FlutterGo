//
//  MyCourseRejectCourseDetailHeaderCell.swift
//  ImageKnight
//
//  Created by mark on 2020/10/23.
//  Copyright © 2020 feijin. All rights reserved.
//
import UIKit
import ApplicationKit

extension MyCourseRejectCourseDetailViewController {
 
  class HeaderView: UITableViewCell {
    private let coverImageView = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
      super.init(style: style, reuseIdentifier: reuseIdentifier)
      setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
      coverImageView.contentMode = .scaleAspectFill
      contentView.addSubview(coverImageView)
      coverImageView.layout.add { (make) in
        make.leading().trailing().top().equal(contentView)
        make.height(App.shared.screen.width*188/375)
        make.bottom().equal(contentView)
      }
    }
  }
  
}

extension MyCourseRejectCourseDetailViewController.HeaderView: TableCellItemUpdatable {
  func update(with item: TableCellItem) {
    coverImageView.image = UIImage(named: Placeholder.rectangle.name)
    // 更新封面
    guard let coverUrl = item.data as? String else {
      return
    }
    coverImageView.setImage(with: coverUrl, placeholder: Placeholder.rectangle.name)
  }
  
  
}
