//
//  MyCourseListCell.swift
//  ImageKnight
//
//  Created by mark on 2020/10/23.
//  Copyright © 2020 feijin. All rights reserved.
//
import UIKit
import ApplicationKit


class MyCourseListCell: UITableViewCell {
  
  struct DataModel {
    
    /// 是否编辑模式
    var isEditMode = false
    var isSelected = false
  }
  
  private let thumbView = UIImageView()
  private let namelabel = UILabel()
  private let subjectLabel = UILabel()
  private let priceLabel = UILabel()
  private let statusTextLabel = UILabel()
  private let selectStatusButton = UIButton(type: .custom)
  private let arrowView = UIImageView(image: UIImage(named: "arrow_right_gray"))
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    setupUI()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}

// MARK: - Action
extension MyCourseListCell {
  @objc func showDetail() {
    let controller = MyCourseRejectCourseDetailViewController()
    Presenter.push(controller)
  }
}
// MARK: - TableCellItemUpdatable
extension MyCourseListCell: TableCellItemUpdatable {
  
  func update(with item: TableCellItem) {
//    guard let historyData = item.data as? CourseItem else {
//      return
//    }
    
    thumbView.setImage(with:nil, placeholder: Placeholder.rectangle.name)
    namelabel.text = "课程课程名称"
    subjectLabel.text = "UI设计/CAD"
    
    
    // status
    // statusTextLabel.text = "上架"
    selectStatusButton.isHidden = true
    arrowView.isHidden = true
    
    // 审核不通过
    statusTextLabel.text = "审核不通过"
    selectStatusButton.isHidden = false
    arrowView.isHidden = false
    
    let priceText = NSMutableAttributedString()
    priceText.append(NSAttributedString(string: "¥", attributes: [NSAttributedString.Key.font: Font.pingFangSCSemibold(13), NSAttributedString.Key.foregroundColor: Color.textOfRed]))
    priceText.append(NSAttributedString(string: String(format: "%.0f", 1.1), attributes: [NSAttributedString.Key.font: Font.pingFangSCSemibold(16), NSAttributedString.Key.foregroundColor: Color.textOfRed]))

    priceLabel.attributedText = priceText
  }
  
}

// MARK: - Setup
private extension MyCourseListCell {
  
  func setupUI () {
    
    selectionStyle = .none
    contentView.backgroundColor = .white
    
    thumbView.contentMode = .scaleAspectFill
    thumbView.clipsToBounds = true
    thumbView.layer.cornerRadius = 5
    contentView.addSubview(thumbView)
    thumbView.layout.add { (make) in
      make.leading(15).top().bottom().equal(contentView)
      make.height(90)
      make.width().equal(thumbView).height().multiplier(135 / 90)
    }
    
    namelabel.textColor = Color.textOfDeep
    namelabel.font = Font.pingFangSCMedium(13)
    namelabel.numberOfLines = 2
    contentView.addSubview(namelabel)
    namelabel.layout.add { (make) in
      make.leading(10).equal(thumbView).trailing()
      make.top().trailing(-15).equal(contentView)
    }
    
    subjectLabel.textColor = Color.textOfLight
    subjectLabel.font = Font.pingFangSCRegular(11)
    contentView.addSubview(subjectLabel)
    subjectLabel.layout.add { (make) in
      make.top(8).equal(namelabel).bottom()
      make.leading().trailing().equal(namelabel)
    }
    
    
    statusTextLabel.textColor = Color.textOfMedium
    statusTextLabel.font = Font.pingFangSCRegular(12)
    contentView.addSubview(statusTextLabel)
    statusTextLabel.layout.add { (make) in
      make.top(4).equal(subjectLabel).bottom()
      make.leading().equal(namelabel)
      make.hugging(axis: .horizontal)
    }
    
    
    contentView.addSubview(arrowView)
    arrowView.layout.add { (make) in
      make.height(10).width(6)
      make.centerY().equal(statusTextLabel)
      make.leading(5).equal(statusTextLabel).trailing()
    }
    
    selectStatusButton.addTarget(self, action: #selector(showDetail), for: .touchDown)
    contentView.addSubview(selectStatusButton)
    selectStatusButton.layout.add { (make) in
      make.height(10)
      make.leading().top().equal(statusTextLabel)
      make.trailing().equal(arrowView)
    }
    
    priceLabel.textColor = Color.textOfRed
    priceLabel.font = Font.pingFangSCSemibold(14)
    contentView.addSubview(priceLabel)
    priceLabel.layout.add { (make) in
      make.leading().trailing().equal(namelabel)
      make.bottom().equal(contentView)
    }
    
  }
  
}
