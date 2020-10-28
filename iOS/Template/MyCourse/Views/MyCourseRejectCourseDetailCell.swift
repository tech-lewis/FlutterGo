//
//  MyCourseRejectCourseDetailCell.swift
//  ImageKnight
//
//  Created by mark on 2020/10/23.
//  Copyright © 2020 feijin. All rights reserved.
//
import UIKit
import ApplicationKit

extension MyCourseRejectCourseDetailViewController {
 
  class TitleCell: UITableViewCell {
    private let titleLabel = UILabel()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
      super.init(style: style, reuseIdentifier: reuseIdentifier)
      setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
    }
    
  }
  
}

// MARK: - TableCellItemUpdatable
extension MyCourseRejectCourseDetailViewController.TitleCell: TableCellItemUpdatable {
  
  func update(with item: TableCellItem) {
   
    titleLabel.text = "这是一个作品标题"
    
  }
  
  func setupUI () {
    
    selectionStyle = .none
    contentView.backgroundColor = .white
    
    titleLabel.textColor = Color.textOfDeep
    titleLabel.font = Font.pingFangSCSemibold(17)
    titleLabel.numberOfLines = 0
    contentView.addSubview(titleLabel)
    titleLabel.layout.add { (make) in
      make.leading(0).top(10).trailing(-15).bottom(-10).equal(contentView)
    }
    
  }
  
}


extension MyCourseRejectCourseDetailViewController {
 
  class DescriptionCell: UITableViewCell {
    
    private let coureTitleLabel = UILabel()
    private let courseChannelLbel = UILabel()
    private let priceLabel = UILabel()
    
    private let noticeLabel = UILabel()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
      super.init(style: style, reuseIdentifier: reuseIdentifier)
      setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
    }
    
  }
  
}

// MARK: - TableCellItemUpdatable
extension MyCourseRejectCourseDetailViewController.DescriptionCell: TableCellItemUpdatable {
  
  func update(with item: TableCellItem) {
    coureTitleLabel.text = "这是一个作品标题"
    courseChannelLbel.text = "UI 设计"
    noticeLabel.text = "备注: 审核不通过的原因"
    
    let priceText = NSMutableAttributedString()
    priceText.append(NSAttributedString(string: "¥", attributes: [NSAttributedString.Key.font: Font.pingFangSCSemibold(13), NSAttributedString.Key.foregroundColor: Color.textOfRed]))
    priceText.append(NSAttributedString(string: String(format: "%.0f", 290.0), attributes: [NSAttributedString.Key.font: Font.pingFangSCSemibold(16), NSAttributedString.Key.foregroundColor: Color.textOfRed]))
    priceLabel.attributedText = priceText
  }
  
  func setupUI () {
    
    selectionStyle = .none
    contentView.backgroundColor = .white
    coureTitleLabel.textColor = Color.textOfDeep
    coureTitleLabel.font = Font.pingFangSCMedium(15)
    coureTitleLabel.numberOfLines = 1
    coureTitleLabel.textAlignment = .left
    contentView.addSubview(coureTitleLabel)
    coureTitleLabel.layout.add { (make) in
      make.top(15).equal(contentView)
      make.leading(15).trailing(-15).equal(contentView)
    }

    courseChannelLbel.textColor = Color.textOfLight
    courseChannelLbel.font = Font.pingFangSCMedium(12)
    courseChannelLbel.textAlignment = .left
    contentView.addSubview(courseChannelLbel)
    courseChannelLbel.layout.add { (make) in
      make.top(15).equal(coureTitleLabel).bottom()
      make.leading(15).trailing(-15).equal(contentView)
    }

    noticeLabel.textAlignment = .left
    noticeLabel.font = Font.pingFangSCMedium(12)
    noticeLabel.textColor = Color.textOfMedium
    contentView.addSubview(noticeLabel)
    noticeLabel.layout.add { (make) in

      make.top(15).equal(courseChannelLbel).bottom()
      make.leading(15).trailing(-15).equal(contentView)
    }
    
    priceLabel.textAlignment = .right
    priceLabel.textColor = Color.textOfRed
    priceLabel.font = Font.pingFangSCSemibold(13)
    contentView.addSubview(priceLabel)
    priceLabel.layout.add { (make) in

      make.centerY().equal(courseChannelLbel)
      make.trailing(-15).equal(contentView)
      make.hugging(axis: .horizontal)
    }
    
    
  }
  
}
