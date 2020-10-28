//
//  MyCourseRejectCourseDetailViewController.swift
//  ImageKnight
//
//  Created by mark on 2020/10/23.
//  Copyright © 2020 feijin. All rights reserved.
//
import UIKit
import ApplicationKit

class MyCourseRejectCourseDetailViewController: UIViewController {
  
  private let coverImageView = UIImageView()
  private let coureTitleLabel = UILabel()
  private let courseChannelLbel = UILabel()
  private let noticeLabel = UILabel()
  private let server = TableServer()
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
    updateUI()
  }
}

// MARK: - Public
extension MyCourseRejectCourseDetailViewController {
  
}

// MARK: - Setup
private extension MyCourseRejectCourseDetailViewController {
  func setupUI() {
    
    navigationView.setup(title: "我的课程")
    navigationView.showBack()
    self.view.backgroundColor = .white
    

    server.tableView.showsVerticalScrollIndicator = false
    server.tableView.backgroundColor = .white
    server.tableView.separatorStyle = .none
    view.addSubview(server.tableView)
    server.tableView.layout.add { (make) in
      make.top().equal(navigationView).bottom()
      make.leading().trailing().equal(view)
      make.bottom().equal(view).safeBottom()
    }
    
  
    view.bringSubviewToFront(navigationView)
  }
  
  func updateUI() {
//    self.coverImageView.image = UIImage(named: Placeholder.rectangle.name)

    
    let coverHeaderCell = ReuseItem(HeaderView.self)
    let spaceCell = ReuseItem(TableSpaceCell.self)
    let descriptionCell = ReuseItem(DescriptionCell.self)
    
    var groups: [TableSectionGroup] = []
    
    var section = TableSectionGroup()
    section.items.append(TableCellItem(coverHeaderCell))
    section.items.append(TableCellItem(spaceCell, height: 25))
    section.items.append(TableCellItem(descriptionCell))
    
    groups.append(section)
    server.update(groups)
  }
  
}

// MARK: - Action
private extension MyCourseRejectCourseDetailViewController {
  
}

// MARK: - Utiltiy
private extension MyCourseRejectCourseDetailViewController {
  
}
