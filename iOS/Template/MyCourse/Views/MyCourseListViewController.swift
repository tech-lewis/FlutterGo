//
//  MyCourseListViewController.swift
//  ImageKnight
//
//  Created by mark on 2020/10/23.
//  Copyright © 2020 feijin. All rights reserved.
//

import UIKit
import ApplicationKit

class MyCourseListViewController: UIViewController {
  
  enum CourseType {
    case all
    case sales
    case removed //下架
    case reviewing
    case reject
  }
  
  public var listType: CourseType? = nil
  private let server = TableServer()
  private var models = [HistoryListModel]()
  lazy var jxListView = JXSegmentedWeakListContainer(container: self.view)
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupUI()
    //updateUI()
    guard self.listType != nil else {
      return
    }
    //loadData()
    self.updateUI()
    //setupListView(autoLoad: true, canRefresh: true, canLoadMore: true, hasLoadingView: true)
    
  }
  func loadData() {
    // 加载数据
      
      API.myStudyRecord.query(nil).headerField(API.tokenParameters).request { (res) in
        // 我课程学习记录
        self.hideLoading()
        guard res["result"] == 1 else {return}
        self.models = res["data"]["list"].map({ HistoryListModel(list: $0.json) })
        
      }
  }
}

// MARK: - Public :ViewControllerListable
extension MyCourseListViewController {

  
//  func loadData(_ isNext: Bool, completion handle: @escaping () -> Void) {
//
//  }
  
//  // 加载网络数据
//  var listController: UIViewController { return self }
//
//   var listView: UIScrollView { return self.server.tableView }
//   // 处理分页的情况
//   var listDataModel: DataModelListable {return self.models}
  
}

// MARK: - Setup
private extension MyCourseListViewController {
  
  func setupUI() {
    
    navigationView.isHidden = true
    
    let emptyView = EmptyView.create()
    server.emptyContentView = emptyView
    server.tableView.showsVerticalScrollIndicator = false
    server.tableView.separatorStyle = .none
    server.tableView.backgroundColor = .white
    view.addSubview(server.tableView)
    server.tableView.layout.add { (make) in
      make.leading().top().trailing().equal(view)
      make.bottom().equal(view).safeBottom()
    }
    
  }
  
  func updateUI() {
    
    let timeCell = ReuseItem(HistoryTimeCell.self)
    let spaceCell = ReuseItem(TableSpaceCell.self)
    let cell = ReuseItem(MyCourseListCell.self)
    
    var groups: [TableSectionGroup] = []
    
    
    (0...5).enumerated().forEach { (index, _) in
      
      var group = TableSectionGroup()
      group.header.height = 15
      group.footer.height = 5
      group.items.append(TableCellItem(cell))
      groups.append(group)
    }
  
    server.update(groups)
    
  }
  
}

// MARK: - Action
private extension MyCourseListViewController {
  
}

// MARK: - Utiltiy
private extension MyCourseListViewController {
  
}
